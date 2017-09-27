Pod::Spec.new do |s|
  s.name             = 'RapidTests'
  s.version          = '1.1.3'
  s.summary          = 'UI testing framework built on top of RapidA11y.'
  s.description      = 'RapidTests is a UI testing framework built to ease the creation and
  maintenance of UI tests in a complex iOS application. This framework is used only in
  test targets, but depends on a partner framework that is integrated into the
  application targets (RapidA11y).'
  s.homepage         = 'https://github.com/creatubbles/Rapid'
  s.license          = { :type => 'MIT', :text => '
  Copyright 2017 Creatubbles

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
  ' }
  s.author           = { 'coolbnjmn' => 'benjamin@creatubbles.com' }
  s.source           = { :git => 'https://github.com/creatubbles/Rapid.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.source_files = 'RapidTests/*.*'
  s.frameworks = 'XCTest'
  s.dependency 'RapidA11y'

end
