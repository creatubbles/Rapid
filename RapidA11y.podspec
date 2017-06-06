Pod::Spec.new do |s|
  s.name             = 'RapidA11y'
  s.version          = '1.0.6'
  s.summary          = 'Accessibility framework build to interact with RapidTests, a UI testing framework.'
  s.description      = 'RapidA11y is an accessibility framework built to ease the addition of accessibility to
  an iOS application. This enables both easy VoiceOver implementations and integration into RapidTests, a partner
  UI testing framework built on top of Quick & Nimble.'
  s.homepage         = 'https://github.com/creatubbles/Rapid'
  s.license          = { :type => 'MIT', :text => '
  Copyright 2017 Creatubbles

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files
(the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  '  }
  s.author           = { 'coolbnjmn' => 'benjamin@creatubbles.com' }
  s.source           = { :git => 'https://github.com/creatubbles/Rapid.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'RapidA11y/*.*'
end
