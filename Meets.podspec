Pod::Spec.new do |s|
  s.name         = "Meets"
  s.version      = "0.0.1-beta"
  s.summary      = "Meets iOS is a native SDK designed to ease the communications between iOS mobile apps and Magento stores"
  s.description  = <<-DESC
                   Meets iOS is a native SDK designed to ease the communications between iOS mobile apps and Magento stores. It allows you to access Magento's data as if it were local data and hides the complexities of dealing with Magento's SOAP API directly.
                   DESC
  s.license      = "MIT"

  s.homepage     = "http://meets.io/ios"
  s.documentation_url = "http://meets.io/docs"
  s.author             = { "Juan F. Sagasti" => "juan@theagilemonkeys.com" }
  s.social_media_url   = "http://twitter.com/meetsio"

  s.platform = :ios, '7.0'

  s.source       = { :git => "https://github.com/agilemonkeys/meets-ios.git", :tag => "0.0.1-beta" }
  s.source_files  = "Meets/**/*.{h,m}"

  s.requires_arc = true
  s.prefix_header_file = "Meets/Meets-Prefix.pch"
  s.dependency 'AFNetworking', '~> 2.1.0'
  s.dependency 'AFXMLDictionarySerializer', '~> 0.0.1'
  s.xcconfig     = { 'HEADER_SEARCH_PATHS' => '"$(SDKROOT)/usr/include/libxml2"' }
end
