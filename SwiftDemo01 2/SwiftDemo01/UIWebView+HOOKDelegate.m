//
//  UIWebView+HOOKDelegate.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/12/1.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UIWebView+HOOKDelegate.h"
#import <objc/runtime.h>
#import "HookWebViewDelegateMonitor.h"

@implementation UIWebView (HOOKDelegate)

static void dz_exchangeMethod(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL orginReplaceSel){
    // 原方法
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    // 替换方法
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    // 如果没有实现 delegate 方法，则手动动态添加
    if (!originalMethod) {
        Method orginReplaceMethod = class_getInstanceMethod(replacedClass, orginReplaceSel);
        BOOL didAddOriginMethod = class_addMethod(originalClass, originalSel, method_getImplementation(orginReplaceMethod), method_getTypeEncoding(orginReplaceMethod));
        if (didAddOriginMethod) {
//            NSLog(@"did Add Origin Replace Method");
        }
        return;
    }
    // 向实现 delegate 的类中添加新的方法
    // 这里是向 originalClass 的 replaceSel（@selector(replace_webViewDidFinishLoad:)） 添加 replaceMethod
    BOOL didAddMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (didAddMethod) {
        // 添加成功
//        NSLog(@"class_addMethod_success --> (%@)", NSStringFromSelector(replacedSel));
        // 重新拿到添加被添加的 method,这里是关键(注意这里 originalClass, 不 replacedClass), 因为替换的方法已经添加到原类中了, 应该交换原类中的两个方法
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        // 实现交换
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
        // 添加失败，则说明已经 hook 过该类的 delegate 方法，防止多次交换。
//        NSLog(@"Already hook class --> (%@)",NSStringFromClass(originalClass));
    }
}

+(void)load{
    // hook UIWebView
    Method originalMethod = class_getInstanceMethod([UIWebView class], @selector(setDelegate:));
    Method swizzledMethod = class_getInstanceMethod([UIWebView class], @selector(dz_setDelegate:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)dz_setDelegate:(id<UIWebViewDelegate>)delegate{
    [self dz_setDelegate:delegate];
    
    // 拿到 delegate 对象，在这里做替换 delegate 方法的操作
    [self exchangeUIWebViewDelegateMethod:delegate];
    
}

#pragma mark - hook webView delegate 方法

- (void)exchangeUIWebViewDelegateMethod:(id)delegate{
    dz_exchangeMethod([delegate class], @selector(webViewDidFinishLoad:), [self class], @selector(replace_webViewDidFinishLoad:),@selector(oriReplace_webViewDidFinishLoad:));
    
    
       dz_exchangeMethod([delegate class], @selector(webView:shouldStartLoadWithRequest:navigationType:), [self class], @selector(replace_webView:shouldStartLoadWithRequest:navigationType:),@selector(oriReplace_webView:shouldStartLoadWithRequest:navigationType:));
    
    
}

// 在未添加该 delegate 的情况下，手动添加 delegate 方法。
- (void)oriReplace_webViewDidFinishLoad:(UIWebView *)webView{
}

// 在添加该 delegate 的情况下，使用 swizzling 交换方法实现。
// 交换后的具体方法实现
- (void)replace_webViewDidFinishLoad:(UIWebView *)webView
{
    [self replace_webViewDidFinishLoad:webView];
}


- (BOOL)replace_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"统计加载完成数据");

   return   [self replace_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}


- (BOOL)oriReplace_webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"统计加载完成数据");

   return   [self oriReplace_webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

@end
