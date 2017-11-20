//
//  BaseViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "MBProgressHUD.h"

@implementation BaseViewModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void)loadView
{
}

-(void)showMessageWithContent:(NSString *)message
{
    if (self.currentView) {
    [MBProgressHUD showHUDAddedTo:self.currentView  animated:YES];
    }
}

-(void)showNetWorkProgressHUD
{
    
}



@end
