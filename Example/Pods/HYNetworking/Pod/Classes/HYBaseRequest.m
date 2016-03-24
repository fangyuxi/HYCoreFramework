//
//  HYBaseRequest.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseRequest.h"
#import "HYBaseRequestInternal.h"
#import <objc/runtime.h>

@interface HYBaseRequest ()

@end

@implementation HYBaseRequest

#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSAssert([self conformsToProtocol:@protocol(HYBaseRequestProtocal)], @"Your Must ConformToProtocal : HYBaseRequestProtocal");
        
        self.validator = (id <HYRequestValidator>)self;
        
        return self;
    }
    return nil;
}

#pragma mark request action

//发起请求
- (void)start
{
    [[HYBaseRequestInternal sharedInstance] sendRequest:self];
    return;
}

- (void)startWithSuccessHandler:(HYRequestFinishedSuccessHandler)successHandler
                  failerHandler:(HYRequestFinishedFailerHandler)failerHandler
                progressHandler:(HYRequestProgressHandler)progressHandler
{
    self.successHandler = successHandler;
    self.failerHandler = failerHandler;
    self.progressHandler = progressHandler;
    [self start];
}

//取消请求
- (void)cancel
{
    [[HYBaseRequestInternal sharedInstance] cancelRequeset:self];
    return;
}

- (BOOL)isLoading
{
    return [[HYBaseRequestInternal sharedInstance] isLoadingRequest:self];
}

//打破循环引用
- (void)clearBlock
{
    self.successHandler = nil;
    self.failerHandler = nil;
    self.progressHandler = nil;
}

#pragma mark equel

- (NSUInteger)hash
{
    NSMutableString *hashString = [NSMutableString stringWithFormat:@"%ld",(long)self];
    return [hashString hash];
}

- (BOOL)isEqualToRequest:(HYBaseRequest *)request
{
    return [self hash] == [request hash];
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    if (![object isKindOfClass:[HYBaseRequest class]])
    {
        return NO;
    }
    
    return [self isEqualToRequest:(HYBaseRequest *) object];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"url:%@ identifier : %@", [self apiUrl],[self identifier]];
}

#pragma mark protocal empty method must complete in child

- (HYRequestMethod)requestMethod
{
    [self doesNotRecognizeSelector:_cmd];
    return HYRequestMethodGet ;
}

- (NSString *)apiUrl
{
    [self doesNotRecognizeSelector:_cmd];
    return nil ;
}

- (NSString *)identifier
{
    [self doesNotRecognizeSelector:_cmd];
    return nil ;
}

//完整的url 如果有值，那么会忽略掉HYNetworkConfig里面的baseUrl
- (NSString *)fullUrl
{
    return nil;
}

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)requestHeaderValueDictionary
{
    return nil;
}

//默认30秒
- (NSTimeInterval)requestTimeoutInterval
{
    return 0;
}

/// 当POST的body
- (HYConstructingBlock)constructingBodyBlock
{
    return nil;
}

/// 请求的参数列表
- (NSDictionary *)requestArgument
{
    return nil;
}

//下载的URL 如果子类提供了path 那么将会把内容下载到指定位置
- (NSString *)downloadPath
{
    return nil;
}

/**
 *  CacheMaxAge default 3 days
 *
 *  @return NStimeInterval by second
 */
- (NSTimeInterval)cacheMaxAge
{
    return KHYResponseCacheMaxAge;
}

/**
 *  How to cache data
 *
 *  @return Enum HYRequestCachePolicy
 */
- (HYRequestCachePolicy)cachePolicy
{
    return HYRequestCachePolicyNeverUseCache;
}


@end



