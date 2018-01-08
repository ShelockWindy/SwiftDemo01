//
//  MoudleB.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "MoudleB.h"
#import <malloc/malloc.h>

@implementation MoudleB

+(void)load
{
    JSObjectionInjector *injector = [JSObjection defaultInjector]; // [1]
    injector = injector ? : [JSObjection createInjector]; // [2]
    injector = [injector withModule:[[self alloc] init]]; // [3]
    [JSObjection setDefaultInjector:injector]; // [4]
}

- (void)configure
{
    [self bindClass:[ViewControllerB class] toProtocol:@protocol(ViewControllerBProtocol)];

}

-(void)dealloc
{
    NSLog(@"MoudleB----dealloc!!!");
}

-(void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"Size of %@: %zd",@"MoudleB" , malloc_size((__bridge const void *) self));

    NSLog(@"MoudleB ------applicationDidBecomeActive!!!");
}

@end
