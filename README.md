# ImobileSdkAds

i-mobile SDK for iOS

- ドキュメント: https://sppartner.i-mobile.co.jp/webdoc/index.html
- 現在のバージョン: 2.3.4

## 導入方法

Swift Package Manager、CocoaPods、手動組み込みのいずれでも導入できます。
どの方法で入れても SDK のバイナリは同一です。

### Swift Package Manager

#### Xcode から追加する

1. **File ▸ Add Package Dependencies…** を開く
2. 次の URL を入力する

   ```
   https://github.com/imobile/adnw-sdk-ios
   ```

3. Dependency Rule に **Up to Next Major Version（2.3.4 < 3.0.0）** を指定する
4. `ImobileSdkAds` を追加する

#### Package.swift から追加する

```swift
dependencies: [
    .package(url: "https://github.com/imobile/adnw-sdk-ios", from: "2.3.4")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "ImobileSdkAds", package: "adnw-sdk-ios")
        ]
    )
]
```

### CocoaPods

```ruby
pod 'ImobileSdkAds'
```

### 手動で組み込む

[Releases](https://github.com/imobile/adnw-sdk-ios/releases) から
`ImobileSdkAds.xcframework.zip` をダウンロードし、展開した
`ImobileSdkAds.xcframework` をプロジェクトに追加してください。
この場合は下記のシステムフレームワークと `-ObjC` の設定が別途必要です。

## 使い方

Swift:

```swift
import ImobileSdkAds
```

Objective-C:

```objc
#import <ImobileSdkAds/ImobileSdkAds.h>
```

Swift Package Manager で導入した場合、Bridging Header の設定や、
AdSupport / SystemConfiguration / CoreLocation / WebKit / StoreKit の
手動リンクは不要です。

## 対応環境

| 導入方法 | 対応 OS |
| --- | --- |
| Swift Package Manager | iOS 12.0 以上 |
| CocoaPods / 手動 | iOS 9.0 以上 |

対応プラットフォームは iOS のみです（Mac Catalyst / visionOS は非対応）。

## 注意事項

- Swift Package Manager に対応しているのは 2.3.4 以降です。
  これより前のバージョンはタグに `Package.swift` を含んでいないため、
  Xcode からパッケージとして追加できません。
- CocoaPods から移行する場合は、`Podfile` から `pod 'ImobileSdkAds'` を
  削除して `pod install` を実行してから、上記の手順でパッケージを
  追加してください。ソースコードの `import` / `#import` は変更不要です。

## ライセンス

Copyright 2013 i-mobile
