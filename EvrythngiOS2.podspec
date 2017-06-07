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
  s.source       = { :git => 'https://github.com/imfree-jdcastro/Evrythng-iOS-SDK.git', :tag => '0.0.301' }


  s.ios.deployment_target = '10.0'
  s.ios.framework = 'UIKit'
  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3',
                            #'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/GoogleMobileVision/Detector/Frameworks',
                            #'FRAMEWORK_SEARCH_PATHS' => '/Users/imfree.jdcastro/Desktop/Development/XcodeProjects/SampleImp/SampleImp/Pods/GoogleMobileVision/Detector/Frameworks',

   }

  s.vendored_frameworks = ['GoogleInterchangeUtilities.framework', 
                                   'BarcodeDetector.framework', 
                                   'GoogleMobileVision.framework',
                                   'GoogleNetworkingUtilities.framework',
                                   'GoogleSymbolUtilities.framework',
                                   'GoogleUtilities.framework'
                          ]
  s.dependency 'EvrythngiOS', '0.0.177'     
end
