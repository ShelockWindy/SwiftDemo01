//
//  NSObject+CallSelector.m
//  Shipper
//
//  Created by Topjet on 16/7/29.
//  Copyright © 2016年 topjetm02. All rights reserved.
//

#import "NSObject+CallSelector.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <objc/message.h>

@interface NSInvocation (hello)

-(NSArray*)hello_Array;

@end


@implementation  NSInvocation (hello)

-(NSArray *)hello_Array
{
    NSLog(@"HELLO");
    return @[@"HELLO"];
}



@end

@implementation NSObject (CallSelector)
void exchangeMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}




+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL selector = @selector(viewDidAppear:);
        
        Class klass = [UIViewController class];
        Method targetMethod = class_getInstanceMethod(klass, selector);
        IMP targetMethodIMP = method_getImplementation(targetMethod);
        if (!(targetMethodIMP)) {
            // Make a method alias for the existing method implementation, it not already copied.
            const char *typeEncoding = method_getTypeEncoding(targetMethod);
            //        SEL aliasSelector = aspect_aliasForSelector(selector);
            SEL aliasSelector = selector;
            
            if (![klass instancesRespondToSelector:aliasSelector]) {
                __unused BOOL addedAlias = class_addMethod(klass, aliasSelector, method_getImplementation(targetMethod), typeEncoding);
                NSCAssert(addedAlias, @"Original implementation for %@ is already copied to %@ on %@", NSStringFromSelector(selector), NSStringFromSelector(aliasSelector), klass);
            }
            
            // We use forwardInvocation to hook in.
            
            // class_replaceMethod(klass, selector, targetMethodIMP, typeEncoding);
        }
        
    });

}

-(void)my_performSelector
{
    
    
}

-(void)sayhello:(NSString*)hello
{
    NSLog(@"%@",hello);
}

-(void)sayhello_Hao:(NSString*)hello
{
    NSLog(@"%@_hao",hello);
}


-(void)forwardInvocation:(NSInvocation *)anInvocation
{
    
}


+(NSArray *)test
{
    return nil;
}

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects
{
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    
    if (signature == nil) {
//        [NSException raise:@"牛逼的错误" format:@"%@方法找不到", NSStringFromSelector(selector)];
        NSLog(@"方法找不到");
        return nil;
    }
    
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    }
    
    return returnValue;
}

//+ (void)test {
//    
//    NSLog(@"开始执行方法");
////    int a = 1;
////    int b = 2;
////    int c = 3;
//    SEL myMethod = @selector(myLog:param:parm:);
////    // 创建一个函数签名，这个签名可以是任意的，但需要注意，签名函数的参数数量要和调用的一致。
//    NSMethodSignature *sig = [[self class] methodSignatureForSelector:myMethod];
//    // 通过签名初始化
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
////    //    2.FirstViewController *view = self;
////    //    2.[invocation setArgument:&view atIndex:0];
////    //    2.[invocation setArgument:&myMethod2 atIndex:1];
////    // 设置target
////    //    1.[invocation setTarget:self];
////    // 设置selector
////    [invocation setSelector:myMethod];
////    // 注意：1、这里设置参数的Index 需要从2开始，因为前两个被selector和target占用。
////    [invocation setArgument:&a atIndex:2];
////    [invocation setArgument:&b atIndex:3];
////    [invocation setArgument:&c atIndex:4];
////    //    [invocation retainArguments];
////    // 我们将c的值设置为返回值
////    [invocation setReturnValue:&c];
////    int d;
////    // 取这个返回值
////    [invocation getReturnValue:&d];
////    NSLog(@"d:%d", d);
////    
////    NSUInteger argCount = [sig numberOfArguments];
////    NSLog(@"argCount:%ld", argCount);;
////    
////    for (NSInteger i=0; i<argCount; i++) {
////        NSLog(@"%s", [sig getArgumentTypeAtIndex:i]);
////    }
////    NSLog(@"returnType:%s ,returnLen:%ld", [sig methodReturnType], [sig methodReturnLength]);
////    NSLog(@"signature:%@" , sig);
////    
////    // 消息调用
////    [invocation invokeWithTarget:self];
//    invocation.hello_Array;
//    
//}

+(int)myLog:(int)a param:(int)b parm:(int)c
{
    return a+b+c;
}


@end




