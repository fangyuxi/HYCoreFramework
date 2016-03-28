Pod::Spec.new do |s|
  s.name             = "HYCoreFramework"
  s.version          = "0.1.0"
  s.summary          = "A Core Framework For HuangYe Team"
  s.description      = "A Core Framework For HuangYe Team 's APP Foundation'"

  s.homepage         = "https://github.com/fangyuxi/HYCoreFramework"
  s.license          = 'MIT'
  s.author           = { "fangyuxi" => "xcoder.fang@gmail.com" }
  s.source           = { :git => "https://github.com/fangyuxi/HYCoreFramework.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'HYCoreFramework' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'

  s.frameworks = 'UIKit'

  s.dependency 'HYNetworking', '~> 0.3.0'
  s.dependency 'SDWebImage', '~> 3.7.5'
  s.dependency 'MJRefresh', '~> 3.1.0'
  s.dependency 'MJExtension'
  s.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.4'
  s.dependency 'FMDB', '~> 2.5'
  s.dependency 'Masonry'
  s.dependency 'HYLogEngine', '~> 1.1'
end
