//
//  HYBaseRequestInternal.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseRequest.h"
#import "HYNetworkConfig.h"

@interface HYBaseRequestInternal : NSObject
{
    
}

+ (HYBaseRequestInternal *)sharedInstance;


@property (nonatomic, strong) HYNetworkConfig *networkConfig;

- (void)sendRequest:(HYBaseRequest *)request;
- (void)cancelRequeset:(HYBaseRequest *)request;
- (void)cancelAllRequest;

- (BOOL)isLoadingRequest:(HYBaseRequest *)request;

@end
