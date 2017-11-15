//
//  TTViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/5/9.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
