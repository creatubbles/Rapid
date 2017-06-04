#     Copyright (c) 2017 coolbnjmn <hendricksbenjamin@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE. 
#
# Podfile used for Demo purposes only.

platform :ios, '9.0'
use_frameworks!

target 'RapidDemo' do
  pod 'RapidA11y', :git => 'git@github.com:creatubbles/Rapid.git', :branch => 'master'
end
  
target 'RapidDemoTests' do
  pod 'RapidTests', :git => 'git@github.com:creatubbles/Rapid.git', :branch => 'master'
end

target 'RapidDemoUITests' do
  pod 'RapidTests', :git => 'git@github.com:creatubbles/Rapid.git', :branch => 'master'
end

target 'RapidA11y' do
end

target 'RapidTests' do
  pod 'RapidA11y', :git => 'git@github.com:creatubbles/Rapid.git', :branch => 'master'
  pod 'Nimble', '5.0.0'
  pod 'Quick', '0.10.0'
end