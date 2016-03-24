//
//  HYNetworkTools.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYNetworkTools : NSObject
{
    
}

+ (BOOL)checkJson:(id)json withValidator:(id)validatorJson noMatchKey:(id)key;

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters;

+ (BOOL)HYNetworkIsEmptyString:(NSString *)string;

@end
