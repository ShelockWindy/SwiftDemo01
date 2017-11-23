//
//  AppDelegate.m
//  SwiftDemo01
//
//  Created by sunwf on 2017/1/18.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SwitchViewController.h"
#import "UINavigationController+Extesion.h"
#import "MainModel.h"
#import "NSObject+CallSelector.h"
#import <GLKit/GLKit.h>
#import <CoreLocation/CoreLocation.h>
#include "GoodBoy.cpp"
#import "UIAlertController+AttibuteText.h"

@interface AppDelegate ()<CLLocationManagerDelegate>
{
    CLLocationManager * _locationManager;
}

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication*)application shouldSaveApplicationState:
(nonnull NSCoder *)coder{
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder{
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (!launchOptions) {
        
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[[SwitchViewController alloc] init]];
        
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
        
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
        
        MainModel * model = [[MainModel alloc]init];
        [model sayhello:@"manzi"];
        
        DogLet let =   DogLet();
        let.name = "dasdada";
        
        NSLog(@"%s",let.name.c_str());
        
     
        
        NSInteger  integer = [[NSUserDefaults standardUserDefaults]integerForKey:@"UIApplicationLaunchOptionsLocationKe"];
        
        NSLog(@"++++++++++ integer =%ld",(long)integer);
 
    }else
    {
        NSString * locationChangeValue = launchOptions[@"UIApplicationLaunchOptionsLocationKey"];
        
        if (locationChangeValue) {
            self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
            self.window.backgroundColor = [UIColor whiteColor];
            UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:[[SwitchViewController alloc] init]];
            
            self.window.rootViewController = nav;
            [self.window makeKeyAndVisible];
            
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
            
            NSInteger  integer = [[NSUserDefaults standardUserDefaults]integerForKey:@"UIApplicationLaunchOptionsLocationKe"];
            [[NSUserDefaults standardUserDefaults]setInteger:integer+1 forKey:@"UIApplicationLaunchOptionsLocationKe"];

        }
        
    }
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }
    
    [_locationManager startMonitoringSignificantLocationChanges];
    
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    
    

    
    
    
    return YES;
  
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark- CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"++++++++++位置更新了++++++++++++++");

   
    
  
    
}




@end
