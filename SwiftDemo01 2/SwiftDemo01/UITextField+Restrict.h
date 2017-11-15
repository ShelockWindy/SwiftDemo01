//
//  UITextField+Restrict.h
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/29.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,TextRestrictType) {
    TextRestrictType_OnlyCharacter,//只允许非中文字符
    TextRestrictType_OnlyNUmber,//只允许输入数字

};


@interface  TextRestrict: NSObject

@property (nonatomic,assign) NSUInteger maxLength;
@property (nonatomic,assign) TextRestrictType type;

//工厂
+(id)textRestrictWithRestrictType:(TextRestrictType)restrictType;
//子类实现来限制文字的内容
-(void)textDidChanged:(UITextField*)textFiled;
- (NSString *)restrictMaxLength: (NSString *)text;

@end


@interface NumberTextRestrict : TextRestrict
@end


@interface CharacterTextRestrict : TextRestrict
@end



@interface UITextField (Restrict)

/// 设置后生效
@property (nonatomic, assign) TextRestrictType restrictType;
/// 文本最长长度
@property (nonatomic, assign) NSUInteger maxTextLength;
/// 设置自定义的文本限制
@property (nonatomic, strong) TextRestrict * textRestrict;

@end
