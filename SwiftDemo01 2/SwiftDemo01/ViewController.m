//
//  ViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/1/18.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "ViewController.h"
//#import "SwiftDemo01-Swift.h"
#import "UIButton+TJExtension.h"
//#import "QMUIButton.h"
#import "MainModel.h"
#import "ExclView.h"
#import "PhotoBrowseNavigationViewController.h"
#import "TTViewController.h"

#import "NSObject+Cl_Ivars_Method_Protocol.h"
#import <CoreLocation/CoreLocation.h>
#import "NSObject+CallSelector.h"
#import "UIViewController+aspecttest.h"
#import "Aspects.h"
#import <CoreImage/CoreImage.h>
#import "UIFontView.h"
#import "UIAlertController+AttibuteText.h"

@interface ViewController ()<CLLocationManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    UIImageView * bgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    bgView.image = [UIImage imageNamed:@"33.png"];
//
//    self.title = @"abcd";
//
//    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height*20);
//    [self.view addSubview:scrollView];
//
//    [scrollView addSubview:bgView];


    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"星期一" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"星期二" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"星期二" style:UIAlertActionStyleDefault handler:nil];

    
    action1.titleColor = [UIColor redColor];
    action3.titleColor = [UIColor brownColor];
    action1.detaiMessage = @"加入黑名单！！！";
    [alertVC addAction:action1];
    [alertVC addAction:action3];
    [alertVC addAction:action2];

    [self presentViewController:alertVC animated:YES completion:nil];
    
//    NSArray * actions = alertVC.actions;
//    NSLog(@"%@",action2.detaiMessage);
//    UILabel * label = [UILabel new];
//    label.text = @"这是一个测试的内容！";
//    label.textColor = [UIColor redColor];
//    label.frame = CGRectMake(100, 100, 200, 100);

//    [alertVC.view addSubview:label];
    
    
//    NSString * dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//stringByAppendingPathComponent:@"tt.dat"];
//
//    CurrentMemberInfo * info = [[CurrentMemberInfo alloc]init];
//    info.userId = @"123131";
//    info.userStatus = @"3";
//    info.memberName = @"hello";
//    info.phone = @"1564547567465";
//
//    [NSKeyedArchiver archiveRootObject:info toFile:dataPath];
//
//
//    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
//    butt.frame = CGRectMake(100, 300, 100, 100);
//    butt.backgroundColor = [UIColor redColor];
//    //[self.view addSubview:butt];
//
//    [butt addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSArray * arr = [NSClassFromString(@"CAFilter")  cl_IvarList];
//    for (NSString * method in arr) {
//        NSLog(@"%@",method);
//    }
//    
    

//
//    [NSClassFromString(@"CAFilter") aspect_hookSelector:@selector(init) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo>  info ) {
//
////        UIVisualEffectView * effecrtView = info.instance;
////        NSArray * subViews = effecrtView.subviews;
////        UIView *  _backdropSubview = [effecrtView valueForKey:@"_backdropSubview"];
////        UIView *  _grayscaleSubview = [effecrtView valueForKey:@"_grayscaleSubview"];
////
////        _backdropSubview.hidden = YES;
////        _grayscaleSubview.hidden = YES;
//
//
//
//    } error:nil];
//
//
//
//
//    UIBlurEffect * effect = [UIBlurEffect effectWithStyle:0 ];
//
//    UIView * testView = [[UIVisualEffectView alloc]initWithEffect:effect];
//    testView.frame = CGRectMake(0, 0, 200, self.view.frame.size.height);
//    [self.view addSubview:testView];
//
//

    
    
    
    //_blurFiter  : _type 204 _name @"gaussianBlur"  ;
    //_saturateFiter : _type 89  _name  @"colorSaturate";
    //_colorOffsetFilter : _type 85  _name  @"colorMatrix";
    
 
    // Creating blur view using settings object
    
    // initialization of the blur view
//    _UIBackdropView *blurView = [[_UIBackdropView alloc] initWithFrame:CGRectZero
//                                               autosizesToFitSuperview:YES settings:settings];
//    // another way for initialization
//    _UIBackdropView *blurView = [[_UIBackdropView alloc] initWithSettings:settings];
//    
//    // or without settings object implementation
//    _UIBackdropView *blurView = [[_UIBackdropView alloc] initWithStyle:2060];
//    
//    [someView addSubview:blurView];
//    [blurView release];
    
    
    
}




-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


-(void)buttAction:(UIButton*)sender
{
    TTViewController * photoVC = [[TTViewController alloc]init];
   // [self presentViewController:photoVC animated:YES completion:^{
        
   // }];
    
    
    [self.navigationController pushViewController:photoVC animated:YES];

    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
