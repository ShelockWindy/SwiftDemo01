//
//  LoginView.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginView.h"
#import "Masonry.h"


@implementation LoginView

-(void)addSubViews
{
   //用户名
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.top.equalTo(@85);
        make.width.equalTo(@75);
        make.height.equalTo(@40);
    }];
    
    [self.userNameTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel.mas_right).offset(20);
        make.centerY.equalTo(self.userNameLabel);
        make.right.equalTo(@-50);
    }];
    
    //密码
    [self.passwordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.userNameLabel.mas_bottom);
        make.width.and.height.equalTo(self.userNameLabel);
    }];
    
    [self.passWordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordLabel.mas_right).offset(20);
        make.centerY.equalTo(self.passwordLabel);
        make.right.equalTo(@-50);
    }];
    
    //登录
    [self.loginButt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.equalTo(@50);
        make.top.equalTo(self.passwordLabel.mas_bottom).offset(75);
    }];
    
    
    
}

#pragma mark- Lazy Load

-(UILabel *)userNameLabel
{
    if (_userNameLabel==nil) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = @"密码：";
        _passwordLabel.textAlignment = NSTextAlignmentLeft;
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        _userNameLabel.textColor = [UIColor blackColor];
        [self addSubview:_userNameLabel];
    }
    return _userNameLabel;
}

-(UILabel *)passwordLabel
{
    if (_passwordLabel==nil) {
        _passwordLabel = [[UILabel alloc]init];
        _passwordLabel.text = @"用户名：";
        _passwordLabel.textColor = [UIColor blackColor];
        _userNameLabel.textAlignment = NSTextAlignmentLeft;
        _passwordLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_passwordLabel];
    }
    
    return _passwordLabel;
}

-(UITextField *)userNameTextFiled
{
    if (_userNameTextFiled==nil) {
        _userNameTextFiled = [[UITextField alloc]init];
        _userNameTextFiled.textColor = [UIColor darkTextColor];
        _userNameTextFiled.placeholder = @"请输入用户名";
        _userNameTextFiled.font = [UIFont systemFontOfSize:15];
        [self addSubview:_userNameTextFiled];
    }

    return _userNameTextFiled;
}

-(UITextField *)passWordTextFiled
{
    if (_passWordTextFiled==nil) {
        _passWordTextFiled = [[UITextField alloc]init];
        _passWordTextFiled.textColor = [UIColor darkTextColor];
        _passWordTextFiled.placeholder = @"请输入密码";
        _passWordTextFiled.font = [UIFont systemFontOfSize:15];
        [self addSubview:_passWordTextFiled];
    }
    
    return _passWordTextFiled;
}

-(UIButton *)loginButt
{
    if (_loginButt==nil) {
        _loginButt = [UIButton new];
        [_loginButt setTitle:@"登    录" forState:UIControlStateNormal];
        _loginButt.titleLabel.font = [UIFont systemFontOfSize:17];
        [_loginButt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButt setBackgroundColor:[UIColor blueColor]];
        _loginButt.layer.cornerRadius = 5;
        _loginButt.layer.masksToBounds = YES;
        [self addSubview:_loginButt];
    }
    
    return _loginButt;
}



@end
