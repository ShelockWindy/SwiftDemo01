#!usr/bin/ruby -w

puts "正在读取文件"


#读取 autoMNodel.txt 
aFile = File.read("/Users/sunwf/Desktop/ShellDemo/autoModel.txt")

arr = IO.readlines("/Users/sunwf/Desktop/ShellDemo/autoModel.txt")


class AutoModel
   def initialize(name, h_path, m_path)
      @name=name.chomp 
      @hPath=h_path.chomp 
      @mPath=m_path.chomp 
   end

#getter
    def getName
    	@name
    end

    def getHPath
    	@hPath
    end

    def getMPath
    	@mPath
    end

#setter
     def setName(value)
     	@name = value.chomp 
     end

     def  setHPath(value)
     	@hPath = value.chomp 
     end

     def setMPath(value)
     	@mPath = value.chomp 
     	puts "#{value},,,,"
     end
	
   def display_details()
      puts "AutoModel name= #@name ,hPath= #@hPath , mPath= #@mPath"
  
    end

def AddReferenceFile()

require 'xcodeproj' 
project_path = '/Users/sunwf/Desktop/GitHub/test2.xcodeproj'    # 工程的全路径  
project = Xcodeproj::Project.open(project_path)  
  
# 1、显示所有的target  
project.targets.each do |target|  
  puts target.name  
end  
  
# 增加新的文件到工程中  
target = project.targets.first  
group = project.main_group.find_subpath(File.join('test2','Model'), true)  
group.set_source_tree('SOURCE_ROOT')  
  
# 获取全部的文件引用  
file_ref_list = target.source_build_phase.files_references  
  
# 设置文件引用是否存在标识  
file_ref_mark = false  
  
# 检测需要添加的文件是否存在  
for file_ref_temp in file_ref_list  
    puts file_ref_temp.path.to_s  
    if file_ref_temp.path.to_s.end_with?("#{@name}.m") then  
        file_ref_mark = true  
    end  
end  
  
if !file_ref_mark then  
    file_ref = group.new_reference(@hPath)  
    target.add_file_references([file_ref])  
    else  
    puts '文件引用已存在'  
end  
  
if !file_ref_mark then  
    file_ref = group.new_reference(@mPath)  
    target.add_file_references([file_ref])  
    else  
    puts '文件引用已存在'  
 
end
     project.save  
     puts '文件添加完成'     

#----------------------
  end

end
# 创建对象
# autoModel1=AutoModel.new("1", "John", "Wisdom Apartments, Ludhiya")
# autoModel2=AutoModel.new("2", "Poul", "New Empire road, Khandala")
 

# 调用方法
for i in arr 
  
 subArr = i.split("|")
 
   autoModel = AutoModel.new(subArr[0],subArr[1],subArr[2])
   puts autoModel.getName + autoModel.getHPath  + autoModel.getMPath
    autoModel.AddReferenceFile()


end


