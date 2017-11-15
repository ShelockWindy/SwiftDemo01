//
//  UIBaseViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/28.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBaseViewController ()

@property (nonatomic,strong) UINavigationBar * my_NavgationBar;//自定义导航条

@end

@implementation UIBaseViewController

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        
        if (self.navigationController) {
            self.navigationController.navigationBar.translucent = NO;
            self.navigationController.navigationBar.hidden = YES;
            [self.view addSubview:self.my_NavgationBar];
        }
        [self setCustomDisplay];
    }else
    {
        [self setDefaultDisplay];
    }

}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (_navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        
        if (self.navigationController) {
            self.navigationController.navigationBar.hidden = NO;
            self.navigationController.navigationBar.translucent = YES;
            [self.my_NavgationBar removeFromSuperview];
        }
    }
}



#pragma mark- Events
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Public Methods



#pragma mark- Private Methods

-(void)setDefaultDisplay
{
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
}

-(void)setCustomDisplay
{
    self.my_NavgationBar.backgroundColor = [UIColor orangeColor];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(backAction:)];

    self.navigationItem.leftBarButtonItem = backItem;
}


#pragma mark- System Delegate





#pragma mark- Setter And Getter

-(void)setNavgationBarStyle:(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    _navgationBarStyle = navgationBarStyle;
    
}


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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
