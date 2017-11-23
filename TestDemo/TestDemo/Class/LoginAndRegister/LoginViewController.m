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
    self.navgationBarHiden = YES;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subViewLoad];
    [self viewModelBind];
    
   
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.navigationController.navigationBarHidden = YES;
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
