//
//  TJHTTPSessionManager.h
//  Shipper
//
//  Created by Topjet on 16/8/8.
//  Copyright © 2016年 topjetm02. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TJHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedSessionManager;

@end
