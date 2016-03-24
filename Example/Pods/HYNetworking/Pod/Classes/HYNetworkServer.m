//
//  HYNetworkServer.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkServer.h"

@implementation HYNetworkServer

@synthesize online = _online;
@synthesize verify = _verify;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSAssert([self conformsToProtocol:@protocol(HYNetworkServerProtocal)], @"Your Must ConformToProtocal : HYNetworkServerProtocal");
        
        return self;
    }
    return nil;
}

- (NSString *)serverName
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (NSString *)baseUrl
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
