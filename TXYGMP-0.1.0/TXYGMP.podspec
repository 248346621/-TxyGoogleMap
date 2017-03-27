Pod::Spec.new do |s|
  s.name = "TXYGMP"
  s.version = "0.1.0"
  s.summary = "\u{5929}\u{4e0b}\u{6e38}googlemap\u{4f7f}\u{7528}"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"248346621"=>"248346621@qq.com"}
  s.homepage = "https://github.com/248346621/TXYGMP"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "MapKit", "CFNetwork", "Security", "SystemConfiguration", "MobileCoreServices", "ImageIO"]
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/TXYGMP.framework'
end
