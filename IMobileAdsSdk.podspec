SDK_VERSION = "2.0.29"

Pod::Spec.new do |spec|

  spec.name         = "IMobileAdsSdk"
  spec.version      = SDK_VERSION
  spec.summary      = "i-mobile SDK for iOS"

  spec.description  = <<-DESC
IMobileAdsSdk is i-mobile SDK for iOS.
                   DESC

  spec.homepage     = "https://adpf-info.i-mobile.co.jp/"
  spec.license      = { :type => "Copyright", :text => "Copyright 2013 i-mobile" }
  spec.author       = "i-mobile"
  spec.platform     = :ios
  spec.ios.deployment_target = "6.0"

  spec.source       = { :http => "https://github.com/imobile/adnw-sdk-ios/releases/download/v#{SDK_VERSION}/IMobileAdsSdk.framework.zip", :type => 'zip' }
  spec.vendored_frameworks = "IMobileAdsSdk.framework"

  spec.frameworks   = "AdSupport", "SystemConfiguration", "CoreLocation"
  spec.xcconfig     = { "OTHER_LDFLAGS" => "-lObjC" }

end