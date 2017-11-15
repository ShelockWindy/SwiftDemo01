//
//  UIButton+TJExtension.m
//  附近车源
//
//  Created by shenyang on 16/3/30.
//  Copyright © 2016年 Topject. All rights reserved.
//

#import "UIButton+TJExtension.h"

@implementation UIButton (TJExtension)


- (void)verticalCenterImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (imageSize.height + spacing/2), 0.0);

    titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (titleSize.height + spacing/2), titleSize.width /2, 0.0, -titleSize.width /2);
}

- (void)verticalCenterImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self verticalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImage:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, imageSize.width + spacing/2);
    
    titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + spacing/2, 0.0, - titleSize.width);
}

- (void)horizontalCenterTitleAndImage
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImage:DEFAULT_SPACING];
}


- (void)horizontalCenterImageAndTitle:(CGFloat)spacing;
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0,  - spacing/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing/2, 0.0, 0.0);
}

- (void)horizontalCenterImageAndTitle;
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterImageAndTitle:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageLeft:(CGFloat)spacing
{
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, - spacing, 0.0, 0.0);
}

- (void)horizontalCenterTitleAndImageLeft
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImageLeft:DEFAULT_SPACING];
}


- (void)horizontalCenterTitleAndImageRight:(CGFloat)spacing
{

    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, 0.0, 0.0);
    
    
    titleSize = self.titleLabel.frame.size;
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width + imageSize.width + spacing, 0.0, - titleSize.width);
}

- (void)horizontalCenterTitleAndImageRight
{
    const int DEFAULT_SPACING = 6.0f;
    [self horizontalCenterTitleAndImageRight:DEFAULT_SPACING];
}

@end
