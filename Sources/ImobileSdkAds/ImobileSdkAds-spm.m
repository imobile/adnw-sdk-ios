//
//  ImobileSdkAds-spm.m
//
//  SDK の実体は ImobileSdkAds.xcframework にあり、このラッパーターゲットは
//  module map とシステムフレームワークのリンク指定を提供するだけのものだが、
//  ソースファイルを 1 つも持たないターゲットは利用側へのリンク時に
//  オブジェクトファイルが見つからず失敗する。それを避けるための空の実装。
//

#import <Foundation/Foundation.h>

// 空の翻訳単位になるのを防ぐためだけのシンボル。
__attribute__((used)) static const char ImobileSdkAdsPackageMarker = 0;
