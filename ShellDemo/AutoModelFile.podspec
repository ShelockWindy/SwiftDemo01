

Pod::Spec.new do |s|
  s.name         = "AutoModelFile"
  s.version      = "1.0"
  s.summary      = "自动生成model文件"
  s.description  = <<-DESC
自动生成model文件 .h .m 支持字典嵌套
                   DESC

  s.homepage     = "http://ShelockWindy/AutoModelFile"
  s.license      = "MIT"
  s.author             = { "sunwf" => "2517185883@qq.com" }  
  s.platform     = :ios, '7.0'

  s.source       = { :git => "http://ShelockWindy/AutoModelFile.git", :tag => s.version }

#AutoModelFileManager 目录
 s.subspec 'AutoModelFileManager' do |ss|
   ss.source_files = 'AutoModelFile/AutoModelFile/AutoModelFileManager/*{h,m}'
   end
end

 
 
