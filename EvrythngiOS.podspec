#
#  Be sure to run `pod spec lint Evrythng-iOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "EvrythngiOS"
  s.version      = "0.0.1"
  s.summary      = "iOS variant of the Evrythng Platform SDK"
  s.description  = 'evrythng-ios-sdk is an SDK to be used when developing iOS enabled Applications using the Evrythng Platform.'
  s.homepage     = 'https://github.com/imfree-jdcastro/Evrythng-iOS-SDK'
  s.license      = { :type => 'MIT', :file => 'license.md'}
  s.authors      = { 'JD Castro' => 'jd@imfreemobile.com' }
  s.platform     = :ios, '10.0'
  s.source       = { :git => 'https://github.com/imfree-jdcastro/Evrythng-iOS-SDK.git', :tag => '0.0.14' }
  s.source_files = 'Evrythng-iOS', 'Evrythng-iOS/**/*.{h,m,swift}'
  s.exclude_files = 'Classes/Exclude'
  #s.resources    = 'Evrythng-iOS/*.mp3'

  s.ios.deployment_target = '10.0'
  s.ios.framework = 'UIKit'
  s.requires_arc = true
  #s.default_subspecs = 'All'
  #s.ios.vendored_frameworks = 'EvrythngiOSFrameworks/BarcodeDetector.framework'
  #s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '/Applications/Xcode.app/Contents/Developer/Library/Frameworks' }
  s.vendored_frameworks = ['EvrythngiOSFrameworks/BarcodeDetector.framework', 'EvrythngiOSFrameworks/GoogleMobileVision.framework']

  #s.subspec 'All' do |all|
  #  all.dependency 'EvrythngiOS/Scan'
  #end

  #s.subspec 'Scan' do |scan|
    #scan.ios.vendored_frameworks = ["EvrythngiOSFrameworks/*.framework"]
    #scan.dependency 'GoogleMobileVision/BarcodeDetector', '~> 1.1.0'
  #end

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3' }
  s.dependency 'Alamofire', '~> 4.4'
  s.dependency 'AlamofireObjectMapper', '~> 4.1'
  s.dependency 'SwiftyJSON', '~> 3.1'
  s.dependency 'Moya', '~> 8.0.3'
  s.dependency 'MoyaSugar', '~> 0.4'
  s.dependency 'Moya-SwiftyJSONMapper', '~> 2.2'
  #s.dependency 'GoogleMobileVision/BarcodeDetector'
  s.dependency 'KRProgressHUD'

end
