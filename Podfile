# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '11.0'

def shared_pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxAlamofire'
  pod 'RxDataSources'
end

target 'appStore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!
  shared_pods

  # Pods for appStore

  target 'appStoreTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'appStoreUITests' do
    # Pods for testing
  end

end

