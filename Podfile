# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'RapidDemo' do
  pod 'RapidA11y', :git => 'git@github.com:coolbnjmn/Rapid.git', :branch => 'master'
end
  
target 'RapidDemoTests' do
  pod 'RapidTests', :git => 'git@github.com:coolbnjmn/Rapid.git', :branch => 'master'
end

target 'RapidDemoUITests' do
  pod 'RapidTests', :git => 'git@github.com:coolbnjmn/Rapid.git', :branch => 'master'
end

target 'RapidA11y' do
end

target 'RapidTests' do
  pod 'RapidA11y', :git => 'git@github.com:coolbnjmn/Rapid.git', :branch => 'master'
  pod 'Nimble', '5.0.0'
  pod 'Quick', '0.10.0'
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
