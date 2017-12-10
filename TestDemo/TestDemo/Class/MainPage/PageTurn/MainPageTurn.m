//
//  MainPageTurn.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageTurn.h"
#import "LoginViewController.h"
#import "MainPageViewController.h"

@implementation MainPageTurn

+(void)load
{
    NSString * value = NSStringFromClass([self class]);
    NSString * key =  NSStringFromClass([MainPageViewController class]);
    [[[PageControllerCenter shareInstance]pageDictionary]setValue:value forKey:key];
}


-(UIViewController *)pageTurnFromVC:(UIViewController *)fromVC
{
    MainPageViewController * viewController = [[MainPageViewController alloc]init];
    if ([fromVC isKindOfClass:[LoginViewController class]]) {
        viewController.view.backgroundColor = [UIColor brownColor];
    }
    return  viewController;
}


@end
