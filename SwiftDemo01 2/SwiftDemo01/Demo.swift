//
//  Demo.swift
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/10.
//  Copyright © 2017年 sunwf. All rights reserved.
//

import Foundation


class MyClass {
    
    fileprivate static let aa = 100
    
    required init() {
        print("Hello, world")
    }
    
    func method() {
        
        // 这里的a是MyClass的元类型（metatype of MyClass）
        let a = type(of: self)
        
        // 这里直接通过MyClass的元类型对象a来访问MyClass的类成员aa
        var value = a.aa
        
        print("The value is: \(value)");
        
        // 这里的b是Int的类型（metatype of Int）
        let b = type(of: a.aa)
        
        // 如果要通过一个元类型来创建一个对象实例，那么必须显式地调用该结构体或类的构造方法
        value = b.init(20)
        print("The integer is: \(value)")
        
        // 一个结构体或类的元类型可以直接用该结构体或类名访问Type属性即可表示。
        // 但这里要注意的是，像这里的Int.Type只能作为对象的类型进行声明，而不能作为一个表达式来使用。
        // 所以，它也不能作为type(of:)函数的实参进行传递
        let c: Int.Type = type(of: type(of: self).aa)
        value = c.init("1234")!
        print("The value is: \(value)")
        
        //
        var name:String = "从"
        
        
        
        
    }
    
    //-------put out to use this code
    // 这一句会输出Hello, world
    //var type = type(of: MyClass())
    // 这里通过type类型显式调用init构造方法也会直接输出一次Hello, world
    //var mc = type.init()
    
    // 这里直接将MyClass类的元类型给type
    // type = MyClass.self
    //mc = type.init()
    //mc.method()
}
