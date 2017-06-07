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
  s.version      = "0.0.182"
  s.summary      = "iOS variant of the Evrythng Platform SDK"
  s.description  = 'evrythng-ios-sdk is an SDK to be used when developing iOS enabled Applications using the Evrythng Platform.'
  s.homepage     = 'https://github.com/imfree-jdcastro/Evrythng-iOS-SDK'
  s.license      = { :type => 'MIT', :file => 'license.md'}
  s.authors      = { 'JD Castro' => 'jd@imfreemobile.com' }
  s.platform     = :ios, '10.0'
  s.source       = { :git => 'https://github.com/imfree-jdcastro/Evrythng-iOS-SDK.git', :tag => '0.0.182' }
  s.resources    = 'Evrythng-iOS/*.xib'

  s.ios.deployment_target = '10.0'
  s.ios.framework = 'UIKit'
  s.requires_arc = true
  #s.ios.vendored_frameworks = ['EvrythngiOS.framework']

  #s.ios.vendored_frameworks = ['EvrythngiOS.framework']
  s.default_subspecs = 'All'

  s.subspec 'All' do |all|
    all.dependency 'EvrythngiOS/Core'
    #all.dependency 'EvrythngiOS/Scan'
    #all.dependency 'EvrythngiOS/Crashlytics'
  end

  s.subspec 'Core' do |core|
      core.source_files = 'Evrythng-iOS/EvrythngiOS.h', 'Evrythng-iOS/**/*.{h,m,swift}'
      core.exclude_files = 'Classes/Exclude'
      core.ios.resource_bundles = {
         'Evrythng-iOS' => ['Evrythng-iOS/*.xib']
      }
      core.dependency 'Alamofire', '~> 4.4'
      core.dependency 'AlamofireObjectMapper', '~> 4.1'
      core.dependency 'SwiftyJSON', '~> 3.1'
      core.dependency 'Moya', '~> 8.0.3'
      core.dependency 'MoyaSugar', '~> 0.4'
      core.dependency 'Moya-SwiftyJSONMapper', '~> 2.2'
      core.dependency 'KRProgressHUD'
      core.dependency 'EvrythngiOS2', '0.0.302'

      core.user_target_xcconfig = { 'SWIFT_VERSION' => '3',
                                #'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/GoogleMobileVision/Detector/Frameworks',
                                #'FRAMEWORK_SEARCH_PATHS' => '/Users/imfree.jdcastro/Desktop/Development/XcodeProjects/SampleImp/SampleImp/Pods/GoogleMobileVision/Detector/Frameworks',

       }
  end

  s.subspec 'Crashlytics' do |crashlytics|
      crashlytics.dependency 'Crashlytics'
      crashlytics.pod_target_xcconfig = {
        'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/Crashlytics/iOS',
        'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
      }
  end

  s.subspec 'Scan' do |scan|
    # s.vendored_frameworks = ['GoogleInterchangeUtilities.framework', 
    #                                'BarcodeDetector.framework', 
    #                                'GoogleMobileVision.framework',
    #                                'GoogleNetworkingUtilities.framework',
    #                                'GoogleSymbolUtilities.framework',
    #                                'GoogleUtilities.framework'
    #                              ]

    # scan.vendored_frameworks = ['Pods/GoogleInterchangeUtilities/Frameworks/frameworks/GoogleInterchangeUtilities.framework',
    #                          'Pods/GoogleMobileVision/BarcodeDetector/Frameworks/frameworks/BarcodeDetector.framework',
    #                          'Pods/GoogleMobileVision/Detector/Frameworks/frameworks/GoogleMobileVision.framework',
    #                          'Pods/GoogleNetworkingUtilities/Frameworks/frameworks/GoogleNetworkingUtilities.framework',
    #                          'Pods/GoogleSymbolUtilities/Frameworks/frameworks/GoogleSymbolUtilities.framework',
    #                          'Pods/GoogleUtilities/Frameworks/frameworks/GoogleUtilities.framework',
    #                         ]

    scan.vendored_frameworks = ['GoogleInterchangeUtilities.framework', 
                                   'BarcodeDetector.framework', 
                                   'GoogleMobileVision.framework',
                                   'GoogleNetworkingUtilities.framework',
                                   'GoogleSymbolUtilities.framework',
                                   'GoogleUtilities.framework'
                                 ]
    scan.ios.resources = ['GoogleInterchangeUtilities.framework', 
                                   'BarcodeDetector.framework', 
                                   'GoogleMobileVision.framework',
                                   'GoogleNetworkingUtilities.framework',
                                   'GoogleSymbolUtilities.framework',
                                   'GoogleUtilities.framework'
                                 ]
    #scan.ios.xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks' }

    scan.pod_target_xcconfig = {
        'FRAMEWORK_SEARCH_PATHS' => '$(PODS_ROOT)/Evrythng-iOS',
        'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'

    }

    # scan.source_files = ['EvrythngiOSFrameworks/GoogleMobileVision.framework/Headers/*.h']
    # scan.public_header_files = ['Pods/GoogleMobileVision/Detector/Frameworks/frameworks/GoogleMobileVision.framework/Headers/*.h']
    # scan.dependency 'GoogleMobileVision/BarcodeDetector'
  end
end
