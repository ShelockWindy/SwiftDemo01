//
//  LoginDataRequest.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginDataRequest.h"
#import "LoginViewModel.h"

@implementation LoginDataRequest

-(void)requestForViewModel:(id)viewModel  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
        LoginViewModel * loginViewModel = viewModel;
        NSString * userName = loginViewModel.userName;
        NSString * password = loginViewModel.password;
        
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

@end
