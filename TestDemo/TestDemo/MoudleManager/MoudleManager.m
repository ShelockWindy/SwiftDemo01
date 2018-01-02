//
//  MoudleManager.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "MoudleManager.h"

@implementation MoudleManager

+(MoudleManager*)instance
{
    static MoudleManager * moudleManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         moudleManager = [[MoudleManager alloc]init];
        
    });
    
    return moudleManager;
}


-(id)init
{
    self = [super init];
    if (self) {
    }
    
    return self;
}


-(id)getControllerWithProtocol:(Protocol*)protocol
{
    JSObjectionInjector *injector = [JSObjection defaultInjector]; // [1]
    UIViewController <ViewControllerAProtocol> *vc = [injector getObject:protocol];
    return vc;
}


@end
