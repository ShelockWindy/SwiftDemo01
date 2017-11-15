//
//  MainPageViewController.m
//  Shipper
//
//  Created by topjetm02 on 16/3/22.
//  Copyright © 2016年 topjetm02. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController ()
{
    
}

@end

@implementation MainPageViewController

- (instancetype)init {
    if (self = [super init]) {
        
        
    }
    return self;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

@end
