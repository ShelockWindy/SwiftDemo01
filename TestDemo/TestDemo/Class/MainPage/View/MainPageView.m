//
//  MainPageView.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageView.h"

@implementation MainPageView

-(void)addSubViews
{
    UILabel * testLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 65, 200, 20)];
    testLab.text = @"456456456456456456";
    testLab.backgroundColor = [UIColor blueColor];
    [self addSubview:testLab];
    
}

@end
