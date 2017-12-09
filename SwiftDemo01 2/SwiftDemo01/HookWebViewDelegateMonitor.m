//
//  HookWebViewDelegateMonitor.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/12/1.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "HookWebViewDelegateMonitor.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation HookWebViewDelegateMonitor

static void hook_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel){
    // 原方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    //    assert(originalMethod);
    // 替换方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    //    assert(originalMethod);
    IMP replacedMethodIMP = method_getImplementation(replacedMethod);
    // 向实现delegate的类中添加新的方法
    BOOL didAddMethod = class_addMethod(originalClass, replacedSel, replacedMethodIMP, "v@:@@");
    if (didAddMethod) { // 添加成功
//        NSLog(@"class_addMethod_success --> (%@)", NSStringFromSelector(replacedSel));
    }
    // 重新拿到添加被添加的method,这部是关键(注意这里originalClass, 不replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
    Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
    // 实现交换
    method_exchangeImplementations(originalMethod, newMethod);
}

+ (void)exchangeUIWebViewDelegateMethod:(Class)aClass{
    // 分别hook它的所有代理方法
    hook_exchangeMethod(aClass, @selector(webViewDidStartLoad:), [self class], @selector(replace_webViewDidStartLoad:));
    hook_exchangeMethod(aClass, @selector(webViewDidFinishLoad:), [self class], @selector(replace_webViewDidFinishLoad:));
    hook_exchangeMethod(aClass, @selector(webView:didFailLoadWithError:), [self class], @selector(replace_webView:didFailLoadWithError:));
    hook_exchangeMethod(aClass, @selector(webView:shouldStartLoadWithRequest:navigationType:), [self class], @selector(replace_webView:shouldStartLoadWithRequest:navigationType:));
}

@end

