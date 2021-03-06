//
//  ViewControllerA.m
//  TestDemo
//
//  Created by sunwf on 2018/1/2.
//  Copyright © 2018年 sunwf. All rights reserved.
//

#import "ViewControllerA.h"

@interface ViewControllerA ()

@end

@implementation ViewControllerA
@synthesize controllerName;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(150, 100, 100, 100);
    butt.backgroundColor = [UIColor blueColor];
    [self.view addSubview:butt];
    [butt addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * butt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    butt2.frame = CGRectMake(150, 300, 100, 100);
    butt2.backgroundColor = [UIColor redColor];
    [self.view addSubview:butt2];
    [butt2 addTarget:self action:@selector(butt2Action:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)buttAction:(UIButton*)sender
{
    [self intoViewControllerB];
}

-(void)butt2Action:(UIButton*)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)testViewControllerA
{
    NSLog(@"testViewControllerA-----ok!");
}

-(void)intoViewControllerB
{
    [[NSNotificationCenter defaultCenter]postNotificationName:Notify_intoViewControllerB object:self];
   
}

-(void)dealloc
{
    NSLog(@"testViewControllerA-----dealloc!");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
