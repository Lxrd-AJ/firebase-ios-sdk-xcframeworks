// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Firebase",
  platforms: [.iOS(.v11), .macOS(.v10_12), .tvOS(.v12), .watchOS(.v7)],
  products: [
    .library(
      name: "FirebaseABTesting",
      targets: ["FirebaseABTestingTarget"]
    ),
    .library(
      name: "FirebaseAI",
      targets: ["FirebaseAITarget"]
    ),
    .library(
      name: "FirebaseAnalytics",
      targets: ["FirebaseAnalyticsTarget"]
    ),
    .library(
      name: "FirebaseAnalyticsOnDeviceConversion",
      targets: ["FirebaseAnalyticsOnDeviceConversionTarget"]
    ),
    .library(
      name: "FirebaseAppCheck",
      targets: ["FirebaseAppCheckTarget"]
    ),
    .library(
      name: "FirebaseAppDistribution",
      targets: ["FirebaseAppDistributionTarget"]
    ),
    .library(
      name: "FirebaseAuth",
      targets: ["FirebaseAuthTarget"]
    ),
    .library(
      name: "FirebaseCrashlytics",
      targets: ["FirebaseCrashlyticsTarget"]
    ),
    .library(
      name: "FirebaseDatabase",
      targets: ["FirebaseDatabaseTarget"]
    ),
    .library(
      name: "FirebaseDynamicLinks",
      targets: ["FirebaseDynamicLinksTarget"]
    ),
    .library(
      name: "FirebaseFirestore",
      targets: ["FirebaseFirestoreTarget"]
    ),
    .library(
      name: "FirebaseFunctions",
      targets: ["FirebaseFunctionsTarget"]
    ),
    .library(
      name: "FirebaseInAppMessaging",
      targets: ["FirebaseInAppMessagingTarget"]
    ),
    .library(
      name: "FirebaseMLModelDownloader",
      targets: ["FirebaseMLModelDownloaderTarget"]
    ),
    .library(
      name: "FirebaseMessaging",
      targets: ["FirebaseMessagingTarget"]
    ),
    .library(
      name: "FirebasePerformance",
      targets: ["FirebasePerformanceTarget"]
    ),
    .library(
      name: "FirebaseRemoteConfig",
      targets: ["FirebaseRemoteConfigTarget"]
    ),
    .library(
      name: "FirebaseStorage",
      targets: ["FirebaseStorageTarget"]
    ),
    .library(
      name: "FirebaseVertexAI",
      targets: ["FirebaseVertexAITarget"]
    ),
    .library(
      name: "Google-Mobile-Ads-SDK",
      targets: ["Google-Mobile-Ads-SDKTarget"]
    ),
    .library(
      name: "GoogleSignIn",
      targets: ["GoogleSignInTarget"]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Firebase",
      publicHeadersPath: "./"
    ),
    .target(
      name: "FirebaseABTestingTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseABTesting"
      ],
      path: "Sources/FirebaseABTesting"
    ),
    .target(
      name: "FirebaseAITarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAI",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension"
      ],
      path: "Sources/FirebaseAI"
    ),
    .target(
      name: "FirebaseAnalyticsTarget",
      dependencies: [
        "Firebase",
        "_FBLPromises",
        "_FirebaseAnalytics",
        "_FirebaseCore",
        "_FirebaseCoreInternal",
        "_FirebaseInstallations",
        "_GoogleAppMeasurement",
        "_GoogleAppMeasurementIdentitySupport",
        "_GoogleUtilities",
        "_nanopb"
      ],
      path: "Sources/FirebaseAnalytics"
    ),
    .target(
      name: "FirebaseAnalyticsOnDeviceConversionTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        .target(name: "_FirebaseAnalyticsOnDeviceConversion", condition: .when(platforms: [.iOS])),
        .target(name: "_GoogleAppMeasurementOnDeviceConversion", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAnalyticsOnDeviceConversion"
    ),
    .target(
      name: "FirebaseAppCheckTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_AppCheckCore",
        "_FirebaseAppCheck",
        "_FirebaseAppCheckInterop"
      ],
      path: "Sources/FirebaseAppCheck"
    ),
    .target(
      name: "FirebaseAppDistributionTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        .target(name: "_FirebaseAppDistribution", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAppDistribution"
    ),
    .target(
      name: "FirebaseAuthTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuth",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_GTMSessionFetcher",
        .target(name: "_RecaptchaInterop", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseAuth"
    ),
    .target(
      name: "FirebaseCrashlyticsTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseCoreExtension",
        "_FirebaseCrashlytics",
        "_FirebaseRemoteConfigInterop",
        "_FirebaseSessions",
        "_GoogleDataTransport",
        "_Promises"
      ],
      path: "Sources/FirebaseCrashlytics",
      exclude: [
        "run",
        "upload-symbols"
      ]
    ),
    .target(
      name: "FirebaseDatabaseTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseDatabase",
        "_FirebaseSharedSwift",
        "_leveldb"
      ],
      path: "Sources/FirebaseDatabase"
    ),
    .target(
      name: "FirebaseDynamicLinksTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        .target(name: "_FirebaseDynamicLinks", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseDynamicLinks"
    ),
    .target(
      name: "FirebaseFirestoreTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseCoreExtension",
        "_FirebaseFirestore",
        "_FirebaseFirestoreInternal",
        "_FirebaseSharedSwift",
        "_absl",
        "_grpc",
        "_grpcpp",
        "_leveldb",
        "_openssl_grpc"
      ],
      path: "Sources/FirebaseFirestore"
    ),
    .target(
      name: "FirebaseFunctionsTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_FirebaseFunctions",
        "_FirebaseMessagingInterop",
        "_FirebaseSharedSwift",
        "_GTMSessionFetcher"
      ],
      path: "Sources/FirebaseFunctions"
    ),
    .target(
      name: "FirebaseInAppMessagingTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseABTesting",
        .target(name: "_FirebaseInAppMessaging", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/FirebaseInAppMessaging"
    ),
    .target(
      name: "FirebaseMLModelDownloaderTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseCoreExtension",
        "_FirebaseMLModelDownloader",
        "_GoogleDataTransport",
        "_SwiftProtobuf"
      ],
      path: "Sources/FirebaseMLModelDownloader"
    ),
    .target(
      name: "FirebaseMessagingTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseMessaging",
        "_GoogleDataTransport"
      ],
      path: "Sources/FirebaseMessaging"
    ),
    .target(
      name: "FirebasePerformanceTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseABTesting",
        "_FirebaseCoreExtension",
        .target(name: "_FirebasePerformance", condition: .when(platforms: [.iOS, .tvOS])),
        "_FirebaseRemoteConfig",
        "_FirebaseRemoteConfigInterop",
        "_FirebaseSessions",
        "_FirebaseSharedSwift",
        "_GoogleDataTransport",
        "_Promises"
      ],
      path: "Sources/FirebasePerformance"
    ),
    .target(
      name: "FirebaseRemoteConfigTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseABTesting",
        "_FirebaseRemoteConfig",
        "_FirebaseRemoteConfigInterop",
        "_FirebaseSharedSwift"
      ],
      path: "Sources/FirebaseRemoteConfig"
    ),
    .target(
      name: "FirebaseStorageTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_FirebaseStorage",
        "_GTMSessionFetcher"
      ],
      path: "Sources/FirebaseStorage"
    ),
    .target(
      name: "FirebaseVertexAITarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        "_FirebaseAI",
        "_FirebaseAppCheckInterop",
        "_FirebaseAuthInterop",
        "_FirebaseCoreExtension",
        "_FirebaseVertexAI"
      ],
      path: "Sources/FirebaseVertexAI"
    ),
    .target(
      name: "Google-Mobile-Ads-SDKTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        .target(name: "_GoogleMobileAds", condition: .when(platforms: [.iOS])),
        .target(name: "_UserMessagingPlatform", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/Google-Mobile-Ads-SDK"
    ),
    .target(
      name: "GoogleSignInTarget",
      dependencies: [
        "Firebase",
        "FirebaseAnalyticsTarget",
        .target(name: "_AppAuth", condition: .when(platforms: [.iOS])),
        "_AppCheckCore",
        .target(name: "_GTMAppAuth", condition: .when(platforms: [.iOS])),
        "_GTMSessionFetcher",
        .target(name: "_GoogleSignIn", condition: .when(platforms: [.iOS]))
      ],
      path: "Sources/GoogleSignIn"
    ),
    .binaryTarget(
      name: "_AppAuth",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_AppAuth.xcframework.zip",
      checksum: "81b1d4c25a440835ff835ac1dc12c997617766d290352f3ecf71993a458d2c44"
    ),
    .binaryTarget(
      name: "_AppCheckCore",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_AppCheckCore.xcframework.zip",
      checksum: "521657899de9f77b9abc06a79862ccaf394e4dd7ff017421bd2daf498a8dfc5a"
    ),
    .binaryTarget(
      name: "_FBLPromises",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FBLPromises.xcframework.zip",
      checksum: "6b1865932ef7e7dd49a122fe47f9c685636d0ef68ed80d28a32c0a39b22e9880"
    ),
    .binaryTarget(
      name: "_FirebaseABTesting",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseABTesting.xcframework.zip",
      checksum: "055f84b90e40a45e8920c392a75ff88ab4a529947596266a46a6ef3ee9a0f4ef"
    ),
    .binaryTarget(
      name: "_FirebaseAI",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAI.xcframework.zip",
      checksum: "8ce7df85c377ce4f6d963821cc49683c6cdf789ac6ef7b00a996b2c194d29edb"
    ),
    .binaryTarget(
      name: "_FirebaseAnalytics",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAnalytics.xcframework.zip",
      checksum: "269e226e68e5cde228cbbbf20222efadbd0dd5dd292b85bed9c07d79012dbf5d"
    ),
    .binaryTarget(
      name: "_FirebaseAnalyticsOnDeviceConversion",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAnalyticsOnDeviceConversion.xcframework.zip",
      checksum: "6f89d6040905a7e3ab515a6e8b9b649f1fef911dedd69824622d8c0894a1ba7d"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheck",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAppCheck.xcframework.zip",
      checksum: "ff7ca82da99df6b3205af535768236c9b23e1a3976ab976e5ea9d90ea38150ac"
    ),
    .binaryTarget(
      name: "_FirebaseAppCheckInterop",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAppCheckInterop.xcframework.zip",
      checksum: "33dd078ba3673ac47c7a92fc47722e60e8a1c40151833929dbb93526d4ccd606"
    ),
    .binaryTarget(
      name: "_FirebaseAppDistribution",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAppDistribution.xcframework.zip",
      checksum: "55d5c185763e4fbdd329640f4728554249393528af222c1cd99b7eda237014d1"
    ),
    .binaryTarget(
      name: "_FirebaseAuth",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAuth.xcframework.zip",
      checksum: "6dee721298addf015431a9c7b5949d3abf10638a48a9b383a5580ea6cd212e8e"
    ),
    .binaryTarget(
      name: "_FirebaseAuthInterop",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseAuthInterop.xcframework.zip",
      checksum: "df1d39bffe661928360999f8da8cbcb841caeb793bdbb2d2edc05ca110d172be"
    ),
    .binaryTarget(
      name: "_FirebaseCore",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseCore.xcframework.zip",
      checksum: "462a560b968bec10258f986f8b483332a76c93b0c6925d4f4c121d5d62572f5a"
    ),
    .binaryTarget(
      name: "_FirebaseCoreExtension",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseCoreExtension.xcframework.zip",
      checksum: "9e841420a2386d6e1795bf975663d02246343c4b3ab53dd5ed7f5a7eab9fc21b"
    ),
    .binaryTarget(
      name: "_FirebaseCoreInternal",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseCoreInternal.xcframework.zip",
      checksum: "a50fc597ad191b21c9ab5a487e824f4e210c839610fd8766109dd969d4d8f5f8"
    ),
    .binaryTarget(
      name: "_FirebaseCrashlytics",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseCrashlytics.xcframework.zip",
      checksum: "f418b33bfd0538073f31bb02bb1dc837f4b4a9ad216af6ed670ec9a56374ff35"
    ),
    .binaryTarget(
      name: "_FirebaseDatabase",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseDatabase.xcframework.zip",
      checksum: "47f8b1c97c72b86fb2df2fcb5e6a5a93d2b1eb583ff26d6937accded24bc6f79"
    ),
    .binaryTarget(
      name: "_FirebaseDynamicLinks",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseDynamicLinks.xcframework.zip",
      checksum: "c2dbe1a986544c0487167ae827a57e27424f41cf0b3ae0211dc96913c5d6d778"
    ),
    .binaryTarget(
      name: "_FirebaseFirestore",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseFirestore.xcframework.zip",
      checksum: "fd4e60c253c32c39a7ad61423ee9baf10a8d616d9a499d459dee09803b3f7142"
    ),
    .binaryTarget(
      name: "_FirebaseFirestoreInternal",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseFirestoreInternal.xcframework.zip",
      checksum: "6336444457ae708789a0b5f60f9d3d176cf10fe0cfee2b3b81acde8730300a28"
    ),
    .binaryTarget(
      name: "_FirebaseFunctions",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseFunctions.xcframework.zip",
      checksum: "847e1ca11256364a68ed2113a9ff14c259abec39473d839c375ec52450b7a54f"
    ),
    .binaryTarget(
      name: "_FirebaseInAppMessaging",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseInAppMessaging.xcframework.zip",
      checksum: "f2439f2f66bfbb10d051ab947b613bf849ca6aea690acf84df24cef388c4d2a2"
    ),
    .binaryTarget(
      name: "_FirebaseInstallations",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseInstallations.xcframework.zip",
      checksum: "0c2c440970e2de99994bf0f2758fe002bbd17e2fb227208fed8d535b312fb747"
    ),
    .binaryTarget(
      name: "_FirebaseMLModelDownloader",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseMLModelDownloader.xcframework.zip",
      checksum: "83a4cf799ba32e8744ea342023481e6062607540769656418694f7b69673e51c"
    ),
    .binaryTarget(
      name: "_FirebaseMessaging",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseMessaging.xcframework.zip",
      checksum: "a31e7d7806c9f63fb78da60ba9268b0e8a3e885336643364399a4f57b036006a"
    ),
    .binaryTarget(
      name: "_FirebaseMessagingInterop",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseMessagingInterop.xcframework.zip",
      checksum: "b9c455be22a7c519e9a157c0c409b93d91b3332b713abe4fab715468e83d1e70"
    ),
    .binaryTarget(
      name: "_FirebasePerformance",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebasePerformance.xcframework.zip",
      checksum: "338cc862b43dd074523b7652113a2cbeee759ff4f25e06ad717976639a1bd404"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfig",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseRemoteConfig.xcframework.zip",
      checksum: "fa6921664ded9f7331c7c04599689e334063e4eb8c1bfcbe92d29527cea07940"
    ),
    .binaryTarget(
      name: "_FirebaseRemoteConfigInterop",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseRemoteConfigInterop.xcframework.zip",
      checksum: "17e3c29c01e0e31fa63393efc15d9e34b95b2e37760c579cbc0c6b0fffed3433"
    ),
    .binaryTarget(
      name: "_FirebaseSessions",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseSessions.xcframework.zip",
      checksum: "569b99d3c8d6d07b2f1409a3ab58ebabc002777e91fc0789331bb04d647b36cb"
    ),
    .binaryTarget(
      name: "_FirebaseSharedSwift",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseSharedSwift.xcframework.zip",
      checksum: "1900823165f69a779f2f481f20f60580f730663135633336b2fe52509c5fefaa"
    ),
    .binaryTarget(
      name: "_FirebaseStorage",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseStorage.xcframework.zip",
      checksum: "75c588a60d4a3bc643843400e706c77de27307fae12a27b85cc1717c44558dd7"
    ),
    .binaryTarget(
      name: "_FirebaseVertexAI",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_FirebaseVertexAI.xcframework.zip",
      checksum: "2d4b4897beb7e93e6cae50cf6809af18de031e39a394a04e703f72cf469cd253"
    ),
    .binaryTarget(
      name: "_GTMAppAuth",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GTMAppAuth.xcframework.zip",
      checksum: "f8b89e480bf90e94ca2a28b8cf6244954b97d65da378f6c0949703059b7ac0e0"
    ),
    .binaryTarget(
      name: "_GTMSessionFetcher",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GTMSessionFetcher.xcframework.zip",
      checksum: "e37172a02e7033b3b19d8d77c4ccc81f4cba146f54360de1c347b9639fb2afe4"
    ),
    .binaryTarget(
      name: "_GoogleAppMeasurement",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleAppMeasurement.xcframework.zip",
      checksum: "1a9816524b7ba3984fa6dcb3a6db5918bc189a8cc5623663b6f20020ca8a592e"
    ),
    .binaryTarget(
      name: "_GoogleAppMeasurementIdentitySupport",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleAppMeasurementIdentitySupport.xcframework.zip",
      checksum: "337d18caa1d8bedf76ec0e2218a67a3a0c66243a7ba21a286bce5345b043b7d1"
    ),
    .binaryTarget(
      name: "_GoogleAppMeasurementOnDeviceConversion",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleAppMeasurementOnDeviceConversion.xcframework.zip",
      checksum: "9cb76dc213da6f5884a26a4ec53d420d43a944530d7d350e65fefd99f00fc406"
    ),
    .binaryTarget(
      name: "_GoogleDataTransport",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleDataTransport.xcframework.zip",
      checksum: "d5ed7f56a57ccabee7e1aa272ef176ff8173439585a543c712f6c0f3351d0f98"
    ),
    .binaryTarget(
      name: "_GoogleMobileAds",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleMobileAds.xcframework.zip",
      checksum: "1c640ea464c293255c1c164ead253b02e16a69c3a40d8bc3b3593643e077b902"
    ),
    .binaryTarget(
      name: "_GoogleSignIn",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleSignIn.xcframework.zip",
      checksum: "ee9412aac4cd67088fa9940ed0d510d7731ef3bf3a7b8308912b754fa649dd10"
    ),
    .binaryTarget(
      name: "_GoogleUtilities",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_GoogleUtilities.xcframework.zip",
      checksum: "6928556d4d07b653a835309fe2184180be8171fcc0a06aef705e40157a1a2951"
    ),
    .binaryTarget(
      name: "_Promises",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_Promises.xcframework.zip",
      checksum: "871292c20e442838c945f5a67b9f65d822b78d20601399d5c33d33ef5dc4ca6a"
    ),
    .binaryTarget(
      name: "_RecaptchaInterop",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_RecaptchaInterop.xcframework.zip",
      checksum: "95ac411a1be21209559f430729d11b4849c83e3950ab1c4ecb66399f9895ec24"
    ),
    .binaryTarget(
      name: "_SwiftProtobuf",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_SwiftProtobuf.xcframework.zip",
      checksum: "ffac4ef6990ff71ef3f7e009a3acaa1e52cac7867d8a3762489550f40979c9fa"
    ),
    .binaryTarget(
      name: "_UserMessagingPlatform",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_UserMessagingPlatform.xcframework.zip",
      checksum: "f615d9a31bea487d552addd99e991766c5aa11d634dc7dec82faf0a9fde7719a"
    ),
    .binaryTarget(
      name: "_absl",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_absl.xcframework.zip",
      checksum: "cc85e6593b83f0907618028519212e425181e4d9222c2ac4e2bb44af2982e0ea"
    ),
    .binaryTarget(
      name: "_grpc",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_grpc.xcframework.zip",
      checksum: "c94daeca726e90de96b297ba005acf4985159c907817eac113e69e5bc29ab476"
    ),
    .binaryTarget(
      name: "_grpcpp",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_grpcpp.xcframework.zip",
      checksum: "b031e8b23c349ea4a34f1bddcd571bad2a42d92f4e78fb88b1467ac6ff210189"
    ),
    .binaryTarget(
      name: "_leveldb",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_leveldb.xcframework.zip",
      checksum: "298f8fcb19d68ea916a1d9e8d9585e80ddc7415dabd8bfbd7477a55088f4eaf3"
    ),
    .binaryTarget(
      name: "_nanopb",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_nanopb.xcframework.zip",
      checksum: "5847903d7f222a95ca7f6bd5fe64c30cb5348efba63dc0d2b71c011183167fed"
    ),
    .binaryTarget(
      name: "_openssl_grpc",
      url: "https://github.com/Lxrd-AJ/firebase-ios-sdk-xcframeworks/releases/download/11.13.0/_openssl_grpc.xcframework.zip",
      checksum: "485e74a33d45332612592a6c204dc94dcf595dd9eef62cd1a056d6308303fc87"
    )
  ]
)
    