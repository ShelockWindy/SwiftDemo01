//
//  SycleScrollView.m
//
//  Created by sunwf on 2017/4/25.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SycleScrollView.h"

@interface SycleScrollView()
{
    UILabel * _contentLab;
    BOOL _stopAnimation;//终止滚动
    NSInteger _page;//页数
}

@end

@implementation SycleScrollView

-(instancetype)init
{
    self = [super init];
    
    if (self) {
        [self setContentView];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setContentView];
    }
    
    return self;
}

-(void)setContentView
{
    _speed = 15;
    _page = 0;
    
    _contentLab = [[UILabel alloc]init];
    _contentLab.textColor = [UIColor blackColor];
    _contentLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:_contentLab];
    
    self.layer.masksToBounds = YES;
   
    self.backgroundColor = [UIColor redColor];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
}


#pragma mark- Setter

-(void)setMessagesArray:(NSArray<NSString *> *)messagesArray
{
    _messagesArray = messagesArray;
    
    _contentLab.text = @"";
    for (NSString * message in _messagesArray) {
        
        if (_contentLab.text.length>0) {
            _contentLab.text = [NSString stringWithFormat:@"%@    %@",_contentLab.text,message];
        }else
        {
            _contentLab.text = message;
        }
    }
    
    CGSize size = [_contentLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_contentLab.font} context:nil].size;
    
    _contentLab.frame = CGRectMake(0, 0, size.width, self.bounds.size.height);
}

-(void)setPageEnable:(BOOL)pageEnable
{
    _pageEnable = pageEnable;
    
}


#pragma mark- Public Method
-(void)openScroll
{
    if (_pageEnable) {
        
        if (_page>_messagesArray.count-1) {
            _page = 0;
        }
        
        _contentLab.text = _messagesArray[_page];
        
        CGSize size = [_contentLab.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_contentLab.font} context:nil].size;
        
        CGFloat screenWidth =  [[UIScreen mainScreen]bounds].size.width;
        int count = size.width / screenWidth;
        int remain = (int)size.width  % (int)screenWidth;
        if (remain>0) {
            count ++;
        }
        _contentLab.frame = CGRectMake(_contentLab.frame.origin.x, _contentLab.frame.origin.y, screenWidth*count, self.bounds.size.height);
        
        _stopAnimation = NO;
        CGFloat W = CGRectGetWidth(_contentLab.bounds);
        CGFloat H = CGRectGetHeight(_contentLab.bounds);
        
        [UIView animateWithDuration:_speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _contentLab.frame = CGRectMake(-W, _contentLab.frame.origin.y, W, H);
            
        } completion:^(BOOL finished) {
            _contentLab.frame = CGRectMake( self.bounds.size.width, _contentLab.frame.origin.y, W, H);
            if (_stopAnimation==NO) {
                _page ++;
                [self openScroll];
            }else
            {
                _contentLab.frame = CGRectMake( 0, _contentLab.frame.origin.y, W, H);
            }
        }];
        
    }else
    {
        _stopAnimation = NO;
        CGFloat W = CGRectGetWidth(_contentLab.bounds);
        CGFloat H = CGRectGetHeight(_contentLab.bounds);
        
        [UIView animateWithDuration:_speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            _contentLab.frame = CGRectMake(-W, _contentLab.frame.origin.y, W, H);
            
        } completion:^(BOOL finished) {
            _contentLab.frame = CGRectMake( self.bounds.size.width, _contentLab.frame.origin.y, W, H);
            if (_stopAnimation==NO) {
                [self openScroll];
            }else
            {
                _contentLab.frame = CGRectMake( 0, _contentLab.frame.origin.y, W, H);
            }
        }];

    }
    
}


-(void)closeScroll
{
    _stopAnimation = YES;
}



@end
