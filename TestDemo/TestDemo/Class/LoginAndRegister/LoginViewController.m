//
//  LoginViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "SwitchViewController.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginViewModel * loginViewModel;

@end

@implementation LoginViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subViewLoad];
    [self viewModelBind];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Public Methods


#pragma mark- Privates Methods
-(void)subViewLoad
{
    self.loginViewModel.loginView.frame = self.view.bounds;
}

-(void)viewModelBind
{
   __weak typeof(self) weakSelf = self;
    self.loginViewModel.login_bind = ^(BOOL sucess, id viewModel) {
    
        [weakSelf pageTurnToViewControllerClass:@"SwitchViewController" fromCurrentViewController:weakSelf];
    };
}


#pragma mark- Lazy Load

-(LoginViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        _loginViewModel = [LoginViewModel new];
        [self.view addSubview:_loginViewModel.loginView];
    }
    
    return _loginViewModel;
}






@end
