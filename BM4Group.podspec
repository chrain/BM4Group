Pod::Spec.new do |s|

  s.name         = "BM4Group"
  s.version      = "0.1"
  s.summary      = "BM4Group Develpoe iOS Library."
  s.homepage     = "https://github.com/chrain/BM4Group"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.platform     = :ios, '7.0'
  s.author             = { "Chrain" => "chrain.master@gmail.com" }
  # s.authors            = { "Chrain" => "chrain.master@gmail.com" }
  # s.social_media_url   = "http://twitter.com/Chrain"

  s.source       = { :git => "https://github.com/chrain/BM4Group.git", :tag => s.version.to_s }

  s.requires_arc = true
  s.source_files = 'BM4Group/**/*.{h,m}'
  s.public_header_files = 'BM4Group/**/*.{h}'

  s.ios.vendored_frameworks = 'Vendor/Reveal.framework'

  s.dependency 'IQKeyboardManager'
  s.dependency 'MBProgressHUD'
  s.dependency 'AFNetworking'
  s.dependency 'SDWebImage'
  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'Masonry'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'YYKit'
  s.dependency 'UIActivityIndicator-for-SDWebImage'
  s.dependency 'CTAssetsPickerController'

end
