Pod::Spec.new do |s|
    s.name             = "HYCoreFramework"
    s.version          = "0.1.0"
    s.summary          = "A Core Framework For HuangYe Team"
    s.description      = "A Core Framework For HuangYe Team 's APP Foundation'"

    s.homepage         = "https://github.com/fangyuxi/HYCoreFramework"
    s.license          = 'MIT'
    s.author           = { "fangyuxi" => "xcoder.fang@gmail.com" }
    s.source           = { :git => "https://github.com/fangyuxi/HYCoreFramework.git", :tag => s.version.to_s, :submodules => true }

    s.platform     = :ios, '7.1'
    s.requires_arc = true

    s.source_files = 'Pod/Classes/*.{h,m}'
    s.resource_bundles = {
      'HYCoreFramework' => ['Pod/Assets/*.png']
    }

    s.public_header_files = 'Pod/Classes/**/*.h'

    s.subspec 'View' do |ss|
      ss.source_files = 'Pod/Classes/View/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/View/*.h'
      ss.dependency 'MBProgressHUD'
    end

    s.subspec 'Categorys' do |ss|
      ss.source_files = 'Pod/Classes/Categorys/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/Categorys/*.h'
    end

    s.subspec 'Model' do |ss|
      ss.source_files = 'Pod/Classes/Model/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/Model/*.h'
      ss.dependency 'HYCache'
      ss.dependency 'MJExtension'
    end

    s.subspec 'Cell' do |ss|
      ss.source_files = 'Pod/Classes/Cell/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/Cell/*.h'
      ss.dependency 'HYCoreFramework/Model'
    end

    s.subspec 'DataPresenter' do |ss|
      ss.source_files = 'Pod/Classes/DataPresenter/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/DataPresenter/*.h'
    end

    s.subspec 'History' do |ss|
      ss.source_files = 'Pod/Classes/History/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/History/*.h'
      ss.dependency 'HYCoreFramework/Model'
    end

    s.subspec 'Setting' do |ss|
      ss.source_files = 'Pod/Classes/Setting/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/Setting/*.h'
      ss.dependency 'HYCoreFramework/Model'
    end

    s.subspec 'TableViewSource' do |ss|
      ss.source_files = 'Pod/Classes/TableViewSource/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/TableViewSource/*.h'
      ss.dependency 'HYNetworking', '~> 0.4.0'
      ss.dependency 'HYCoreFramework/Model'
      ss.dependency 'HYCoreFramework/Cell'
    end

    s.subspec 'CollectionViewSource' do |ss|
    ss.source_files = 'Pod/Classes/CollectionViewSource/*.{h,m}'
    ss.public_header_files = 'Pod/Classes/CollectionViewSource/*.h'
    ss.dependency 'HYNetworking', '~> 0.4.0'
    ss.dependency 'HYCoreFramework/Model'
    ss.dependency 'HYCoreFramework/Cell'
    end

    s.subspec 'Controller' do |ss|
      ss.source_files = 'Pod/Classes/Controller/*.{h,m}'
      ss.public_header_files = 'Pod/Classes/Controller/*.h'
      ss.dependency 'Aspects'
      ss.dependency 'HYCoreFramework/TableViewSource'
      ss.dependency 'HYCoreFramework/View'
      ss.dependency 'HYCoreFramework/Categorys'
      ss.dependency 'MJRefresh', '~> 3.1.0'
      ss.dependency 'UITableView+FDTemplateLayoutCell', '~> 1.4'
    end

end
