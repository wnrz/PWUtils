
Pod::Spec.new do |s|


  s.name         = "PWUtils"
  s.version      = "0.0.1"
  s.summary      = "小组件"


  s.description  = "小组件"

  s.homepage     = "https://github.com/wnrz/PWUtils.git"

  s.license      = "MIT"

  s.author       = { "PW" => "66682060@qq.com" }


  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.public_header_files = 'PWUtils/**/*.h'
  s.source_files = 'PWUtils/**/*{h,m}'

  s.source = { :git => 'https://github.com/wnrz/PWUtils.git', :tag => s.version.to_s}
  

  s.requires_arc = true
  s.framework = "UIKit","Foundation"


  s.subspec 'PWUtils' do |ss|#
    ss.source_files = 'PWUtils/PWUtils/**/*.{h,m,c}'
    ss.ios.frameworks = 'UIKit', 'Foundation','UIKit'
  end

  s.resource_bundles = {'PWUtils' => ['PWUtils/PWUtils/**/*.{png,plist,xib}']}


  s.dependency 'PWDataBridge'
  s.dependency 'Masonry'
  s.dependency 'MJRefresh'
end
