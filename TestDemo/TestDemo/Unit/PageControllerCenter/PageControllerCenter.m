//
//  PageControllerCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "PageControllerCenter.h"
#import <objc/runtime.h>
#import "BasePageTurn.h"

@implementation PageControllerCenter

+(id)shareInstance
{
    static PageControllerCenter * pageControllerCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageControllerCenter = [[PageControllerCenter alloc]init];

    });
    return pageControllerCenter;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        self.pageDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}


-(void)pageTurnToViewControllerClass:(NSString *)viewControllerClass fromCurrentViewController:(id)currentVC
{
    UIViewController * currentViewController = currentVC;

    UIViewController * toViewController = [self getParamWithOrignViewControllerWithClass:viewControllerClass fromController:currentVC];
    
    if (toViewController) {

        if (!currentViewController.navigationController) {
            [currentViewController presentViewController:toViewController animated:YES completion:nil];
        }else
        {
            [currentViewController.navigationController pushViewController:toViewController animated:YES];

        }
        
    }
}

-(UIViewController*)getParamWithOrignViewControllerWithClass:(NSString*)viewControllerClass fromController:(id)fromController
{
    NSString * pageTurnClassName = [self.pageDictionary valueForKey:viewControllerClass];
    if (pageTurnClassName) {
        
        Class  pageTurnClass = NSClassFromString(pageTurnClassName);
        id  pageTurnObj  = [[pageTurnClass alloc]init];
        if ([[pageTurnObj superclass]isEqual:[BasePageTurn class]]) {
            BasePageTurn * pageTurn  = [[pageTurnClass alloc]init];
            if ([pageTurn respondsToSelector:@selector(pageTurnFromVC:)]) {
                return   [pageTurn pageTurnFromVC:fromController];
            }
        }
       
    }

    return nil;
}



-(UIViewController*)getOrignViewControllerWithClass:(NSString*)viewControllerClass withParamDic:(NSDictionary*)paramDic
{
   
    
    return nil;
}


@end
