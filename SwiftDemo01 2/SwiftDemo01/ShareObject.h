//
//  ShareObject.h
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/12.
//  Copyright © 2017年 sunwf. All rights reserved.
//  多代理的使用

#import <Foundation/Foundation.h>

@protocol ShareObjectDelegate <NSObject>

@optional
-(void)doSomeThingForEveryone;

@end


@interface ShareObject : NSObject

+(ShareObject*)shareIncetance;

-(void)sayHelloToTheDelegate;
-(void)addDelegate:(id<ShareObjectDelegate>)delegate;
-(void)removeDelegate:(id<ShareObjectDelegate>)delegate;

@end
