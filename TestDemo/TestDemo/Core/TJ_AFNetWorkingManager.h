//
//  TJ_AFNetWorkingManager.h
//  Shipper
//
//  Created by Topjet on 16/7/22.
//  Copyright © 2016年 Topjet. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "AFNetworking.h"
#import "TJHTTPSessionManager.h"
/*!
 *  @brief 网络管理者
 */
@interface TJ_AFNetWorkingManager : NSObject

typedef NSURLSessionTask TJURLSessionTask;
typedef void( ^TJDownloadProgressBlock)(NSProgress *downloadProgress);
typedef void( ^TJResponseSuccessBlock)(TJURLSessionTask * task, id responseObject);
typedef void( ^TJResponseFailBlock)(TJURLSessionTask * task,NSError *error);

#pragma mark -

#pragma mark - sharedHTTPSessionManager

/*!
 *  @brief 获取网络管理者单例
 *
 *  @return 网络管理者对象
 */
+ (instancetype)sharedHTTPRequestManager;
/**
 *  网络请求会话配置对象
 */
@property (strong, nonatomic) TJHTTPSessionManager *HTTPSessionManager;

#pragma mark - get

/*!
 *  @brief 没有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock;

/*!
 *  @brief 有进度条的get请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)get:(NSString *)urlString parameters:(id)parameter netIdentifier:(NSString *)netIdentifier progress:(TJDownloadProgressBlock)downloadProgressBlock success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock;


#pragma mark - post

/*!
 *  @brief 没有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock;

/*!
 *  @brief 有进度条的post请求
 *
 *  @param urlString             url
 *  @param parameter             参数
 *  @param netIdentifier         请求标志
 *  @param downloadProgressBlock 进度
 *  @param successBlock          成功
 *  @param failureBlock          失败
 */
- (void)post:(NSString *)urlString parameters:(id)parameters netIdentifier:(NSString *)netIdentifier progress:(TJDownloadProgressBlock)downloadProgress success:(TJResponseSuccessBlock)successBlock failure:(TJResponseFailBlock)failureBlock;

#pragma mark - other

#pragma mark - 取消

/*!
 *  @brief 取消所有网络请求
 */
- (void)cancelAllNetworking;

/*!
 *  @brief 取消一组网络请求
 *
 *  @param netIdentifier 网络请求标志
 */
- (void)cancelNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifier;

/*!
 *  @brief 取消对应的网络请求
 *
 *  @param netIdentifier 网络请求标志
 */
- (void)cancelNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/*!
 *  @brief 获取正在进行的网络请求
 *
 *  @return 正在进行的网络请求标志数组
 */
- (NSArray <NSString *>*)getUnderwayNetIdentifierArray;

#pragma mark - 挂起

/*!
 *  @brief 暂停所有网络请求
 */
- (void)suspendAllNetworking;

/*!
 *  @brief 暂停一组网络请求
 *
 *  @param netIdentifierArray 网络标志数组
 */
- (void)suspendNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/*!
 *  @brief 暂停对应的网络请求
 *
 *  @param netIdentifier 网络标志
 */
- (void)suspendNetworkingWithNetIdentifier:(NSString *)netIdentifier;

/*!
 *  @brief 获取正暂停的网络请求
 *
 *  @return 返回网络标志数组
 */
- (NSArray <NSString *>*)getSuspendNetIdentifierArray;

#pragma mark - 恢复

/*!
 *  @brief 恢复所有暂停的网络请求
 */
- (void)resumeAllNetworking;

/*!
 *  @brief 恢复一组暂停的网络请求
 *
 *  @param netIdentifierArray 网络请求标志数组
 */
- (void)resumeNetworkingWithNetIdentifierArray:(NSArray <NSString *> *)netIdentifierArray;

/*!
 *  @brief 恢复暂停的的网络请求
 *
 *  @param netIdentifier  网络请求标志
 */
- (void)resumeNetworkingWithNetIdentifier:(NSString *)netIdentifier;
@end
