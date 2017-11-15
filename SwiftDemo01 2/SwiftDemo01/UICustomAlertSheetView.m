//
//  UICustomAlertSheetView.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/25.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UICustomAlertSheetView.h"

@interface UICustomAlertSheetView()
{
    UIView * _contentView;
}

@end

@implementation UICustomAlertSheetView

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
    
    _contentView = [UIView new];
    _contentView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_contentView];
}


-(void)show
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    self.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
    _contentView.backgroundColor = [UIColor redColor];
    _contentView.frame = CGRectMake(0, rect.size.height, rect.size.width, rect.size.height*0.55);
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        _contentView.frame = CGRectMake(0, rect.size.height*0.45, rect.size.width, rect.size.height*0.55);
        self.alpha = 1;
        
    } completion:^(BOOL finished) {
    }];
}


-(void)dismiss
{
    CGRect rect = [[UIScreen mainScreen]bounds];
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
        _contentView.frame = CGRectMake(0, rect.size.height, rect.size.width, rect.size.height*0.55);
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
