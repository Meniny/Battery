
Pod::Spec.new do |s|
  s.name         = "Battery"
  s.version      = "1.0.0"
  s.summary      = "An easy-to-use class to monitor battery status on iOS."
  s.description  = "Battery is an easy-to-use class to monitor battery status on iOS."
  s.homepage     = "https://github.com/Meniny/Battery"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Elias Abel" => "Meniny@qq.com" }
  s.social_media_url   = "https://meniny.cn"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Meniny/Battery.git", :tag => "#{s.version}" }
  s.source_files  = "Battery/*"
  s.public_header_files = "Battery/*.h"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
