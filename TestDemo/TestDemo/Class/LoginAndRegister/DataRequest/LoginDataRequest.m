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

+(void)load
{
    NSString * value = NSStringFromClass([self class]);
    NSString * key =  NSStringFromClass([LoginViewModel class]);
    [[[NetWorkManagerCenter shareInstance] requestDictionary] setValue:value forKey:key];
}


-(void)requestForViewModel:(id)viewModel destination:(NSString* _Nullable)destination completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
        LoginViewModel * loginViewModel = viewModel;
        NSString * userName = loginViewModel.userName;
        NSString * password = loginViewModel.password;
    
    if ([destination isEqualToString:Business_Login]) {
        
        [self requestWithDestination:@"Login" paramDic:@{@"userName":userName,@"password":password} finishBlock:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSString * content  =  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];;
            NSLog(@"%@---%@",NSStringFromClass([viewModel class]),content);
            
            if (completionHandler) {
                completionHandler(data,response,error);
            }
            
        }];
    }
    
}

@end
