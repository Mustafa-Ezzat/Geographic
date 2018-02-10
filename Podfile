# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'

target 'Geographic' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Geographic
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'
 
  pod 'GooglePlaces'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  
  pod 'Alamofire', '~> 4.5’
  pod 'AlamofireImage', '~> 3.2.0’
  pod 'AlamofireObjectMapper', '~> 4.0'
  
  target 'GeographicTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GeographicUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
        end
    end
end
