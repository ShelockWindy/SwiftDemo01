//
//  ViewControllerB.h
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerBProtocol

@property (nonatomic,copy) NSString * controllerName;


-(void)testViewControllerB;

@end

#define Notify_intoViewControllerA @"intoViewControllerA"

@interface ViewControllerB : UIViewController<ViewControllerBProtocol>

@end
