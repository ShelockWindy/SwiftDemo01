//
//  ExclView.h
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//  表视图

#import <UIKit/UIKit.h>
#import "ExclItem.h"



@interface ExclView : UIView


@property (nonatomic,strong) UIColor *  lineColor;
@property (nonatomic,strong) NSMutableArray * itemsArr;

-(void)addHorizontalItem:(ExclItem*)item;
-(void)addVerticalItem:(ExclItem*)item;
-(void)updateLayouts;
-(CGRect)getLayoutRectWithMaxWidth:(CGFloat)width;

@end
