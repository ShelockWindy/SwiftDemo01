//
//  LoginDataRequest.h
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginDataRequest : NSObject

-(void)requestForViewModel:(id)viewModel  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

@end
