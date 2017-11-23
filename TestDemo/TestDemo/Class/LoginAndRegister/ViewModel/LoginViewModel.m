//
//  LoginViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel()<UITextFieldDelegate>


@end

@implementation LoginViewModel

#pragma mark- override

-(void)loadView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc]init];
        self.currentView = _loginView;
    }
    
    _loginView.userNameTextFiled.delegate = self;
    [_loginView.userNameTextFiled addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _loginView.passWordTextFiled.delegate = self;
    [_loginView.passWordTextFiled addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [_loginView.loginButt addTarget:self action:@selector(loginButtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark- Public


#pragma mark- Delegate

#pragma mark  UITextFieldDelegate



#pragma mark- Events

-(void)textFiledChanged:(UITextField*)tf
{
    if ([tf  isEqual:_loginView.userNameTextFiled])
    {
        
        
    }else if ([tf isEqual:_loginView.passWordTextFiled])
    {
        
    }
}

-(void)loginButtAction:(UIButton*)sender
{
    [self showSuccessMessageWithContent:@"登录成功" enable:NO];
    if (self.login_bind) {
        self.login_bind(YES, self);
    }
}




@end
