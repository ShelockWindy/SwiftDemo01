//
//  ExclItem.h
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//  单元格视图

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,ExclItem_Direction) {
    ExclItem_Direction_Vertical,
    ExclItem_Direction_Horizontal,
};


@interface ExclItem : UIView

@property (nonatomic,assign) CGFloat subSpace;//子标题垂直间距
@property (nonatomic,assign) CGFloat titleSpace;//标题垂直间距
@property (nonatomic,assign) CGFloat itemHorizontalSpace;//子标题垂直间距
@property (nonatomic,assign) CGFloat itemVerticalSpace;//子标题水平间距
@property (nonatomic,assign) CGFloat fontSize;//字体大小
@property (nonatomic,strong) UIColor * contentColor;//内容颜色，如果需要单独改某一标题的颜色。subItemWithIndex,修改label的属性
@property (nonatomic,strong) UIView * left;//左边线
@property (nonatomic,strong) UIView * right;//右边线
@property (nonatomic,strong) UIView * top;//上边线
@property (nonatomic,strong) UIView * bottom;//下边线
@property (nonatomic,strong) NSMutableArray * subs;//下边线
@property (nonatomic,assign) ExclItem_Direction direction;



-(void)setSubsCount:(int)count;//default 只有一个
-(void)setTitle:(NSString*)title space:(CGFloat)space;
-(void)setTitle:(NSString*)title;
-(UILabel*)subItemWithIndex:(NSInteger)index;
-(CGRect)getItemFrame;
-(UILabel*)titleForSubs;
-(CGRect)getItemFrameWithWidth:(CGFloat)width;


@end
