//
//  UIinputPassWordView.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/26.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UIinputPassWordView.h"

@interface UIinputPassWordView()
{
    UITextField * _textFiled;//不显示只用来调出系统键盘,并监控输入文本
}

@property (nonatomic,strong) UIView * inputAccessView;

@end

@implementation UIinputPassWordView

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self setContentView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentView];
    }
    return self;
}

-(void)setContentView
{
   
    _textFiled = [[UITextField alloc]init];
    _textFiled.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_textFiled];
    
    _textFiled.hidden = YES;
    [_textFiled becomeFirstResponder];
    
    _textFiled.inputAccessoryView = self.inputAccessView;
}


#pragma mark- Getter

-(UIView *)inputAccessView
{
    if (_inputAccessView==nil) {
        CGRect rect = [[UIScreen mainScreen]bounds];
        _inputAccessView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rect.size.width, 222)];
        _inputAccessView.backgroundColor = [UIColor redColor];
        
        UIButton * backButt = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButt setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [backButt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [_inputAccessView addSubview:backButt];
        
        UILabel * titleLab = [[UILabel alloc]init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.text = @"输入密码";
        [_inputAccessView addSubview:titleLab];
        
        
        
    }
    
    return _inputAccessView;
}


#pragma mark-Public Method

-(void)showInputView
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.frame = rect;
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.35];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
       
        self.alpha = 1;
    }];
    
    
}

-(void)dismiss
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

@end
