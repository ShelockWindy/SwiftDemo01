require 'xcodeproj'  
project_path = '/Users/sunwf/Desktop/GitHub/test2.xcodeproj'    # 工程的全路径  
project = Xcodeproj::Project.open(project_path)  
  
# 1、显示所有的target  
project.targets.each do |target|  
  puts target.name  
end  
  
# 从工程中删除文件  
target = project.targets.first  
group = project.main_group.find_subpath(File.join('test2','newGroup'), true)  
group.set_source_tree('SOURCE_ROOT')  
  
def removeBuildPhaseFilesRecursively(aTarget, aGroup)  
    aGroup.files.each do |file|  
        if file.real_path.to_s.end_with?(".m", ".mm", ".cpp") then  
            aTarget.source_build_phase.remove_file_reference(file)  
            elsif file.real_path.to_s.end_with?(".plist") then  
            aTarget.resources_build_phase.remove_file_reference(file)  
        end  
    end  
      
    aGroup.groups.each do |group|  
        removeBuildPhaseFilesRecursively(aTarget, group)  
    end  
end  
  
if !group.empty? then  
    removeBuildPhaseFilesRecursively(target, group)  
    group.clear()  
    group.remove_from_project  
end  
  
project.save  
