//
//  ExclView.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/2/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "ExclView.h"


typedef struct {
    
    NSInteger  EclItemHorizontalIndex;//当前单元格水平方向索引
    NSInteger  EclItemHorizontalAdjacentCount;//当前单元格水平方向相邻数目
    CGFloat    EclItemHorizontalMaxHeight;//当前单元格水平方向最大高度

}EeclItemHorizontal;


@interface ExclView()
{
    EeclItemHorizontal  currentEeclItemHorizontal;
}

@property (nonatomic,strong) UIView * borderLeft;
@property (nonatomic,strong) UIView * borderRight;
@property (nonatomic,strong) UIView * borderBottom;

@end

@implementation ExclView

-(instancetype)init
{
    self = [super init];
    
    if (self) {
       
        _itemsArr = [NSMutableArray array];
        _borderLeft = [UIView new];
        [self addSubview:_borderLeft];
        
        _borderRight = [UIView new];
        [self addSubview:_borderRight];

        _borderBottom = [UIView new];
        [self addSubview:_borderBottom];
     
        
        _lineColor = [UIColor lightGrayColor];
        
    }
    
    return self;
}


#pragma mark- Public Methods

-(void)addHorizontalItem:(ExclItem*)item
{
    item.direction = ExclItem_Direction_Horizontal;
    [self addSubview:item];
    [_itemsArr addObject:item];
}

-(void)addVerticalItem:(ExclItem*)item
{
    item.direction = ExclItem_Direction_Vertical;
    [self addSubview:item];
    [_itemsArr addObject:item];
}


#pragma mark-  Private Methods

-(ExclItem*)exclItemOfIndex:(NSInteger)index
{
    if (_itemsArr.count>0) {
        ExclItem * item = _itemsArr[index];
        return item;
    }
    return  nil;
}


#pragma mark- Ovverride

-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat x =0; CGFloat y=0;
    
    currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
    currentEeclItemHorizontal.EclItemHorizontalAdjacentCount = 1;
    
    for (int i =0; i< _itemsArr.count; i++) {
        
        ExclItem * item = _itemsArr[i];
        
        if (item.direction == ExclItem_Direction_Vertical) {
            
            currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
            currentEeclItemHorizontal.EclItemHorizontalAdjacentCount = 1;
            currentEeclItemHorizontal.EclItemHorizontalMaxHeight = 0;

            item.frame = CGRectMake(x, y, self.bounds.size.width, self.bounds.size.height);
            
            CGRect rect = [item getItemFrame];
            
            y += rect.size.height+item.itemVerticalSpace;
            

        }else
        {
            
            NSInteger lastIndex = i-1;
            NSInteger nextIndex = i+1;
            
            [self getCurrentEeclItemHorizontalAdjacentCountForItem:[self exclItemOfIndex:i]];
            
            if (lastIndex>=0&& [self exclItemOfIndex:lastIndex].direction == ExclItem_Direction_Vertical) {
                
                currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
            }
            
            
            item.frame = CGRectMake((self.bounds.size.width/currentEeclItemHorizontal.EclItemHorizontalAdjacentCount)*currentEeclItemHorizontal.EclItemHorizontalIndex, y, (self.bounds.size.width/currentEeclItemHorizontal.EclItemHorizontalAdjacentCount), self.bounds.size.height);
            
            CGRect rect = [item getItemFrame];
            
            
            if (currentEeclItemHorizontal.EclItemHorizontalMaxHeight<rect.size.height) {
                currentEeclItemHorizontal.EclItemHorizontalMaxHeight = rect.size.height;
            }
            
            
            if ([self exclItemOfIndex:i].direction == ExclItem_Direction_Vertical) {
                y += rect.size.height;
            }
            
           else  if ([self exclItemOfIndex:i].direction == ExclItem_Direction_Horizontal) {
               
               if (i==_itemsArr.count-1) {
                   
                   y+= currentEeclItemHorizontal.EclItemHorizontalMaxHeight;

               }else if ([self exclItemOfIndex:nextIndex].direction == ExclItem_Direction_Vertical)
               {
                   y+= currentEeclItemHorizontal.EclItemHorizontalMaxHeight;

               }
               
            }
            
            currentEeclItemHorizontal.EclItemHorizontalIndex ++;

        }
        
        item.left.backgroundColor =
        item.right.backgroundColor=
        item.top.backgroundColor =
        item.bottom.backgroundColor = _lineColor;

    }
    
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, y);
    
    self.borderLeft.frame = CGRectMake(0, 0, 0.5, self.bounds.size.height);
    self.borderRight.frame = CGRectMake(self.bounds.size.width,0 , 0.5,self.bounds.size.height );
    self.borderBottom.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 0.5);
    
    self.borderLeft.backgroundColor =
    self.borderRight.backgroundColor =
    self.borderBottom.backgroundColor = _lineColor;


}

-(void)getCurrentEeclItemHorizontalAdjacentCountForItem:(ExclItem*)item
{
    currentEeclItemHorizontal.EclItemHorizontalAdjacentCount = 0;
    
    for (int i=0; i< _itemsArr.count; i++) {
        
        ExclItem * theIitem = [self exclItemOfIndex:i];
        
       
        if ( theIitem.direction == ExclItem_Direction_Horizontal) {
            
            _borderRight.hidden = NO;
            _borderLeft.hidden = NO;
            _borderBottom.hidden = NO;
            
            currentEeclItemHorizontal.EclItemHorizontalAdjacentCount ++;
            theIitem.bottom.hidden = YES;
            
            if ([theIitem isEqual:item]&&i<=_itemsArr.count-2&&[self exclItemOfIndex:i+1].direction == ExclItem_Direction_Vertical) {
               
                return;
            }
            
        }
        
    }
    
    if (currentEeclItemHorizontal.EclItemHorizontalAdjacentCount == 0) {
        currentEeclItemHorizontal.EclItemHorizontalIndex = 1;
    }

}


-(CGRect)getLayoutRectWithMaxWidth:(CGFloat)width
{
    CGRect rect;
    
    CGFloat x =0; CGFloat y=0;
    
    currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
    currentEeclItemHorizontal.EclItemHorizontalAdjacentCount = 1;
    
    for (int i =0; i< _itemsArr.count; i++) {
        
        ExclItem * item = _itemsArr[i];
        
        if (item.direction == ExclItem_Direction_Vertical) {
            
            currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
            currentEeclItemHorizontal.EclItemHorizontalAdjacentCount = 1;
            currentEeclItemHorizontal.EclItemHorizontalMaxHeight = 0;
            
            CGRect rect = [item getItemFrameWithWidth:width];
            
            y += rect.size.height+item.itemVerticalSpace;
            
            
        }else
        {
            
            NSInteger lastIndex = i-1;
            NSInteger nextIndex = i+1;
            
            [self getCurrentEeclItemHorizontalAdjacentCountForItem:[self exclItemOfIndex:i]];
            
            if (lastIndex>=0&& [self exclItemOfIndex:lastIndex].direction == ExclItem_Direction_Vertical) {
                
                currentEeclItemHorizontal.EclItemHorizontalIndex = 0;
            }
            
            
           // item.frame = CGRectMake((self.bounds.size.width/currentEeclItemHorizontal.EclItemHorizontalAdjacentCount)*currentEeclItemHorizontal.EclItemHorizontalIndex, y, (self.bounds.size.width/currentEeclItemHorizontal.EclItemHorizontalAdjacentCount), self.bounds.size.height);
            
            CGRect rect = [item getItemFrameWithWidth:(self.bounds.size.width/currentEeclItemHorizontal.EclItemHorizontalAdjacentCount)];
            
            
            if (currentEeclItemHorizontal.EclItemHorizontalMaxHeight<rect.size.height) {
                currentEeclItemHorizontal.EclItemHorizontalMaxHeight = rect.size.height;
            }
            
            
            if ([self exclItemOfIndex:i].direction == ExclItem_Direction_Vertical) {
                y += rect.size.height;
            }
            
            else  if ([self exclItemOfIndex:i].direction == ExclItem_Direction_Horizontal) {
                
                if (i==_itemsArr.count-1) {
                    
                    y+= currentEeclItemHorizontal.EclItemHorizontalMaxHeight;
                    
                }else if ([self exclItemOfIndex:nextIndex].direction == ExclItem_Direction_Vertical)
                {
                    y+= currentEeclItemHorizontal.EclItemHorizontalMaxHeight;
                    
                }
                
            }
            
            currentEeclItemHorizontal.EclItemHorizontalIndex ++;
            
        }
      
        
    }
    
    
    rect = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, y);
    
    return  rect;
}





-(void)updateLayouts
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIResponder * responder = [self nextResponder];
}


@end
