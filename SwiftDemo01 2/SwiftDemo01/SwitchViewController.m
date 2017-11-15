//
//  SwitchViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/31.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SwitchViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "UINavigationController+Extesion.h"

@interface SwitchViewController ()<UITabBarControllerDelegate>

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UINavigationController * oneVC = [[UINavigationController alloc]initWithRootViewController:[OneViewController new]];
    oneVC.title = @"oneVC";
    
    UINavigationController * twoVC = [[UINavigationController alloc]initWithRootViewController:[TwoViewController new]];
    twoVC.title = @"twoVC";

    UINavigationController * threeVC = [[UINavigationController alloc]initWithRootViewController:[ThreeViewController new]];
    threeVC.title = @"threeVC";

    UINavigationController * fourVC = [[UINavigationController alloc]initWithRootViewController:[FourViewController new]];
    fourVC.title = @"fourVC";

    self.delegate = self;
    self.viewControllers = @[oneVC,twoVC,threeVC,fourVC];
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
