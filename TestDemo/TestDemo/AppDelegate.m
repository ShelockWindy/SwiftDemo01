//
//  AppDelegate.m
//  TestDemo
//
//  Created by sunwf on 2017/11/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "DPNormalObject.h"
#import "DPDynamicProxy.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    [super application:application didFinishLaunchingWithOptions:launchOptions];
     self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyWindow];
    
    
//    LoginViewController * mainViewController = [[LoginViewController alloc]init];
//    mainViewController.view.backgroundColor = [UIColor whiteColor];
//
//    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController: mainViewController];
//
//    self.window.rootViewController = nav;
    
    [MoudleManager instance];
    
   // ViewControllerA* vc = (ViewControllerA*)[[MoudleManager instance]getControllerWithProtocol:@protocol(ViewControllerAProtocol)]; // [2]
    
    UIViewController<ViewControllerAProtocol> * vc =  [[MoudleManager instance] getControllerWithProtocol:@protocol(ViewControllerAProtocol)];
    
     // UIViewController<ViewControllerAProtocol> * vc =  [[JSObjection defaultInjector] getObject:@protocol(ViewControllerAProtocol)];
    
    vc.controllerName = @"ViewControllerA"; // [3]
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nc;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [vc testViewControllerA];
    

    
    return YES;
}


@end
