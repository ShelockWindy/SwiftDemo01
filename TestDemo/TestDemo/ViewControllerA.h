//
//  ViewControllerA.h
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerAProtocol

@property (nonatomic,copy) NSString * controllerName;


-(void)testViewControllerA;
-(void)intoViewControllerB;

@end

#define Notify_intoViewControllerB @"intoViewControllerB"

@interface ViewControllerA : UIViewController<ViewControllerAProtocol>

@end
