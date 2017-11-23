//
//  BaseViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewController.h"
#import "PageControllerCenter.h"

@interface BaseViewController ()

@property (nonatomic,strong) UINavigationBar * my_NavgationBar;//自定义导航条

@end

@implementation BaseViewController

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavgationBar];
    [self subViewLoad];
    [self viewModelBind];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        [self setDefaultDisplay];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Events
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Lazy Load



#pragma mark- Public Methods
-(void)subViewLoad
{
    
}


-(void)viewModelBind
{
    
}

-(void)pageTurnToViewControllerClass:(NSString *)viewControllerClass fromCurrentViewController:(id)currentVC
{
    [[PageControllerCenter shareInstance]pageTurnToViewControllerClass:viewControllerClass fromCurrentViewController:currentVC];
}

#pragma amrk- Private Methods

-(void)setUpNavgationBar
{
    if (self.navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        
        [self setCustomDisplay];
        if (self.navgationBarHiden) {
        }
        
    }else
    {
        [self setDefaultDisplay];
    }

    
    
}

-(void)setDefaultDisplay
{
    if (self.navigationController) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.translucent = YES;
        [self.my_NavgationBar removeFromSuperview];
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
}

-(void)setCustomDisplay
{
    if (!self.my_NavgationBar.superview) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.hidden = YES;
        [self.view addSubview:self.my_NavgationBar];
    }
    
    self.my_NavgationBar.backgroundColor = [UIColor orangeColor];
    
    for (UIView * sub in self.my_NavgationBar.subviews) {
        sub.hidden = YES;
    }
    
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(backAction:)];
    
    self.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark- Setter And Getter

-(void)setNavgationBarBackColor:(UIColor *)navgationBarBackColor
{
    self.my_NavgationBar.backgroundColor = navgationBarBackColor;
}

-(void)setNavgationBarBackImage:(UIImage *)navgationBarBackImage
{
    [self.my_NavgationBar setBackgroundImage:navgationBarBackImage forBarMetrics:UIBarMetricsDefault];
}


-(UINavigationBar *)my_NavgationBar
{
    if (!_my_NavgationBar) {
        _my_NavgationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        
    }
    
    return _my_NavgationBar;
}

-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Default;
}


@end
