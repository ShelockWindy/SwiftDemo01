//
//  BaseViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetWorkManagerCenterProtocol.h"

@interface BaseViewModel : NSObject<NetWorkManagerCenterProtocol>

@property (nonatomic,strong) UIView * currentView;//被绑定的viewController的界面


//加载view
-(void)loadView;

//显示提示信息
-(void)showSuccessMessageWithContent:(NSString *)message;
-(void)showFailMessageWithContent:(NSString*)message;

/**
 显示网络加载进度
 
 @param message 显示的文本
 @param enable 是否可操作界面，默认不可以
 */
-(void)showSuccessMessageWithContent:(NSString *)message  enable:(BOOL)enable;
-(void)showFailMessageWithContent:(NSString*)message enable:(BOOL)enable;

//显示网络请求进度
-(void)showNetWorkProgressHUD;
//隐藏网络请求进度
-(void)hidenNetWorkProgressHUD;
-(NSString*)currentGroupFilePathWithMFilePath:(char[])path;

@end
