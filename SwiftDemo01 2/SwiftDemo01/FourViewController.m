//
//  FourViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/31.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "FourViewController.h"
#import "ShareObject.h"


@interface FourViewController ()<ShareObjectDelegate>

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[ShareObject shareIncetance] addDelegate:self];
}



-(void)viewWillAppear:(BOOL)animated
{
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
