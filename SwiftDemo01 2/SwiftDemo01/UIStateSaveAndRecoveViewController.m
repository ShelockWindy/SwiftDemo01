//
//  UIStateSaveAndRecoveViewController.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/4/5.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "UIStateSaveAndRecoveViewController.h"

@interface UIStateSaveAndRecoveViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerRestoration>
{
    UITableView *  _tableView;
}



@end

@implementation UIStateSaveAndRecoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navgationBarStyle = UIBaseViewControllerNavgationBarStyle_Custom;
    
    self.restorationIdentifier = NSStringFromClass([self class]);
    
    self.restorationClass = [self class];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellReuseId = @"cellReuseId";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
    }
    
   
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行", (long)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark- UIStateSaveAndRecove

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];

   _tableView.contentOffset =  CGPointMake(0, [coder decodeFloatForKey:@"contentY"]);
    
    
}

-(void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];

    [coder encodeFloat:_tableView.contentOffset.y forKey:@"contentY"];
    
}


- (void)applicationFinishedRestoringState
{
    [super applicationFinishedRestoringState];
}

+ (nullable UIViewController *) viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    return [[self alloc]init];
}

@end
