//
//  NSObject+ClassPropertylIst.m
//
//  Created by sunwf on 2017/4/20.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "NSObject+Cl_Ivars_Method_Protocol.h"
#import <objc/runtime.h>

@implementation NSObject (Cl_Ivars_Method_Protocol)

#pragma mark-  Get PropertyListArray Of Class

const void *  cl_propertysListKey = @"cl_propertysListKey";
+(NSArray *)cl_PropertysList
{
    NSArray * result = objc_getAssociatedObject(self, cl_propertysListKey);
    
    if (result != nil) {
        return result;
    }
    
    NSMutableArray * arrayM = [NSMutableArray array];
    //获取当前类的属性数组
    unsigned int count = 0 ;
    objc_property_t * list = class_copyPropertyList([self class], &count);

    for (unsigned int i=0; i< count; i++) {
       
        //根据下标获取属性
        objc_property_t property = list[i];
        //获取属性名
        const char * cName = property_getName(property);
        NSString * name = [NSString stringWithUTF8String:cName];

        [arrayM addObject:name];
        
    }
    
    //* 释放list
    free(list);
    
    //---保存属性数组----
    objc_setAssociatedObject(self, cl_propertysListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, cl_propertysListKey);
    
}


#pragma mark- Get IvarList Of Class

const void * cl_IvarListKey = @"cl_IvarListKey";

+(NSArray *)cl_IvarList
{
    //1.根据key查询保存的成员函数数组
    NSArray * ivarlist = objc_getAssociatedObject(self, cl_propertysListKey);
    
    //2。判断数组中是否有值，有的话直接返回
    if (ivarlist!=nil) {
        return ivarlist;
    }
    
    //3. 如果数组中没有，则查询当前类的所有成员变量
    
    unsigned int  count = 0;
    Ivar * ivars= class_copyIvarList([self class], &count);
    
    //4.查询成员变量并保存到数组
    NSMutableArray * arrayM = [NSMutableArray array];
    
    for (unsigned int i=0; i<count; i++) {
        
        Ivar ivar = ivars[i];
        const char * ivarName_C = ivar_getName(ivar);
        NSString * ivarName = [NSString stringWithUTF8String:ivarName_C];
        const char * ivarType_C = ivar_getTypeEncoding(ivar);
        NSString * ivarType = [NSString stringWithUTF8String:ivarType_C];
        ivarName = [NSString stringWithFormat:@"%@,%@",ivarType,ivarName];
        [arrayM addObject:ivarName];
    }
    
    free(ivars);
    
    objc_setAssociatedObject(self, cl_IvarListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, cl_IvarListKey);
}


#pragma mark- Get Methods Of Class
const void * cl_MethodsListKey = @"cl_MethodsListKey";

+(NSArray *)cl_MethodsList
{
    NSArray * results = objc_getAssociatedObject(self, cl_MethodsListKey);
    
    if (results!=nil) {
        return results;
    }
    
    unsigned int count = 0;
    Method * methodsList = class_copyMethodList([self class], &count);
    
    NSMutableArray * arrayM = [NSMutableArray array];
    
    for (unsigned int i=0; i<count ; i++) {
        
        Method  method = methodsList[i];
        SEL method_SEL = method_getName(method);
        NSString * methodName = NSStringFromSelector(method_SEL);
        IMP imp = method_getImplementation(method);
        const char * methodName_C = sel_getName(method_getName(method));
        int arguments = method_getNumberOfArguments(method);
        NSString * encodeing = [NSString stringWithUTF8String:method_getTypeEncoding(method)];
       
        NSLog(@"方法名%@，参数个数%d，编码类型%@",[NSString stringWithUTF8String:methodName_C],arguments,encodeing);
        [arrayM addObject:methodName];
    }
    
    objc_setAssociatedObject(self, cl_MethodsListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, cl_MethodsListKey);
}


#pragma mark- Get Protocols Of Class

const void * cl_ProtocolListKey = @"cl_ProtocolListKey";

+(NSArray *)cl_ProtocolList
{
    NSArray * results = objc_getAssociatedObject(self, cl_IvarListKey);
    
    if (results!=nil) {
        return results;
    }
    
    unsigned int count = 0;
    Protocol * __unsafe_unretained *protocolLits = class_copyProtocolList([self class], &count);
    
    NSMutableArray * arrayM =  [NSMutableArray array];
    for (unsigned int i=0; i<count; i++) {
        Protocol *protocol = protocolLits[i];
        const char * protocolName_C = protocol_getName(protocol);
        NSString * protocolName = [NSString stringWithUTF8String:protocolName_C];
        
        [arrayM addObject:protocolName];
    }
    
    free(protocolLits);
    
    objc_setAssociatedObject(self, cl_ProtocolListKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, cl_ProtocolListKey);
}




@end
