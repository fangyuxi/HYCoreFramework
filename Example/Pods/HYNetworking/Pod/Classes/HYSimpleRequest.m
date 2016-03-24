//
//  HYGeneralRequest.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYSimpleRequest.h"

@implementation HYSimpleRequest


- (HYRequestMethod)simpleRequestMethod
{
    return _simpleRequestMethod;
}

//与HYNetworkConfig里面的baseUrl和参数组成完整的请求url，原则上apiUrl返回的字符串不应该包含任何参数 应该是:/api/user
- (NSString *)simpleApiUrl
{
    return _simpleApiUrl;
}

- (NSString *)simpleIdentifier
{
    return _simpleIdentifier;
}


//完整的url 如果有值，那么会忽略掉HYNetworkConfig里面的baseUrl
- (NSString *)simpleFullUrl
{
    return _simpleFullUrl;
}

/// 在HTTP报头添加的自定义参数
- (NSDictionary *)simpleHeaderValueDictionary
{
    return _simpleHeaderValueDictionary;
}

//默认30秒
- (NSTimeInterval)simpleTimeoutInterval
{
    return _simpleTimeoutInterval;
}

/// 当POST的body
- (HYConstructingBlock)constructingBodyBlock
{
    return nil;
}

/// 请求的参数列表
- (id)simpleArgument
{
    return _simpleArgument;
}

//下载的URL 如果子类提供了path 那么将会把内容下载到指定位置
- (NSString *)simpleDownloadPath
{
    return _simpleDownloadPath;
}

@end
