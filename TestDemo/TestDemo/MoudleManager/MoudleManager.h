//
//  MoudleManager.h
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoudleConsit.h"

@interface MoudleManager : NSObject
@property(nonatomic, strong)  NSMutableArray      *BHModules;

+(MoudleManager*)instance;
-(id)getControllerWithProtocol:(Protocol*)protocol;

@end
