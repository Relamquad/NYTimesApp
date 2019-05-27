# Uncomment the next line to define a global platform for your project
# platform :ios, '12.0'

target 'NYTimesApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for NYTimesApp
  pod 'Alamofire'
  pod 'Kingfisher'

end

post_install do |installer|
        installer.pods_project.targets.each do |target|
            if ['Kingfisher'].include? target.name
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '4.0'
                end
            end
        end
    end
