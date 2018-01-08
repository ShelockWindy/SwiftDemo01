//
//  UIViewController+UmengMobclik.m
//  TestDemo
//
//  Created by sunwf on 2017/12/12.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UIViewController+UmengMobclik.h"
#import <objc/runtime.h>

@implementation UIViewController (UmengMobclik)
+(void)load
{
    [super load];
    [self hook_viewWillAppear];
    [self hook_viewWillDisAppear];
}

+(void)hook_viewWillAppear
{
    Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(new_viewWillAppear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

+(void)hook_viewWillDisAppear
{
    Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(new_viewWillDisappear:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

#pragma mark- Hook Method

-(void)new_viewWillAppear:(BOOL)animated
{
    [self new_viewWillAppear:animated];
}

-(void)new_viewWillDisappear:(BOOL)animated
{
    [self new_viewWillDisappear:animated];
    
}

@end
