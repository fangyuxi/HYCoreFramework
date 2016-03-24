//
//  HYNetworkConfig.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYNetworkUrlFilterProtocal.h"
#import "HYNetworkSecurityPolicy.h"
#import "HYNetworkResponseFilterProtocal.h"
#import "HYNetworkServer.h"
#import "HYResponseCache.h"

@interface HYNetworkConfig : NSObject
{
    
}

+ (HYNetworkConfig *)sharedInstance; 

//baseUrl读的就是defaultServer中的baseUrl
@property (nonatomic, copy, readonly) NSString *baseUrl;
//默认的服务提供商
@property (nonatomic, strong) HYNetworkServer *defaultSever;

//用于向url添加参数的filter，比如签名，就可以设计成一个filter，公共参数，也可以设计成一个filter 组成 filter chain
@property (nonatomic, strong, readonly) NSArray<id<HYNetworkUrlFilterProtocal>> *urlFilters;
//用于向已经验证完毕的response过滤错误
@property (nonatomic, strong, readonly) NSArray<id<HYNetworkResponseFilterProtocal>> *responseFilters;

//网络安全配置
@property (nonatomic, strong) HYNetworkSecurityPolicy *securityPolicy;
//所有Reqeust使用的缓存
@property (nonatomic, strong) HYResponseCache *cache;

- (void)addUrlFilter:(id<HYNetworkUrlFilterProtocal>)filter;
- (void)addResponseFilter:(id<HYNetworkResponseFilterProtocal>)filter;


//日志开关

//默认都为1

@property (nonatomic, assign, getter=isRequestLogOn) BOOL requestLogOn; //打印请求开始
@property (nonatomic, assign, getter=isResponseLogOn) BOOL responseLogOn; //打印返回值
@property (nonatomic, assign, getter=isHeaderLogOn) BOOL headerLogOn; //是否打印header

@end
