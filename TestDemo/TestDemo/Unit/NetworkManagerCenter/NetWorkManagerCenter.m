//
//  NetWorkManagerCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "NetWorkManagerCenter.h"
#import <objc/runtime.h>
#import "BaseRequestData.h"
#import "BusinessConstants.h"

@implementation NetWorkManagerCenter

+(id)shareInstance
{
    static NetWorkManagerCenter * netWorkManagerCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManagerCenter = [[NetWorkManagerCenter alloc]init];
    });
    return netWorkManagerCenter;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.requestDictionary = [NSMutableDictionary dictionary];
    }
    return self;
}




-(void)requestWithDestination:(NSString*)destination forViewModel:(id)viewModel  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    
    NSString *  dataRequestName = [[[NetWorkManagerCenter shareInstance]requestDictionary]valueForKey:NSStringFromClass([viewModel class])];
    
    if (dataRequestName) {
        
        Class dataRequestClass = NSClassFromString(dataRequestName);
        id dataRequestObj = [[dataRequestClass alloc]init];
        if ([[dataRequestObj superclass]isEqual:[BaseRequestData class]]) {
            
            BaseRequestData * requestData = dataRequestObj;
            
            if ([requestData respondsToSelector:@selector(requestForViewModel:destination:completionHandler:)]) {
                
                [requestData requestForViewModel:viewModel destination:destination completionHandler:completionHandler];
            }
        }
        
    }
    
    
}



@end
