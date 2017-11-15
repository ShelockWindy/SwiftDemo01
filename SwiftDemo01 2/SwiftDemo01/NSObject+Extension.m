//
//  NSObject+Extension.m
//  Shipper
//
//  Created by 沈阳 on 15/05/2017.
//  Copyright © 2017 topjetm02. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)
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
- (BOOL)class_addMethod:(Class)class selector:(SEL)selector imp:(IMP)imp types:(const char *)types {
    return class_addMethod(class,selector,imp,types);
}

- (void)sel_exchangeFirstSel:(SEL)sel1 secondSel:(SEL)sel2 {
    [self sel_exchangeClass:[self class] FirstSel:sel1 secondSel:sel2];
}

- (void)sel_exchangeClass:(Class)class FirstSel:(SEL)sel1 secondSel:(SEL)sel2 {
    Method firstMethod = class_getInstanceMethod(class, sel1);
    Method secondMethod = class_getInstanceMethod(class, sel2);
    method_exchangeImplementations(firstMethod, secondMethod);
    
}

- (void)method_exchangeImplementations:(Method)method1 method:(Method)method2 {
    method_exchangeImplementations(method1,method2);
}

- (IMP)method_getImplementation:(Method)method {
    return method_getImplementation(method);
}

- (Method)class_getInstanceMethod:(Class)class selector:(SEL)selector {
    return class_getInstanceMethod(class, selector);
}

- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *tempMethodString = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        if ([tempMethodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

- (void)log_class_copyMethodList:(Class)class {
    unsigned int count;
    Method *methodList = class_copyMethodList(class,&count);
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"%s%s",__func__,sel_getName(method_getName(method)));
    }
}

@end
