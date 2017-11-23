//
//  CustomNavgationBar.m
//  TestDemo
//
//  Created by sunwf on 2017/11/23.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "CustomNavgationBar.h"

@implementation CustomNavgationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.subviews) {
            if([NSStringFromClass([view class]) containsString:@"Background"]) {
                view.frame = self.bounds;
            }
            else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
                CGRect frame = view.frame;
                frame.origin.y = 20;
                frame.size.height = self.bounds.size.height - frame.origin.y;
                view.frame = frame;
            }
        }
    }
#endif
}

@end
