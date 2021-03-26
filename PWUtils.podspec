
Pod::Spec.new do |s|


  s.name         = "PWUtils"
  s.version      = "0.0.1"
  s.summary      = "组件化UI支持库"


  s.description  = "组件化UI支持库"

  s.homepage     = "https://github.com/wnrz/PWUtils.git"

  s.license      = "MIT"

  s.author       = { "PW" => "66682060@qq.com" }


  s.platform     = :ios, "10.0"
  s.ios.deployment_target = "10.0"


  s.source           = { :git => 'https://github.com/wnrz/PWUtils.git', :tag => s.version.to_s }
  s.public_header_files = 'PWUtils/PWUIKit/*.h'#公共的头文件地址
  s.source_files = 'PWUtils/PWKit/PWUtils.h'#文件地址，pod会以这个地址下载需要的文件构建pods


  s.requires_arc = true
  s.framework = "UIKit","Foundation"


  s.subspec 'PWUtils' do |ss|#
    ss.source_files = 'PWUtils/PWKit/**/*.{h,m,c,swift}'
    ss.ios.frameworks = 'UIKit', 'Foundation'
  end

  s.resource_bundles = {'PWUtils' => ['PWUtils/PWKit/**/*.{storyboard,xib,png}']}


  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'FDStackView'
  s.dependency 'Masonry'
  s.dependency 'WEPopover'
  s.dependency 'IQKeyboardManager', '~> 6.4.0'
  s.dependency 'YBPopupMenu', '~> 1.1.2'
  s.dependency 'EllipsePageControl'
  s.dependency 'SDAutoLayout'#, '~> 2.1.1'
  s.dependency 'MBProgressHUD', '1.1.0'
  s.dependency 'YYKit', '~> 1.0.9'
  s.dependency 'SDWebImage'
  s.dependency 'CHIPageControl', '~> 0.1.3'
  s.dependency 'SCPageControl'
  s.dependency 'SnapKit'

#  s.pod_target_xcconfig = {
##    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
##    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/**',
##    'LIBRARY_SEARCH_PATHS' => '$(inherited) ${PODS_ROOT}/**' ,
##    'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup',
#    "DEFINES_MODULE" => "YES"
#  }
#
##  s.static_framework = true
end
