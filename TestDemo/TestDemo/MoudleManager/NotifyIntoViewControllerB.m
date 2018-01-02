//
//  NotifyIntoViewControllerB.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "NotifyIntoViewControllerB.h"
#import "MoudleManager.h"
@implementation NotifyIntoViewControllerB

+(void)load
{
    [self registerNotify];
}

+(void)registerNotify
{
    [[NSNotificationCenter defaultCenter]addObserverForName:Notify_intoViewControllerB object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        ViewControllerA * controllerA = note.object;
        
        ViewControllerB * controllerB = [[ViewControllerB alloc]init];
        
        [controllerA presentViewController:controllerB animated:YES completion:nil];
        
    }];
    
}

@end
