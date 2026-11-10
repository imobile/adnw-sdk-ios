// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "ImobileSdkAds",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "ImobileSdkAds",
            targets: ["ImobileSdkAds"]
        )
    ],
    targets: [
        // 配布物そのもの。静的ライブラリ形式の XCFramework。
        .binaryTarget(
            name: "ImobileSdkAdsBinary",
            path: "ImobileSdkAds.xcframework"
        ),
        // 利用側に公開するラッパー。binaryTarget では指定できない
        // module map と依存フレームワークのリンク指定をここで担う。
        // include/ の中身は Scripts/sync-headers.sh が生成する。
        .target(
            name: "ImobileSdkAds",
            dependencies: ["ImobileSdkAdsBinary"],
            path: "Sources/ImobileSdkAds",
            publicHeadersPath: "include",
            linkerSettings: [
                .linkedFramework("AdSupport"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("CoreLocation"),
                .linkedFramework("WebKit"),
                .linkedFramework("StoreKit")
            ]
        )
    ]
)
