#!/usr/bin/ruby -w

# name1 = '蛮子'
# name2 = '提莫'
# name3 = '你好 \'ok?\' 对吗？'
# helloruby = name1 + name2
# puts "11111 #{name1}, #{name2}"

# puts "hello,rubby!"

#-----------------------------
# x, y, z = 12, 36, 72

# puts "x 的值为 #{ x }"
# puts "x + y 的值为 #{ x + y }"

# myStr = String.new("kkkkk")
# myStr = "this is a test"
# foo = myStr.downcase
 
# puts "#{foo}"

#-----------------------------
#类和对象
=begin
	这是一个多行注视	
=end

# class Sample
#    def hello
#       puts "Hello Ruby! 🐶"
#    end
# end
 
# # 使用上面的类来创建对象
# object = Sample. new
# object.hello


#-----------------------------
# 数组的使用
# arr = Array.new
# testStr = "张三+18+男+学生"
#  # arr = testStr.split 
# arr = ["ok","kko"]
# arr = testStr.split("+")

# name = arr[0]
# age = arr[1]
# sex = arr[2]
# job = arr[3]
# # puts name + age + sex + job

# length = arr.length

# for i in arr 
# 	puts i
# end

#-----------------------------
#文件读写
#读取txt文件
#  aFile = File.new("test.txt","r")
#  if aFile 
#  	content = aFile.sysread()


#  arr = IO.readlines("test.txt")
# for i in arr 
# 	#puts i
# end

path = File.dirname("__file__")
puts "路径是 #{path}"









