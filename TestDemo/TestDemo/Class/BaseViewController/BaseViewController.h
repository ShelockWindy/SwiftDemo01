//
//  BaseViewController.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControllerCenterProtocol.h"


@interface BaseViewController : UIViewController <PageControllerCenterProtocol>

//绑定viewModel 业务
-(void)viewModelBind;

@end
