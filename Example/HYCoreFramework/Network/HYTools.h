//
//  HYTools.h
//  HYNetworking
//
//  Created by fangyuxi on 16/5/3.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYTools : NSObject

/**
 *  将字典变成参数URL
 *
 *  @param parameters dic
 *
 *  @return parameters string
 */
+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters;

/**
 *  将字典变成参数URL,拼到originUrlString后面
 *
 *  @param originUrlString 原始url
 *  @param parameters      dic
 *
 *  @return full url
 */
+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;

@end
