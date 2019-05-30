source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

target 'StreamTest' do

  # Pods for StreamTest
  pod 'RIBs', '~> 0.9'
  pod 'lottie-ios'

end

post_install do |installer|
  swift4_pods = ["RIBs", "RxSwift"]
  installer.pods_project.targets.each do |target|
    if swift4_pods.include?(target.name)
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end
