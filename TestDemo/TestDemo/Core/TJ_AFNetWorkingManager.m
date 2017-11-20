//
//  TJ_AFNetWorkingManager.m
//  Shipper
//
//  Created by Topjet on 16/7/22.
//  Copyright © 2016年 Topjet. All rights reserved.
//

#import "TJ_AFNetWorkingManager.h"
#import "AFNetworking.h"
#import "SecurityUtil.h"
#define kBASEURL @""
@interface TJ_AFNetWorkingManager ()

@property (strong, nonatomic) NSMutableArray <NSDictionary<NSString *,NSURLSessionDataTask *> *> *networkingManagerArray;

@end

@implementation TJ_AFNetWorkingManager

#pragma mark -
- (instancetype)init {
    
    if (self = [super init]) {
        _networkingManagerArray = [@[] mutableCopy];
    }
    return self;
}
+ (instancetype)sharedHTTPRequestManager {
    
    static  TJ_AFNetWorkingManager *sessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager  = [[self  alloc] init];
    });
    return sessionManager;
}
-(TJHTTPSessionManager *)HTTPSessionManager {
    if (_HTTPSessionManager == nil) {
        _HTTPSessionManager = (kBASEURL.length > 0) ?  [[TJHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBASEURL]] : [[TJHTTPSessionManager alloc] init];
        AFHTTPRequestSerializer *requestSerializerNotCache = [AFHTTPRequestSerializer serializer];
        requestSerializerNotCache.timeoutInterval = 15.0;
        _HTTPSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return _HTTPSessionManager;
}
#pragma mark - get

- (void)get:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock];
    
    if (!sessionManager) {
        
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(task,error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)get:(NSString *)urlString parameters:(id)parameter netIdentifier:(NSString *)netIdentifier progress:(TJDownloadProgressBlock)downloadProgressBlock success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameter netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        return;
    }
    
    NSURLSessionDataTask *task = [sessionManager GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (successBlock) {
            successBlock(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(task,error);
        }
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

#pragma mark - post

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:nil success:successBlock failure:failureBlock ];
    if (!sessionManager) {
        return;
    }
    
    NSString *requestString = [SecurityUtil encryptAESRequestParam:parameters];
    
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:requestString progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        NSDictionary *responseDic = [SecurityUtil decryptAESData:responseObject];
        if (successBlock) {
            successBlock(task,responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        if (failureBlock) {
            failureBlock(task,error);
        }
    }];
    
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}

- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier progress:(TJDownloadProgressBlock)downloadProgressBlock success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock {
    
    AFHTTPSessionManager *sessionManager = [self getManagerWithWithPath:urlString parameters:parameters netIdentifier:netIdentifier progress:downloadProgressBlock success:successBlock failure:failureBlock ];
    
    if (!sessionManager) {
        return;
    }
    NSString *requestString = [SecurityUtil encryptAESRequestParam:parameters];
    
    NSURLSessionDataTask *task = [sessionManager POST:urlString parameters:requestString progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
         NSDictionary *responseDic = [SecurityUtil decryptAESData:responseObject];
        if (successBlock) {
            successBlock(task,responseDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (netIdentifier) {
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
        }
        ! failureBlock ? :failureBlock(task,error);
    }];
    if (netIdentifier) {
        [self.networkingManagerArray addObject:@{netIdentifier:task}];
    }
}
#pragma mark - cancel

- (void)cancelAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        [task cancel];
    }
    [self.networkingManagerArray removeAllObjects];
}

- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self cancelNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task cancel];
            [self.networkingManagerArray removeObject:@{netIdentifier:task}];
            return;
        }
    }
}

- (NSArray <NSString *>*)getUnderwayNetIdentifierArray {
    
    NSMutableArray *muarr = [@[] mutableCopy];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        [muarr addObject:key];
    }
    return muarr;
}

#pragma mark - suspend

- (void)suspendAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateRunning) {
            [task suspend];
        }
    }
}

- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        [self suspendNetworkingWithNetIdentifier:netIdentifier];
    }
    
}

- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            [task suspend];
        }
    }
}

- (NSArray<NSString *> *)getSuspendNetIdentifierArray {
    
    NSMutableArray *muarr = [@[] mutableCopy];
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        
        if (task.state == NSURLSessionTaskStateSuspended) {
            [muarr addObject:key];
        }
    }
    return muarr;
}

#pragma  mark - resume

- (void)resumeAllNetworking {
    
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString  *key = [[dict allKeys] firstObject];
        NSURLSessionDataTask *task = dict[key];
        if (task.state == NSURLSessionTaskStateSuspended) {
            [task resume];
        }
    }
}

- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray {
    
    for (NSString *netIdentifier in netIdentifierArray) {
        
        [self resumeNetworkingWithNetIdentifier:netIdentifier];
    }
}

- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier {
    
    if (!netIdentifier) {
        return;
    }
    for (NSDictionary *dict in self.networkingManagerArray) {
        NSString *key = [[dict allKeys] firstObject];
        if ([key isEqualToString:netIdentifier]) {
            NSURLSessionDataTask *task = dict[key];
            if (task.state == NSURLSessionTaskStateSuspended) {
                [task resume];
            }
        }
    }
}

#pragma  mark - 判断该请求是否正在进行和网络状态

- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                        progress:(void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                         success:(void (^)(NSURLSessionDataTask * task, id responseObject))successBlock
                                         failure:(void (^)(TJURLSessionTask * task,NSError *error))failureBlock {
    // 1.当前的请求是否正在进行
//    for (NSDictionary *dict in self.networkingManagerArray) {
//        NSString *key = [[dict allKeys] firstObject];
//        if ([key isEqualToString:netIdentifier]) {
//            DDLog(@"当前的请求正在进行,拦截请求");
//            if (failureBlock) {
//                NSError *cancelError = [NSError errorWithDomain:@"请求正在进行!" code:(-12001) userInfo:nil];
//                ! failureBlock ? :failureBlock(nil,cancelError);
//            }
//            return nil;
//        }
//    }
    
    // 2.检测是否有网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    AFNetworkReachabilityStatus net = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if (net == AFNetworkReachabilityStatusNotReachable) {
        NSError *cancelError = [NSError errorWithDomain:@"没有网络,请检测网络!" code:(-560404) userInfo:nil];
        ! failureBlock ? : failureBlock(nil,cancelError);
        DDLog(@"没有网络");
        return nil;
    }
    return  self.HTTPSessionManager;
}
@end
