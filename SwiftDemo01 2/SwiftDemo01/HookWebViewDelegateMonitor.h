//
//  HookWebViewDelegateMonitor.h
//  SwiftDemo01
//
//  Created by sunwf on 2017/12/1.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HookWebViewDelegateMonitor : NSObject
+ (void)exchangeUIWebViewDelegateMethod:(Class)aClass;
@end
