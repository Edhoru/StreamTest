# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'StreamTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StreamTest

  pod 'RIBs', '~> 0.9'

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
