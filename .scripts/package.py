#!/usr/bin/env python3
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

def run(cmd, check=True, capture_output=False, text=True, **kwargs):
    if capture_output:
        return subprocess.run(cmd, shell=True, check=check, capture_output=True, text=text, **kwargs).stdout.strip()
    else:
        subprocess.run(cmd, shell=True, check=check, **kwargs)

def latest_release_number(repo):
    try:
        output = run(f"gh release list --repo {repo} --limit 1", capture_output=True)
        match = re.search(r"(\d+\.\d+\.\d+)", output)
        return match.group(1) if match else "0.0.0"
    except Exception:
        return "0.0.0"

def xcframework_name(path):
    return re.sub(r".*\/|\.xcframework(\.zip)?", "", path)

def resource_name(path):
    return os.path.basename(path)

def library_name(path):
    return path.split("/")[0]

def excludes(files):
    return [f for f in files if ".xcframework" not in f]

def trim_empty_lines(filepath):
    with open(filepath, 'r') as f:
        lines = [line for line in f if line.strip()]
    with open(filepath, 'w') as f:
        f.writelines(lines)

def template_replace(file, template, replacement):
    with open(file, 'r') as f:
        content = f.read()
    trim_empty_lines(replacement)
    with open(replacement, 'r') as f:
        rep_content = f.read()
    result = content.replace(template, rep_content)
    with open(file, 'w') as f:
        f.write(result)

def create_scratch(debug=False):
    scratch = tempfile.mkdtemp(prefix="TemporaryDirectory-")
    if debug:
        run(f"open {scratch}", check=False)
    return scratch

def rename_frameworks(prefix):
    for folder in Path('.').glob('*/'):
        for xc in folder.glob('*.xcframework'):
            name = xcframework_name(str(xc))
            new_name = f"{prefix}{name}.xcframework"
            xc.rename(xc.parent / new_name)

def zip_frameworks():
    for folder in Path('.').glob('*/'):
        for xc in folder.glob('*.xcframework'):
            name = xcframework_name(str(xc))
            zipfile = xc.parent / f"{name}.xcframework.zip"
            run(f"zip -ryqo '{zipfile}' '{xc.name}'", cwd=xc.parent)

def prepare_files_for_distribution(dist):
    os.makedirs(dist, exist_ok=True)
    for folder in Path('.').glob('*/'):
        for xc in folder.glob('*.xcframework'):
            shutil.copytree(xc, Path(dist) / xc.name, dirs_exist_ok=True)
        for zipf in folder.glob('*.xcframework.zip'):
            shutil.copy2(zipf, Path(dist) / zipf.name)

def generate_sources(sources):
    os.makedirs(sources, exist_ok=True)
    firebase_dir = Path(sources) / "Firebase"
    firebase_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2("Firebase.h", firebase_dir / "Firebase.h")
    shutil.copy2("module.modulemap", firebase_dir / "module.modulemap")
    (firebase_dir / "dummy.m").touch()
    for folder in Path('.').glob('*/'):
        name = library_name(str(folder))
        lib_dir = Path(sources) / name
        lib_dir.mkdir(exist_ok=True)
        (lib_dir / "dummy.swift").touch()
        res_dir = folder / "Resources"
        if res_dir.exists():
            shutil.copytree(res_dir, lib_dir / "Resources", dirs_exist_ok=True)
        for f in folder.iterdir():
            if f.name not in ["Resources"] and ".xcframework" not in f.name:
                if f.is_dir():
                    shutil.copytree(f, lib_dir / f.name, dirs_exist_ok=True)
                else:
                    shutil.copy2(f, lib_dir / f.name)

def write_library(library_path, output, comma):
    library = library_name(library_path)
    with open(output, 'a') as f:
        f.write(f"{comma}\n    .library(\n      name: \"{library}\",\n      targets: [\"{library}Target\"]\n    )")

def conditional_dependency(dependency_path, output_dir):
    name = xcframework_name(dependency_path)
    xc_dir = Path(output_dir) / f"{name}.xcframework"
    ios = any('ios-' in d.name for d in xc_dir.iterdir()) if xc_dir.exists() else False
    tvos = any('tvos-' in d.name for d in xc_dir.iterdir()) if xc_dir.exists() else False
    macos = any('macos-' in d.name for d in xc_dir.iterdir()) if xc_dir.exists() else False
    platforms = []
    if ios: platforms.append('.iOS')
    if tvos: platforms.append('.tvOS')
    if macos: platforms.append('.macOS')
    joined = ', '.join(platforms)
    if joined == '.iOS, .tvOS, .macOS':
        return f'"{name}"'
    else:
        return f'.target(name: "{name}", condition: .when(platforms: [{joined}]))'

def write_target(library_path, output, comma, output_dir):
    library = library_name(library_path)
    target = f"{library}Target"
    lib_dir = Path(library)
    dependencies = [f for f in os.listdir(library) if f.endswith('.xcframework.zip')]
    excludes_list = excludes(os.listdir(library))
    with open(output, 'a') as f:
        f.write(f"{comma}\n    .target(\n      name: \"{target}\",\n      dependencies: [\n        \"Firebase\"")
        if target != "FirebaseAnalyticsTarget":
            f.write(",\n        \"FirebaseAnalyticsTarget\"")
        for dep in dependencies:
            cond_dep = conditional_dependency(os.path.join(library, dep), output_dir)
            f.write(f",\n        {cond_dep}")
        f.write("\n      ]")
        f.write(f",\n      path: \"Sources/{library}\"")
        if excludes_list:
            f.write(",\n      exclude: [")
            comma2 = ""
            for exclude in excludes_list:
                f.write(f"{comma2}\n        \"{exclude}\"")
                comma2 = ","
            f.write("\n      ]")
        f.write("\n    )")

def write_binary(file, repo, version, output, comma):
    # Compute checksum
    run(f"touch Package.swift")
    checksum = run(f"swift package compute-checksum '{file}'", capture_output=True)
    name = xcframework_name(file)
    with open(output, 'a') as f:
        f.write(f"{comma}\n    .binaryTarget(\n      name: \"{name}\",\n      url: \"{repo}/releases/download/{version}/{name}.xcframework.zip\",\n      checksum: \"{checksum}\"\n    )")

def write_local_binary(file, dist, output, comma):
    name = xcframework_name(file)
    with open(output, 'a') as f:
        f.write(f"{comma}\n    .binaryTarget(\n      name: \"{name}\",\n      path: \"{dist}/{name}.xcframework\"\n    )")

def generate_swift_package(package, template, dist, repo, local_dist, latest):
    libraries = "libraries.txt"
    targets = "targets.txt"
    binaries = "binaries.txt"
    shutil.copy2(template, package)
    comma = ""
    for i in [f for f in os.listdir('.') if os.path.isdir(f) and not f.startswith('.')]:
        write_library(i, libraries, comma)
        comma = ","
    comma = ""
    for i in [f for f in os.listdir('.') if os.path.isdir(f) and not f.startswith('.')]:
        write_target(i, targets, comma, dist)
        comma = ","
    if local_dist:
        print("Creating local Package.swift for testing...")
        comma = ""
        for i in Path(dist).glob('*.xcframework'):
            write_local_binary(str(i), local_dist, binaries, comma)
            comma = ","
    else:
        print("Creating release Package.swift...")
        comma = ""
        for i in Path(dist).glob('*.xcframework.zip'):
            write_binary(str(i), repo, latest, binaries, comma)
            comma = ","
    template_replace(package, "// GENERATE LIBRARIES", libraries)
    os.remove(libraries)
    template_replace(package, "// GENERATE TARGETS", targets)
    os.remove(targets)
    template_replace(package, "// GENERATE BINARIES", binaries)
    os.remove(binaries)

def commit_changes(branch):
    run(f"git checkout -b {branch}")
    run("git add .")
    run("git commit -m'Updated Package.swift and sources for latest firebase sdks'")
    run(f"git push -u origin {branch}")
    run("gh pr create --fill")

def main():
    firebase_repo = "https://github.com/firebase/firebase-ios-sdk"
    xcframeworks_repo = "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks"
    latest = latest_release_number(firebase_repo)
    current = latest_release_number(xcframeworks_repo)
    debug = 'debug' in sys.argv
    skip_release = 'skip-release' in sys.argv
    if latest != current or debug:
        print(f"{current} is out of date. Updating to {latest}...")
        distribution = "dist"
        sources = "Sources"
        package = "Package.swift"
        scratch = create_scratch(debug)
        home = os.getcwd()
        os.chdir(scratch)
        print("Downloading latest release...")
        run(f"gh release download --pattern 'Firebase.zip' --repo {firebase_repo}")
        print("Unzipping..")
        run("unzip -q Firebase.zip")
        print("Preparing xcframeworks for distribution...")
        os.chdir("Firebase")
        rename_frameworks("_")
        zip_frameworks()
        print("Creating distribution files...")
        prepare_files_for_distribution(f"../{distribution}")
        print("Creating source files...")
        generate_sources(f"../{sources}")
        # Create test package using local binaries and make sure it builds
        generate_swift_package(f"../{package}", f"{home}/package_template.swift", f"../{distribution}", xcframeworks_repo, distribution, latest)
        print("Validating...")
        run(f"swift package dump-package", cwd="..")
        run(f"swift build", cwd="..")
        # Create release package using remote binaries and make sure the Package.swift file is parseable
        generate_swift_package(f"../{package}", f"{home}/package_template.swift", f"../{distribution}", xcframeworks_repo, '', latest)
        print("Validating...")
        run(f"swift package dump-package", cwd="..")
        os.chdir(home)
        print("Moving files to repo...")
        if os.path.exists(sources):
            shutil.rmtree(sources)
        if os.path.exists(package):
            os.remove(package)
        shutil.move(f"{scratch}/{sources}", sources)
        shutil.move(f"{scratch}/{package}", package)
        if skip_release:
            print("Done.")
            return
        print("Merging changes to Github...")
        commit_changes(f"release/{latest}")
        # Tag this commit to enable automatic release creation
        tag_exists = run(f"git rev-parse {latest}", check=False, capture_output=True)
        if tag_exists:
            print(f"Tag {latest} already exists. Skipping.")
        else:
            run(f"git tag {latest}")
            run(f"git push origin {latest}")
        print("Creating release")
        run(f"echo 'Release {latest}' | gh release create --target 'release/{latest}' --title 'Release {latest}' {latest} {scratch}/dist/*.xcframework.zip")
    else:
        print(f"{current} is up to date.")
    print("Done.")

if __name__ == "__main__":
    main()
