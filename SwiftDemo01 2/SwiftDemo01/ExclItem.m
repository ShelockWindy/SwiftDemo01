//
//  ExclItem.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "ExclItem.h"


@interface ExclItem()
{
    NSString * _title;
}
@end


@implementation ExclItem

-(instancetype)init
{
    self = [super init];
    
    if (self) {
       
        _subSpace = 10;
        _titleSpace = 10;
    
        _itemVerticalSpace = 0;
        _itemVerticalSpace = 0;
        _contentColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        _fontSize = 15;
        
        
        _left = [[UIView alloc]init];
        _left.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_left];
        
        _right = [[UIView alloc]init];
        _right.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_right];
        
        _top = [[UIView alloc]init];
        _top.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_top];

        _bottom = [[UIView alloc]init];
        _bottom.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_bottom];

        
        [self setSubsCount:1];
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
    CGSize size ; CGFloat height=0;
    
    
    if (_title.length>0) {
        UILabel * titleLab = [self titleForSubs];
        CGSize titleSize =  [titleLab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLab.font} context:nil].size;
        
        if (titleLab.textAlignment == NSTextAlignmentCenter ) {
            titleLab.frame = CGRectMake((self.bounds.size.width-titleSize.width)/2, _titleSpace+height, titleSize.width, titleSize.height);

        }else if (titleLab.textAlignment == NSTextAlignmentLeft) {
            titleLab.frame = CGRectMake(10, _titleSpace+height, titleSize.width, titleSize.height);

        }else if (titleLab.textAlignment == NSTextAlignmentRight)
        {
            titleLab.frame = CGRectMake((self.bounds.size.width-titleSize.width)-10, _titleSpace+height, titleSize.width, titleSize.height);

        }
        
        height += titleSize.height+_titleSpace*2;
        
        for (int i=1; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            
            
            if (i==0) {
                lab.frame = CGRectMake(10, 10+height, size.width, size.height);
                height = height + size.height+10;

            }else
            {
                lab.frame = CGRectMake(10, _subSpace+height, size.width, size.height);
                height = height + size.height+_subSpace;

            }
            
            
        }

        
        
    }else
    {
        for (int i=0; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            
            if (i==0) {
                lab.frame = CGRectMake(10, 10+height, size.width, size.height);
                height = height + size.height+10;
                
            }else
            {
                lab.frame = CGRectMake(10, _subSpace+height, size.width, size.height);
                height = height + size.height+_subSpace;
                
            }

            
        }

    }

    
    if (_subs.count>1||_title.length<1) {
        height = height + _titleSpace ;
    }
    self.frame = CGRectMake(self.frame.origin.x , self.frame.origin.y, self.frame.size.width, height);
    
    _left.frame = CGRectMake(0, 0, 0.5, self.bounds.size.height);
    _right.frame = CGRectMake(self.bounds.size.width, 0, 0.5, self.bounds.size.height);
    _top.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    _bottom.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5);
      
    
}





#pragma mark- Public Methods

-(CGRect)getItemFrame
{
    CGSize size ; CGFloat height=0;
    
    
    if (_title.length>0) {
        UILabel * titleLab = [self titleForSubs];
        CGSize titleSize =  [titleLab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLab.font} context:nil].size;
        
        
        height = height + titleSize.height+_titleSpace*2;
        
        for (int i=1; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            if (i==0) {
                height = height + size.height+10;
                
            }else
            {
                height = height + size.height+_subSpace;
                
            }

            
            
        }
        
        
        
    }else
    {
        for (int i=0; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(self.bounds.size.width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            
            if (i==0) {
                height = height + size.height+10;
                
            }else
            {
                height = height + size.height+_subSpace;
                
            }

            
        }
        
    }
    
    
    if (_subs.count>1||_title.length<1) {
        height = height + _titleSpace ;
    }
    
    self.frame = CGRectMake(self.frame.origin.x , self.frame.origin.y, self.frame.size.width, height);
    
    
    return self.frame;
}

//---

-(CGRect)getItemFrameWithWidth:(CGFloat)width
{
    CGSize size ; CGFloat height=0;
    
    
    if (_title.length>0) {
        UILabel * titleLab = [self titleForSubs];
        CGSize titleSize =  [titleLab.text boundingRectWithSize:CGSizeMake(width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLab.font} context:nil].size;
        
        
        height = height + titleSize.height+_titleSpace*2;
        
        for (int i=1; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            if (i==0) {
                height = height + size.height+10;
                
            }else
            {
                height = height + size.height+_subSpace;
                
            }
            
            
            
        }
        
        
        
    }else
    {
        for (int i=0; i< _subs.count; i++) {
            
            UILabel * lab = [self subItemWithIndex:i];
            size = [lab.text boundingRectWithSize:CGSizeMake(width-10*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lab.font} context:nil].size;
            
            if (i==0) {
                height = height + size.height+10;
                
            }else
            {
                height = height + size.height+_subSpace;
                
            }
            
            
        }
        
    }
    
    
    if (_subs.count>1||_title.length<1) {
        height = height + _titleSpace ;
    }
    
    CGRect rect  = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
    
    
    return rect;
}




-(void)setSubsCount:(int)count
{
    for (UIView * v  in self.subviews) {
        
        if ([v isKindOfClass:[UILabel class]]) {
            [v removeFromSuperview];
        }
    }
    
    _subs = [NSMutableArray array];
    
    for (int i=0; i< count; i++) {
        
        UILabel * lab  = [[UILabel alloc]init];
        lab.textColor = _contentColor;
        lab.font = [UIFont systemFontOfSize:_fontSize];
        lab.numberOfLines = 0;
        
        [self addSubview:lab];
        [_subs addObject:lab];
        
    }
    
    
}


-(void)setTitle:(NSString*)title space:(CGFloat)space
{
    _titleSpace = space;

    [self setTitle:title];
}

-(void)setTitle:(NSString*)title
{
    _title = title;
    if (title.length>0) {
        
        UILabel * lab  = [[UILabel alloc]init];
        lab.text = title;
        lab.textColor = _contentColor;
        lab.font = [UIFont systemFontOfSize:_fontSize+2];
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:lab];
        [_subs insertObject:lab atIndex:0];
    }
    
}


-(UILabel*)subItemWithIndex:(NSInteger)index
{
    if (_subs.count>0) {
        UILabel * lab = _subs[index];
        return  lab;
    }
    
    return nil;
}

-(UILabel*)titleForSubs
{
    if (_title.length>0) {
        UILabel * lab = _subs[0];
        return  lab;
    }
    
    return nil;
}


#pragma mark -Private Methods




@end
