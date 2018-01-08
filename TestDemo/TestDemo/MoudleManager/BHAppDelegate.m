/**
 * Created by BeeHive.
 * Copyright (c) 2016, Alibaba, Inc. All rights reserved.
 *
 * This source code is licensed under the GNU GENERAL PUBLIC LICENSE.
 * For the full copyright and license information,please view the LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

#import "BHAppDelegate.h"
#import "MoudleManager.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif


@interface BHAppDelegate ()

@end

@implementation BHAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(application:didFinishLaunchingWithOptions:)]) {
            
            [obj application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }
   
    return YES;
}


#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400 

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(application: performActionForShortcutItem:completionHandler:)]) {
            
            [obj application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }
   
}
#endif

- (void)applicationWillResignActive:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(applicationWillResignActive:)]) {
            
            [obj applicationWillResignActive:application];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            
            [obj applicationDidEnterBackground:application];
        }
   }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            
            [obj applicationWillEnterForeground:application];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            
            [obj applicationDidBecomeActive:application];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&&[obj respondsToSelector:@selector(applicationWillTerminate:)]) {
            
            [obj applicationWillTerminate:application];
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)] && [obj respondsToSelector:@selector(application:openURL:sourceApplication:annotation:)]) {
            
            [obj application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }
    return YES;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:openURL:options:)]) {
            
            [obj application:app openURL:url options:options];
        }
    }
    
    return YES;
}
#endif


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            
            [obj applicationDidReceiveMemoryWarning:application];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            
            [obj application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            
            [obj application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            
            [obj application:application didReceiveRemoteNotification:userInfo];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)]) {
            
            [obj application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didReceiveLocalNotification:)]) {
            
            [obj application:application didReceiveLocalNotification:notification];
        }
    }
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80000
- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        for (id obj in [MoudleManager instance] .BHModules) {
            if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didUpdateUserActivity:)]) {
                
                [obj application:application didUpdateUserActivity:userActivity];
            }
        }
    }
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        for (id obj in [MoudleManager instance] .BHModules) {
            if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:didFailToContinueUserActivityWithType:error:)]) {
                
                [obj application:application didFailToContinueUserActivityWithType:userActivityType error:error];
            }
        }
    }
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        for (id obj in [MoudleManager instance] .BHModules) {
            if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:continueUserActivity:restorationHandler:)]) {
                
                [obj application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
            }
        }
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    if([UIDevice currentDevice].systemVersion.floatValue > 8.0f){
        for (id obj in [MoudleManager instance] .BHModules) {
            if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(application:willContinueUserActivityWithType:)]) {
                
                [obj application:application willContinueUserActivityWithType:userActivityType];
            }
        }
    }
    return YES;
}
#endif
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(userNotificationCenter:willPresentNotification:withCompletionHandler:)]) {
            
            if (@available(iOS 10.0, *)) {
                [obj userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
            } else {
                // Fallback on earlier versions
            }
        }
    }
  
};

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    
    for (id obj in [MoudleManager instance] .BHModules) {
        if ([obj conformsToProtocol:@protocol(UIApplicationDelegate)]&& [obj respondsToSelector:@selector(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler:)]) {
            
            if (@available(iOS 10.0, *)) {
                [obj userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler ];
            } else {
                // Fallback on earlier versions
            }
        }
    }
};
#endif

@end

@implementation BHOpenURLItem

@end

@implementation BHShortcutItem

@end

@implementation BHUserActivityItem

@end

@implementation BHNotificationsItem

@end
