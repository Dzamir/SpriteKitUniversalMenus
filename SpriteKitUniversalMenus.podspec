#
# Be sure to run `pod lib lint SpriteKitUniversalMenus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SpriteKitUniversalMenus"
  s.version          = "0.1.0"
  s.summary          = "SpriteKit menus that works on iOS, tvOS and MacOS"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                   SpriteKit menus that works on iOS (tap and gamecontrollers), tvOS (focus engine and gamecontrollers) and MacOS (click, keyboard and gamecontrollers)
                   DESC

  s.homepage         = "https://github.com/Dzamir/SpriteKitUniversalMenus"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache License'
  s.author           = { "Davide Di Stefano" => "dzamirro@gmail.com" }
  s.source           = { :git => "https://github.com/Dzamir/SpriteKitUniversalMenus.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/dzamir'

  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.10"
  s.tvos.deployment_target = "9.0"

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SpriteKitUniversalMenus' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'


end
