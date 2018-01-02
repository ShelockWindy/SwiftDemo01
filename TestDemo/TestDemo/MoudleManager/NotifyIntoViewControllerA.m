//
//  NotifyIntoViewControllerA.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "NotifyIntoViewControllerA.h"
#import "MoudleManager.h"

@implementation NotifyIntoViewControllerA

+(void)load
{
    [self registerNotify];
}

+(void)registerNotify
{
    [[NSNotificationCenter defaultCenter]addObserverForName:Notify_intoViewControllerA object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
       ViewControllerB * controllerB  = note.object;
        
        ViewControllerA * controllerA  = [[ViewControllerA alloc]init];
        
        [controllerB presentViewController:controllerA animated:YES completion:nil];
        
    }];
    
}

@end
