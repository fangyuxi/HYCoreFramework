//
//  HYNetworkGlobalParamFilter.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkGlobalParamFilter.h"
#import "HYTools.h"

@implementation HYNetworkGlobalParamFilter{

    NSDictionary *_paramDic;

}

@synthesize outUrl = _outUrl;
@synthesize inUrl = _inUrl;
@synthesize inRequest = _inRequest;
@synthesize outParameterDic = _outParameterDic;
@synthesize inParameterDic = _inParameterDic;

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

- (NSString *)outUrl
{
    return [HYTools urlStringWithOriginUrlString:self.inUrl appendParameters:[self outParameterDic]];
}

- (void)setInParameterDic:(NSDictionary *)inParameterDic
{
    _inParameterDic = inParameterDic;
}

- (NSDictionary *)inParameterDic
{
    return _inParameterDic;
}

- (NSDictionary *)outParameterDic
{
    return _paramDic;
}


@end
