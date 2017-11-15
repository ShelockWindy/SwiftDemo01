//
//  NSObject+Extension.h
//  Shipper
//
//  Created by 沈阳 on 15/05/2017.
//  Copyright © 2017 topjetm02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (Extension)
/**
 *  自定义调用方法
 *
 *  @param selector 方法名
 *  @param objects  参数
 *
 *  @return 方法返回值
 */
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
/**
 *  添加方法
 *
 *  @param class 类
 *  @param selector  方法名
 *  @param imp  实现
 *  @param types  方法类型
 
 *  @return 添加结果
 */
- (BOOL)class_addMethod:(Class)class selector:(SEL)selector imp:(IMP)imp types:(const char *)types;
/**
 *  交换方法
 *
 *  @param sel1 方法1
 *  @param sel2  方法2
 *
 */
- (void)sel_exchangeFirstSel:(SEL)sel1 secondSel:(SEL)sel2;
/**
 *  交换方法
 *
 *  @param class 类
 *  @param sel1  方法名1
 *  @param sel2  方法名2
 *
 */
- (void)sel_exchangeClass:(Class)class FirstSel:(SEL)sel1 secondSel:(SEL)sel2;
/**
 *  获取方法实现
 *
 *  @param method 方法名
 *
 *  @return 方法实现指针
 */
- (IMP)method_getImplementation:(Method)method;
/**
 *  获取实例方法
 *
 *  @param class 类
 *  @param selector  方法名
 *
 *  @return 方法对象
 */
- (Method)class_getInstanceMethod:(Class)class selector:(SEL)selector;
/**
 *  检测类中是否包含方法
 *
 *  @param sel 方法名
 *  @param class  类
 *
 *  @return 是否包含
 */
- (BOOL)isContainSel:(SEL)sel inClass:(Class)class;
/**
 *  打印方法列表
 *
 *  @param class 类
 *
 */
- (void)log_class_copyMethodList:(Class)class;
@end
