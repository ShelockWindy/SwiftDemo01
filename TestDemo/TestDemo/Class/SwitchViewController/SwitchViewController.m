//
//  SwitchViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SwitchViewController.h"

@interface SwitchViewController ()

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.hidesBottomBarWhenPushed = YES;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Public

-(void)logLoginStyle
{
    if (_loginStyle) {
        NSLog(@"登录的方式是--------%@",_loginStyle);
    }
}


@end
