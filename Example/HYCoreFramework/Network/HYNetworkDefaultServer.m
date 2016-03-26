//
//  HYNetworkDefaultServer.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkDefaultServer.h"

@implementation HYNetworkDefaultServer

- (NSString *)baseUrl
{
    if (self.isOnline)
    {
        if (self.isVerify)
        {
            return @"";
        }
        return @"http://sxbb.58v5.cn";
    }
    else
    {
        if (self.isVerify)
        {
            return @"";
        }
        return @"";
    }
    return @"";
}

- (NSString *)serverName
{
    return @"沙箱";
}

@end
