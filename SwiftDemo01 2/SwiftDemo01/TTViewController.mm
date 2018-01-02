//
//  TTViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/5/9.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "TTViewController.h"
#import "TestAutoHeightCell.h"
#import "UIWebView+HOOKDelegate.h"
#import <objc/runtime.h>


@interface TTViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    UIWebView * _webView ;
}
@end

@implementation TTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    
//    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
//    [tableView registerNib:[UINib nibWithNibName:( NSStringFromClass([TestAutoHeightCell class])) bundle:nil] forCellReuseIdentifier:@"reuseId"];
//
//    tableView.estimatedRowHeight = 20.f;
//    tableView.rowHeight = UITableViewAutomaticDimension;
//    [tableView reloadData];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [webView setDelegate:self];
    [self.view addSubview:webView];

    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    _webView = webView;
    
    
    Class newClass = NSClassFromString(@"People");
    
    
    id people = [[newClass alloc]init];
    [people setValue:@"男" forKey:@"sex"];
    [people setValue:@"18" forKey:@"age"];
    [people setValue:@"小明" forKey:@"name"];

    NSLog(@"%@",[people valueForKey:@"sex"]);
    

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

#pragma mark-  UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}


#pragma mark- UITableViewDelegate,UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellReuseId = @"reuseId";
    
    TestAutoHeightCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    
    
    if (indexPath.row%3==0) {
        cell.nameLab.text = @"11111";
        cell.contentLab.text = @"这是一个测试的内容，为了查看字体大小改变";
    }

    if (indexPath.row%3==1) {
        cell.nameLab.text = @"222";
        cell.contentLab.text = @"  这是一个测试的内容，为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果为了\n\n查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体大小改变的效果为了查看字体dasdada";
    }

    if (indexPath.row%3==2) {
        cell.nameLab.text = @"333";
        cell.contentLab.text = @"  这是一个测试的内容，为了查看字体大小改变的效果这是一个测试的内容，\n  为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果这是一个测试的内容，为了查看字体大小改变的效果这是一个测试的内容为了查看字体大小改变的效果";
    }
    
    

    return cell;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 120;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
