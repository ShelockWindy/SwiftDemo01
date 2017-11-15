//
//  UITextField+Adjust.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/18.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UITextField+Adjust.h"
#import <objc/runtime.h>


@implementation UITextField (Adjust)

static const char * autoAdjustKey = "autoAdjustKey";

-(void)setAutoAdjust:(BOOL)autoAdjust
{

    objc_setAssociatedObject(self, autoAdjustKey, @(autoAdjust), OBJC_ASSOCIATION_ASSIGN);
    
    if (autoAdjust) {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
        
    }else
    {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
    
}

-(BOOL)autoAdjust
{
   return  objc_getAssociatedObject(self, autoAdjustKey);
}


#pragma mark- keyboardWillShowNotification
-(void)keyboardWillShowNotification:(NSNotification*)notification
{
    if (self.isFirstResponder) {
        
        CGPoint relativePoint = [self convertPoint:CGPointZero toView:[[UIApplication sharedApplication] keyWindow]];
        CGFloat keyBoardHeight = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size.height;
        CGFloat actualHeight = CGRectGetHeight(self.frame) + relativePoint.y + keyBoardHeight;
        CGFloat overstep = actualHeight - CGRectGetHeight([UIScreen mainScreen].bounds) + 50;
        
        if (overstep >0) {
            CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
            CGRect frame = [[UIScreen mainScreen]bounds];
            frame.origin.y -= overstep;
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                
                [[UIApplication sharedApplication]keyWindow].frame = frame;
                
            } completion:^(BOOL finished) {
                
            }];
            
        }
        
    }
}

#pragma mark- keyboardWillHideNotification
-(void)keyboardWillHideNotification:(NSNotification*)notification
{
    
    if (self.isFirstResponder) {
    
        CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGRect frame = [[UIScreen mainScreen]bounds];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
           
            [[UIApplication sharedApplication]keyWindow].frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self endEditing:YES];
    
}



@end
