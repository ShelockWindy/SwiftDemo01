//
//  SycleScrollView.h
//
//  Created by sunwf on 2017/4/25.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SycleScrollView : UIView

@property (nonatomic,copy) NSArray<NSString*> * messagesArray;//消息内容
@property (nonatomic,assign) CGFloat speed;//完整滚动一次动画的秒数
@property (nonatomic,assign) BOOL  pageEnable;//是否分页显示，默认不分页

-(void)openScroll;
-(void)closeScroll;
@end
