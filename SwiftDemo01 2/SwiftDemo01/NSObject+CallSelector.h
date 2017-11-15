//
//  NSObject+CallSelector.h
//  Shipper
//
//  Created by Topjet on 16/7/29.
//  Copyright © 2016年 topjetm02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CallSelector)
/**
 *  自定义调用方法
 *
 *  @param selector 方法名
 *  @param objects  参数
 *
 *  @return 方法返回值
 */
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
+(NSArray *)test;
-(void)sayhello:(NSString*)hello;

@end
