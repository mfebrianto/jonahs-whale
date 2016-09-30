source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target 'JonahsWhale' do
  pod 'Alamofire', '~> 4.0'
  pod 'SWXMLHash', '~> 3.0.0'
  pod 'XCGLogger', '~> 4.0.0'
  pod 'RAReorderableLayout', '~> 0.6.1'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
