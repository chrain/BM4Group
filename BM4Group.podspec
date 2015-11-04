Pod::Spec.new do |s|

  s.name         = "BM4Group"
  s.version      = "0.0.8"
  s.summary      = "BM4Group Develpoe iOS Library."

  s.description  = <<-DESC
                   BM4Group Develpoe iOS Library.
                   DESC

  s.homepage     = "https://github.com/chrain/BM4Group"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = "MIT"
  s.author             = { "Chrain" => "chrain.master@gmail.com" }
  s.source       = { :git => "https://github.com/chrain/BM4Group.git", :tag => s.version }
  s.source_files  = "BM4Group/**/*.{h,m}
  s.requires_arc = true

  # s.public_header_files = "Classes/**/*.h"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.dependency "IQKeyboardManager"
  s.dependency "MBProgressHUD"
  s.dependency "AFNetworking"
  s.dependency "SDWebImage"
  s.dependency "MJExtension"
  s.dependency "MJRefresh"
  s.dependency "Masonry"

end
