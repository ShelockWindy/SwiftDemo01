//
//  MainModel.h
//  DEMO_HELLO
//
//  Created by sunwf on 2017/2/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MainModel : NSObject<NSCoding,NSCopying>

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * age;
@property (nonatomic,copy) NSString * work;
@property (nonatomic,assign) BOOL   finish;

@end



@interface CurrentMemberInfo : NSObject<NSCopying,NSCoding>
@property (nonatomic,copy  ) NSString       * userId;//用户ID
@property (nonatomic,copy  ) NSString       * phone;//用户手机号
@property (nonatomic,copy)   NSString       * userStatus;
@property (nonatomic,copy)   NSString       * truckStatus;
@property (nonatomic,copy  ) NSString       * memberName;//用户姓名
@property (nonatomic,copy  ) NSString       * credit;//诚信值
@property (nonatomic,copy  ) NSString       * companyName;//所在公司名
@property (nonatomic,copy  ) NSString       * appraiseDegree;//好评度
@property (nonatomic,copy  ) NSString       * score;//积分
@end


