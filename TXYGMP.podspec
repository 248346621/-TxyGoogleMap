#
# Be sure to run `pod lib lint TXYGMP.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TXYGMP'
  s.version          = '0.1.0'
  s.summary          = '天下游googlemap使用'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/248346621/TXYGMP'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '248346621' => '248346621@qq.com' }
  s.source           = { :git => '/Users/aa/Desktop/TxyGoogleMap/TXYGMP', :tag => '0.1.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TXYGMP/Classes/**/*'
  
   s.resource_bundles = {
     'TXYGMP' => ['TXYGMP/Assets/*.png']
   }

  s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'MapKit','CFNetwork','Security','SystemConfiguration','MobileCoreServices','ImageIO'
   s.dependency 'AFNetworking'
    s.dependency 'SDWebImage'
end
