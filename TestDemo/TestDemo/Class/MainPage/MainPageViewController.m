//
//  MainPageViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/23.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Public


#pragma mark- Override
-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Custom;
}

//-(UIButton *)backItem
//{
//    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
//    butt.frame = CGRectMake(0, 0, 65, 30);
//    [butt setTitle:@"454" forState:UIControlStateNormal];
//    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [butt addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    return butt;
//}

#pragma mark- Events

-(void)backItemAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark- Gether


@end
