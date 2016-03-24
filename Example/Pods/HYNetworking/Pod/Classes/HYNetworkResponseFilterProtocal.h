//
//  HYNetworkResponseFilterProtocal.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

@class HYNetworkResponse;
@class HYBaseRequest;


/** 过滤返回值filter 用于业务方过滤框架性质的网络错误 **/

@protocol HYNetworkResponseFilterProtocal <NSObject>

@required
- (NSError *)filterResponse:(HYNetworkResponse *)response withRequest:(HYBaseRequest *)request;

@end
