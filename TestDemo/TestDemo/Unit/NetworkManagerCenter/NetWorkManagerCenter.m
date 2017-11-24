//
//  NetWorkManagerCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "NetWorkManagerCenter.h"
#import "LoginViewModel.h"

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


-(void)requestWithDestination:(NSString*)destination forViewModel:(id)viewModel  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    if ([destination isEqualToString:@"Login"]) {
        
        LoginViewModel * loginViewModel = viewModel;
        NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSString * content  =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];;
            NSLog(@"%@---%@",NSStringFromClass([viewModel class]),content);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (completionHandler) {
                    completionHandler(data,response,error);
                }
            });
            
        }];
        
        [dataTask resume];
    }
    
}



@end
