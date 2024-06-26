SDK_VERSION = "2.3.4"

Pod::Spec.new do |spec|

  spec.name         = "ImobileSdkAds"
  spec.version      = SDK_VERSION
  spec.summary      = "i-mobile SDK for iOS"

  spec.description  = <<-DESC
ImobileSdkAds is i-mobile SDK for iOS.
                   DESC

  spec.homepage     = "https://adpf-info.i-mobile.co.jp/"
  spec.license      = { :type => "Copyright", :text => "Copyright 2013 i-mobile" }
  spec.author       = "i-mobile"
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"

  spec.source       = { :http => "https://github.com/imobile/adnw-sdk-ios/releases/download/v#{SDK_VERSION}/ImobileSdkAds.xcframework.zip", :type => 'zip' }
  spec.vendored_frameworks = "ImobileSdkAds.xcframework"

  spec.frameworks   = "AdSupport", "SystemConfiguration", "CoreLocation", "WebKit", "StoreKit"
  spec.xcconfig     = { "OTHER_LDFLAGS" => "-lObjC" }

end
