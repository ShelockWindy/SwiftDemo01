//
//  TwoViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/31.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "TwoViewController.h"
#import "ShareObject.h"

@interface TwoViewController ()<ShareObjectDelegate>

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ShareObject shareIncetance] addDelegate:self];
    
    self.navgationBarStyle = UIBaseViewControllerNavgationBarStyle_Custom;
    
    self.navigationController.navigationItem.title = @"2222";
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromClass([self class]));

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-ShareObjectDelegate
-(void)doSomeThingForEveryone
{
    
    NSLog(@"---%@--",NSStringFromClass([self class]));
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
