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


@end

@implementation BaseViewController

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subViewLoad];
    [self viewModelBind];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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







@end
