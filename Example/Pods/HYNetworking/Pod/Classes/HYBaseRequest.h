//
//  HYBaseRequest.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HYNetworkDefines.h"
#import "HYNetworkResponse.h"
#import "HYNetworkResponseFilterProtocal.h"
#import "HYNetworkUrlFilterProtocal.h"
#import "HYNetworkServer.h"

#pragma mark block

@class HYBaseRequest;

typedef void (^HYConstructingBlock)(id<AFMultipartFormData> formData);
typedef void (^HYRequestFinishedSuccessHandler)(HYBaseRequest *request, HYNetworkResponse *response);
typedef void (^HYRequestFinishedFailerHandler)(HYBaseRequest *request, HYNetworkResponse *response);
typedef void (^HYRequestProgressHandler)(HYBaseRequest *request, int64_t progress);

#pragma mark CallBack Delegate Protocal

//继承自BaseRuquest的必须实现这个协议，否则运行会崩溃
@protocol HYBaseRequestProtocal <NSObject>

@required

- (HYRequestMethod)requestMethod;

//与HYNetworkConfig里面的baseUrl和参数组成完整的请求url，原则上apiUrl返回的字符串不应该包含任何参数 应该是:/api/user
- (NSString *)apiUrl;

- (NSString *)identifier;

@optional

//完整的url 如果有值，那么会忽略掉HYNetworkConfig里面的baseUrl，也会忽略掉自身的server
- (NSString *)fullUrl;

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderValueDictionary;

//默认30秒
- (NSTimeInterval)requestTimeoutInterval;

/// 当POST的body
- (HYConstructingBlock)constructingBodyBlock;

/**
 *  The Reqeust Paramater
 *
 *  @return Commonly is dic
 */
- (NSDictionary *)requestArgument;

/**
 *  DownloadPath. If no nil, the data will be writen to the path
 *
 *  @return path
 */
- (NSString *)downloadPath;

/**
 *  CacheMaxAge default 3 days
 *
 *  @return NStimeInterval by second
 */
- (NSTimeInterval)cacheMaxAge;

/**
 *  How to cache data. Default is HYRequestCachePolicyNoNeedCache
 *
 *  @return Enum HYRequestCachePolicy
 */
- (HYRequestCachePolicy)cachePolicy;
@end



#pragma mark CallBack Delegate Protocal

//回调
@protocol HYRequestDelegate <NSObject>

@optional

- (void)requestDidFinished:(HYBaseRequest *)request
              withResponse:(HYNetworkResponse *)response;

- (void)request:(HYBaseRequest *)request
   withErrorResponse:(HYNetworkResponse *)response;

- (void)request:(HYBaseRequest *)request loadingProgress:(CGFloat)progress;

//- (void)request:(HYBaseRequest *)request
//canceledWithResponse:(HYNetworkResponse *)response;

@end





#pragma mark Validator Protocal

//验证返回值和参数 可以指向自己 如果多个request可以共享一个validator，那么可以单独写一个对象
@protocol HYRequestValidator <NSObject>

@optional

//返回一个数据结构，用来验证服务端返回的Json对象种的元素的类型是否和我们客户端解析的类型一致
- (id)jsonValidatorData;

//验证参数是否合法
- (BOOL)request:(HYBaseRequest *)request isOKWithParamsData:(NSDictionary *)params;

@end





#pragma mark HYBaseRequest Interface

@interface HYBaseRequest : NSObject<HYBaseRequestProtocal>
{
    
    
}

//代理对象
@property (nonatomic, weak) id<HYRequestDelegate> delegate;
//通常是自己，如果多个接口validator可以重用，也可以单独定义对象
@property (nonatomic, weak) id<HYRequestValidator> validator;
//服务提供者，如果不提供，那么使用config的默认提供者
@property (nonatomic, strong) HYNetworkServer *server;

//userInfo
@property (nonatomic, strong)NSDictionary *userInfo;
//debug 此request是否打印log 如果为true 那么不论全局log是否打印，这个request都打印
//如果是false，那么遵循全局设置
@property (nonatomic, assign)BOOL debugMode;

//参数和返回值过滤器，如果没有赋值，那么默认使用HYNetworkConfig里面的过滤器，如果有赋值，会忽略掉config
@property (nonatomic, strong)id<HYNetworkUrlFilterProtocal> urlFilter;
@property (nonatomic, strong)id<HYNetworkResponseFilterProtocal> responseFilter;

//成功和失败的回调
@property (nonatomic, copy)HYRequestFinishedSuccessHandler successHandler;
@property (nonatomic, copy)HYRequestFinishedFailerHandler failerHandler;
@property (nonatomic, copy)HYRequestProgressHandler progressHandler;

//发起请求
- (void)start;

- (void)startWithSuccessHandler:(HYRequestFinishedSuccessHandler)successHandler
                  failerHandler:(HYRequestFinishedFailerHandler)failerHandler
                progressHandler:(HYRequestProgressHandler)progressHandler;
//取消请求
- (void)cancel;
- (BOOL)isLoading;

//打破循环引用
- (void)clearBlock;


//判断两个请求是否相等
- (BOOL)isEqualToRequest:(HYBaseRequest *)request;

//真正发起请求的URL,URL拼装正确后，internal会向这个属性赋值
@property (nonatomic, copy, readonly)NSString *URL;

@end











