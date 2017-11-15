//
//  NSObject+ClassPropertylIst.h
//
//  Created by sunwf on 2017/4/20.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Cl_Ivars_Method_Protocol)

/*
 *  返回当前类的所有属性列表
 */

+(NSArray*)cl_PropertysList;

/*
 *  返回当前类的成员变量数组
 */
+(NSArray*)cl_IvarList;

/*
 * 返回当前类的所有方法数组
 */
+(NSArray*)cl_MethodsList;

/*
 *  返回当前类的所有协议
 */
+(NSArray*)cl_ProtocolList;

@end
