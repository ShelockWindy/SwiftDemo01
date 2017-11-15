//
//  UITextField+Restrict.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/29.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UITextField+Restrict.h"
#import <objc/runtime.h>


//由于子类在筛选的过程中都存在遍历字符串以及正则表达式验证的流程，把这一部分代码逻辑给封装起来。根据EOC的原则优先使用static inline的内联函数而非宏定义：

typedef BOOL(^TextFilter)(NSString * aString);
static inline NSString * kFilterString(NSString * handleString, TextFilter subStringFilter)
{
    NSMutableString * modifyString = handleString.mutableCopy;
    for (NSInteger idx = 0; idx < modifyString.length;) {
        NSString * subString = [modifyString substringWithRange: NSMakeRange(idx, 1)];
        if (subStringFilter(subString)) {
            idx++;
        } else {
            [modifyString deleteCharactersInRange: NSMakeRange(idx, 1)];
        }
    }
    return modifyString;
}

static inline BOOL kMatchStringFormat(NSString * aString, NSString * matchFormat)
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", matchFormat];
    return [predicate evaluateWithObject: aString];
}


@implementation TextRestrict

+(id)textRestrictWithRestrictType:(TextRestrictType)restrictType
{
    TextRestrict * textRestrict ;
    
    switch (restrictType) {
        case TextRestrictType_OnlyNUmber:
        {
            textRestrict = [[NumberTextRestrict alloc]init];
        }
            break;
        case TextRestrictType_OnlyCharacter:
        {
            textRestrict = [[CharacterTextRestrict alloc]init];

        }
            break;
        default:
            break;
    }
    textRestrict.maxLength = NSUIntegerMax;
    textRestrict.type = restrictType;
    return textRestrict;
}


-(void)textDidChanged:(UITextField *)textFiled
{
    
}

- (NSString *)restrictMaxLength: (NSString *)text
{
    if (text.length > _maxLength) {
        text = [text substringToIndex: self.maxLength];
    }
    return text;
}


@end


//子类实现

@implementation NumberTextRestrict

-(void)textDidChanged:(UITextField *)textFiled
{
     NSString * filterText = kFilterString(textFiled.text, ^BOOL(NSString *aString) {
        
        return kMatchStringFormat(aString, @"^\\d$");
    });

    textFiled.text = [self restrictMaxLength:filterText];
}

@end


@implementation CharacterTextRestrict

-(void)textDidChanged:(UITextField *)textFiled
{
     NSString * filterText = kFilterString(textFiled.text, ^BOOL(NSString *aString) {
       
        return kMatchStringFormat(aString, @"^[^[\\u4e00-\\u9fa5]]$");
    });
    
    textFiled.text = [super restrictMaxLength:filterText];
    
}

@end


static const char * restrictTypeKey = "restrictTypeKey";
static const char * restrictKey = "restrictKey";
static const char * maxLengthKey = "maxLengthKey";


@implementation UITextField (Restrict)


-(void)setRestrictType:(TextRestrictType)restrictType
{
    objc_setAssociatedObject(self, restrictTypeKey, @(restrictType), OBJC_ASSOCIATION_ASSIGN);
    self.textRestrict = [TextRestrict textRestrictWithRestrictType:restrictType];

}

-(TextRestrictType)restrictType
{
    return [objc_getAssociatedObject(self, restrictTypeKey) integerValue];
}


-(void)setTextRestrict:(TextRestrict *)textRestrict
{
    
    if (self.textRestrict) {
        
        [self removeTarget:self.text action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    textRestrict.maxLength = self.maxTextLength;
    [self addTarget:textRestrict action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    objc_setAssociatedObject(self, restrictKey, textRestrict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(TextRestrict *)textRestrict
{
    return objc_getAssociatedObject(self, restrictKey);
}


-(void)setMaxTextLength:(NSUInteger)maxTextLength{
    
    if (maxTextLength == 0) {
        maxTextLength = NSUIntegerMax;
    }
    
    objc_setAssociatedObject(self, maxLengthKey, @(maxTextLength), OBJC_ASSOCIATION_ASSIGN);
    self.textRestrict.maxLength = maxTextLength;
}

-(NSUInteger)maxTextLength
{
    NSUInteger maxTextLength =  [objc_getAssociatedObject(self, maxLengthKey) unsignedIntegerValue];

    if (maxTextLength == 0) {
        maxTextLength = NSUIntegerMax;
    }
    
    return maxTextLength;
}





@end
