//
//  SwitchPageTurn.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SwitchPageTurn.h"
#import "LoginViewController.h"
#import "SwitchViewController.h"

@implementation SwitchPageTurn

+(void)load
{
    NSString * value = NSStringFromClass([self class]);
    NSString * key = NSStringFromClass([SwitchViewController class]);
    [[[PageControllerCenter shareInstance]pageDictionary]setValue:value forKey:key];
}


-(UIViewController*)pageTurnFromVC:(UIViewController *)fromVC
{
    SwitchViewController * switchVC = [[SwitchViewController alloc]init];
    
    if ([fromVC isKindOfClass:[LoginViewController class]]) {
        LoginViewController * loginVC = (LoginViewController*)fromVC;
        switchVC.view.backgroundColor = [UIColor redColor];
        switchVC.loginStyle = @"密码登录！！！";
        [switchVC logLoginStyle];
    }
    return switchVC;
}

@end
