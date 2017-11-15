//
//  OneViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/3/31.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "OneViewController.h"
#import "UIStateSaveAndRecoveViewController.h"
#import "ShareObject.h"
#import "UITextField+Restrict.h"
#import "UITextField+Adjust.h"
#import "NSObject+QMUI.h"
#import "NSObject+Cl_Ivars_Method_Protocol.h"
#import "UICustomAlertSheetView.h"
#import "SycleScrollView.h"
#import "UIAlertController+AttibuteText.h"
#import "UIinputPassWordView.h"
#import "MainModel.h"
#import "TTViewController.h"
#import "Aspects.h"

@interface OneViewController ()<ShareObjectDelegate>

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor brownColor];
    
    self.navigationController.navigationBar.hidden = YES;

    self.navigationController.title = @"dasdada";
    // Do any additional setup after loading the view.
    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(100, 100, 100, 100);
    butt.backgroundColor = [UIColor redColor];
    [butt addTarget:self action:@selector(buttAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:butt];
    
    [[ShareObject shareIncetance] addDelegate:self];
    
    UITextField * textFiled = [[UITextField alloc]initWithFrame:CGRectMake(50, 500, 300, 50)];
    textFiled.placeholder = @"最多只能输入10个字。";
    textFiled.restrictType = TextRestrictType_OnlyNUmber;
    textFiled.maxTextLength = 10;
    textFiled.autoAdjust = YES;
    
    [self.view addSubview:textFiled];
    
    SycleScrollView * sycleScrollView = [[SycleScrollView alloc]init];
    sycleScrollView.frame = CGRectMake(50, 400, self.view.bounds.size.width-100, 20);
    sycleScrollView.messagesArray = @[@"我觉得动态语言和静态语言是个很模糊的定义",@"动态语言（或者说偏向动态的语言）的优点应该是编码速度快",@"并且更容易适应不同的运行环境，因为很多事情都放到runtime去决定了"];
    sycleScrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:sycleScrollView];
    
    [sycleScrollView openScroll];
    
    
    NSString * dataPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
                           stringByAppendingPathComponent:@"tt.dat"];
    
    
    CurrentMemberInfo * info = [[CurrentMemberInfo alloc]init];
    info.userId = @"123131";
    info.userStatus = @"3";
    info.memberName = @"hello";
    info.phone = @"1564547567465";
    
    [NSKeyedArchiver archiveRootObject:info toFile:dataPath];

    CurrentMemberInfo * info2 = [NSKeyedUnarchiver unarchiveObjectWithFile:dataPath];
    
    [self aspect_hookSelector:@selector(buttAction:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIButton* sender) {
        NSLog(@"控制器 %@ 将要显示: %@", aspectInfo.instance, sender);
    } error:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromClass([self class]));

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}


#pragma mark-  buttAction

-(void)buttAction:(UIButton*)sender
{
    TTViewController * controller = [[TTViewController alloc]init];
    
    self.hidesBottomBarWhenPushed = YES;
//    [(UINavigationController*)[[UIApplication sharedApplication] keyWindow].rootViewController pushViewController:controller animated:YES];

    [self.navigationController pushViewController:controller animated:YES];

    [[ShareObject shareIncetance]sayHelloToTheDelegate];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}


#pragma mark-ShareObjectDelegate
-(void)doSomeThingForEveryone
{

    NSLog(@"---%@--",NSStringFromClass([self class]));
}


@end
