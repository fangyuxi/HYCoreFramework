//
//  HYNetworkGlobalParamFilter.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkGlobalParamFilter.h"

@implementation HYNetworkGlobalParamFilter{

    NSDictionary *_paramDic;

}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _paramDic = @{@"v":@"1.1",
                      @"lon":@"116.5121528505512",
                      @"lat":@"39.99394135382764",
                      @"pageSize":@"20",
                      @"sortBy":@"skillsort_desc",
                      @"appKey":@"76532",
                      @"loginTocken":@"ba91815174bc772cfaba6556e56e58af",
                      @"appVersion":@"10181",
                      @"platform":@"ios",
                      @"sign":@"20C5BA149812C4B26D0989AEE9656A7DB5AF868C"};
        return self;
    }
    return nil;
}

- (NSString *)filterUrl:(NSString *)url withRequest:(HYBaseRequest *)request
{
    return [HYNetworkTools urlStringWithOriginUrlString:url appendParameters:_paramDic];
}

@end
