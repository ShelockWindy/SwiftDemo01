
//
//  MainModel.m
//  DEMO_HELLO
//
//  Created by sunwf on 2017/2/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainModel.h"
#import <objc/runtime.h>

@implementation MainModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        //无符号整型
        unsigned int count = 0;
        //获取类中所有成员变量名
        Ivar * ivar = class_copyIvarList([MainModel class], &count);
        for (int i=0; i< count; i++) {
            Ivar iva = ivar[i];
            const char * name = ivar_getName(iva);
            NSString * strName = [NSString stringWithUTF8String:name];
            //解档
            id value = [aDecoder decodeObjectForKey:strName];
            //利用kvc 对属性赋值
            [self setValue:value forKey:strName];
            
        }
        
    }
    
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    //无符号整型
    unsigned int count = 0;
    //获取类中所有成员变量名
    Ivar * ivar = class_copyIvarList([MainModel class], &count);
    for (int i =0; i<count; i++) {
        Ivar iva = ivar[i];
        const char * name = ivar_getName(iva);
        NSString * strName = [NSString stringWithUTF8String:name];
        //利用kvc 获取属性
        id  value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
        
    }
    
    
}


-(id)copyWithZone:(NSZone *)zone
{
    MainModel * model = [MainModel allocWithZone:zone];
    
    //无符号整型
    unsigned int count = 0;
    //获取类中的所有成员变量名
    Ivar * ivar = class_copyIvarList([MainModel class], &count);
    for (int i=0; i<count; i++) {
        Ivar iva = ivar[i];
        const char * name = ivar_getName(iva);
        NSString * strName = [NSString stringWithUTF8String:name];
        //读取属性
        id value = [self valueForKey:strName];
        [model setValue:value forKey:strName];
        
    }
    
    return model;
}


//-(void)forwardInvocation:(NSInvocation *)anInvocation
//{
//    [super forwardInvocation:anInvocation];
//}
//
//-(id)forwardingTargetForSelector:(SEL)aSelector
//{
//    NSLog(@"询问是否转发方法");
//    id cls = [super forwardingTargetForSelector:aSelector];
//    
//    if (cls == nil) {
//        // 使用代理类处理消息
//        CurrentMemberInfo *p = [[CurrentMemberInfo alloc] init];
//        
//        if ([p respondsToSelector:aSelector]) {
//            return p; // 返回非nil，非self的对象，表示消息转发成功，不会发生崩溃
//        }
//    }
//    
//    return cls;
//}
//
//+(BOOL)resolveClassMethod:(SEL)sel
//{
//    return [super resolveClassMethod:sel];
//}
//
//
//+(BOOL)resolveInstanceMethod:(SEL)sel
//{
//    return [super resolveInstanceMethod:sel];
//}



@end


@implementation CurrentMemberInfo
- (id) initWithCoder:(NSCoder *)decoder
{
    if((self = [self init])!=nil)
    {
        self.userId=[decoder decodeObjectForKey:@"userId"];
        self.memberName=[decoder decodeObjectForKey:@"memberName"];
        self.credit=[decoder decodeObjectForKey:@"credit"];
        self.appraiseDegree=[decoder decodeObjectForKey:@"appraiseDegree"];
        self.score=[decoder decodeObjectForKey:@"score"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.userStatus = [decoder decodeObjectForKey:@"userStatus"];
        self.truckStatus = [decoder decodeObjectForKey:@"truckStatus"];
        self.companyName = [decoder decodeObjectForKey:@"companyName"];
    
        
    }
    return self;
}//initWithCoder
- (void) encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.userId forKey:@"userId"];
    [coder encodeObject:self.companyName forKey:@"companyName"];
    [coder encodeObject:self.memberName forKey:@"memberName"];
    [coder encodeObject:self.credit forKey:@"credit"];
    [coder encodeObject:self.appraiseDegree forKey:@"appraiseDegree"];
    [coder encodeObject:self.score forKey:@"score"];
    [coder encodeObject:self.phone forKey:@"phone"];
    [coder encodeObject:self.userStatus forKey:@"userStatus"];
    [coder encodeObject:self.truckStatus forKey:@"truckStatus"];
    
}

//-(id)copyWithZone:(NSZone *)zone
//{
//    CurrentMemberInfo  * info  = [CurrentMemberInfo allocWithZone:zone];
//
//    //无符号整型
//    unsigned int count = 0;
//    //获取类中的所有成员变量名
//    Ivar * ivar = class_copyIvarList([MainModel class], &count);
//    for (int i=0; i<count; i++) {
//        Ivar iva = ivar[i];
//        const char * name = ivar_getName(iva);
//        NSString * strName = [NSString stringWithUTF8String:name];
//        //读取属性
//        id value = [self valueForKey:strName];
//        [info setValue:value forKey:strName];
//        
//    }
//    
//    
//    return info;
//}


- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key{
    
}

@end


