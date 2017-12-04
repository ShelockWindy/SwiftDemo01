//
//  LoginViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   self.navigationController.navigationBarHidden = YES;
//    self.extendedLayoutIncludesOpaqueBars = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Override

-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Default;
}

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



#pragma mark- Public Methods


#pragma mark- Privates Methods


#pragma mark- ViewModel

-(LoginViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        _loginViewModel = [LoginViewModel new];
        [self.view addSubview:_loginViewModel.loginView];
    }
    
    return _loginViewModel;
}









@end
