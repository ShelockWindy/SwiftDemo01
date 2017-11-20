//
//  BaseViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "MBProgressHUD.h"
#import "ProgressHUD.h"

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

-(void)showSuccessMessageWithContent:(NSString *)message
{
    if (self.currentView) {
        [ProgressHUD showSuccess:message Interaction:NO];
    }
}

-(void)showFailMessageWithContent:(NSString *)message
{
    if (self.currentView) {
        [ProgressHUD showError:message Interaction:NO];
    }
}


-(void)showSuccessMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    if (self.currentView) {
        [ProgressHUD showSuccess:message Interaction:enable];
    }
}

-(void)showFailMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    if (self.currentView) {
        [ProgressHUD showError:message Interaction:enable];
    }
}


-(void)showNetWorkProgressHUD
{
    if (self.currentView) {
        [MBProgressHUD showHUDAddedTo:self.currentView  animated:YES];
    }
}

-(void)hidenNetWorkProgressHUD
{
    if (self.currentView) {
        [MBProgressHUD hideHUDForView:self.currentView animated:NO];
    }
}

@end
