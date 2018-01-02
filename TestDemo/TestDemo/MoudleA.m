//
//  MoudleA.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "MoudleA.h"

@implementation MoudleA

+(void)load
{
    JSObjectionInjector *injector = [JSObjection defaultInjector]; // [1]
    injector = injector ? : [JSObjection createInjector]; // [2]
    injector = [injector withModule:[[MoudleA alloc] init]]; // [3]
    [JSObjection setDefaultInjector:injector]; // [4]
}

- (void)configure
{
    [self bindClass:[ViewControllerA class] toProtocol:@protocol(ViewControllerAProtocol)];
}



@end
