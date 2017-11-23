//
//  LoginViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "LoginViewModel.h"
#import "LoginView.h"


typedef void(^LoginViewModel_Login)(BOOL sucess, id viewModel);


@interface LoginViewModel : BaseViewModel

@property (nonatomic,strong) LoginView * loginView;
@property (nonatomic,copy) LoginViewModel_Login  login_bind;


@end
