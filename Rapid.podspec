#
# Be sure to run `pod lib lint Rapid.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  s.name             = 'Rapid'
  s.version          = '0.1.0'
  s.summary          = 'Quick/Nimble based Rapid UI testing framework.'
  s.description      = 'Built by Creatubbles\' iOS team. Simple framework to bring in accessibility identifiers in a clean way to then be fetched in UI tests. There, views can be waited upon based on existence and tappability.'

  s.homepage         = 'https://github.com/coolbnjmn/Rapid'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'coolbnjmn' => 'hendricksbenjamin@gmail.com' }
  s.source           = { :git => 'https://github.com/coolbnjmn/Rapid.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.subspec 'Core' do |cs|
    cs.source_files = 'Rapid/*.swift'
  end
  s.subspec 'Tests' do |ts|
    ts.frameworks = 'XCTest'
    ts.source_files = 'Rapid/Tests/*.swift'
    ts.dependency 'Quick', '~> 0.10.0'
    ts.dependency 'Nimble', '~> 5.0.0'
    ts.dependency 'Rapid/Core'
  end
end
