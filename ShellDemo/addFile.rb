require 'xcodeproj'  
project_path = '/Users/sunwf/Desktop/GitHub/test2.xcodeproj'    # 工程的全路径  
project = Xcodeproj::Project.open(project_path)  
  
# 1、显示所有的target  
project.targets.each do |target|  
  puts target.name  
end  
  
# 增加新的文件到工程中  
target = project.targets.first  
group = project.main_group.find_subpath(File.join('test2','newGroup'), true)  
group.set_source_tree('SOURCE_ROOT')  
  
# 获取全部的文件引用  
file_ref_list = target.source_build_phase.files_references  
  
# 设置文件引用是否存在标识  
file_ref_mark = false  
  
# 检测需要添加的文件是否存在  
for file_ref_temp in file_ref_list  
    puts file_ref_temp.path.to_s  
    if file_ref_temp.path.to_s.end_with?('TestViewController.m') then  
        file_ref_mark = true  
    end  
end  
  
if !file_ref_mark then  
    file_ref = group.new_reference('/Users/sunwf/Desktop/GitHub/test2/TestViewController.h')  
    target.add_file_references([file_ref])  
    else  
    puts '文件引用已存在'  
end  
  
if !file_ref_mark then  
    file_ref = group.new_reference('/Users/sunwf/Desktop/GitHub/test2/TestViewController.m')  
    target.add_file_references([file_ref])  
    else  
    puts '文件引用已存在'  
end  
project.save  
puts '文件添加完成'  
