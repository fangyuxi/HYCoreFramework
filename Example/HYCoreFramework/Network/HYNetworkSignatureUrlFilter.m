//
//  HYNetworkSignatureUrlFilter.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/13.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkSignatureUrlFilter.h"

@implementation HYNetworkSignatureUrlFilter{

    NSDictionary *_signDic;

}

- (NSString *)filterUrl:(NSString *)url withRequest:(HYBaseRequest *)request
{
    return [HYNetworkTools urlStringWithOriginUrlString:url appendParameters:_signDic];
}

@end
