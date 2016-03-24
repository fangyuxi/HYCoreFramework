//
//  HYNetworkDefines.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark enum

//证书的验证模式
typedef NS_ENUM(NSUInteger, HYSSLPinningMode)
{
    
    //不校验证书
    HYSSLPinningModeNone,
    //只检验publicKey
    HYSSLPinningModePublicKey,
    //检验整个证书
    HYSSLPinningModeCertificate,
};

//请求方法
typedef NS_ENUM(NSInteger , HYRequestMethod)
{
    HYRequestMethodGet = 1,
    HYRequestMethodPost,
    HYRequestMethodHead,
    HYRequestMethodPut,
    HYRequestMethodDelete,
    HYRequestMethodPatch
};

//缓存方式
typedef NS_ENUM(NSInteger , HYRequestCachePolicy)
{
    //不写缓存
    HYRequestCachePolicyNeverUseCache,
    //如果缓存有效的话，先读缓存再请求服务器
    HYRequestCachePolicyReadCacheIfInMaxAgeAndRequest,
    //不管缓存是否有效，先读缓存再请求服务器
    HYRequestCachePolicyReadCacheIgnoreAgeAndRequest,
    //如果缓存有效的话，只读缓存
    HYRequestCachePolicyOnlyReadCacheIfInMaxAge,
    //不管缓存是否有效，只读缓存
    HYRequestCachePolicyReadCacheIgnoreAge
};

#pragma mark timeout

#define KHYNetworkDefaultTimtout 20
#define KHYResponseCacheMaxAge 3 * 24 * 3600

#pragma mark error msg

extern NSString *const KNetworkConnectErrorMSG;
extern NSString *const KNetworkConnectCancelErrorMSG;
extern NSString *const KNetworkResponseValidatetErrorMSG;
extern NSInteger const KNetworkResponseValidatetErrorCode;

extern NSString *const KNetworkHYErrorDomain;

#pragma mark notification