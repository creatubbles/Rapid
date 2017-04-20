#
# Be sure to run `pod lib lint Rapid.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  s.name             = 'RapidA11y'
  s.version          = '0.1.5'
  s.summary          = 'Quick/Nimble based Rapid UI testing framework.'
  s.description      = 'Built by Creatubbles\' iOS team. Simple framework to bring in accessibility identifiers in a clean way to then be fetched in UI tests. There, views can be waited upon based on existence and tappability.'
  s.homepage         = 'https://github.com/coolbnjmn/Rapid'
  s.license          = { :type => 'MIT', :file => 'RapidA11y/LICENSE' }
  s.author           = { 'coolbnjmn' => 'hendricksbenjamin@gmail.com' }
  s.source           = { :git => 'https://github.com/coolbnjmn/Rapid.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'RapidA11y/*'
end
