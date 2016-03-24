//
//  HYNetworkTools.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkTools.h"

@implementation HYNetworkTools

+ (BOOL)checkJson:(id)json
    withValidator:(id)validatorJson
       noMatchKey:(id)noMatchKey
{
    if ([json isKindOfClass:[NSDictionary class]] &&
        [validatorJson isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dict = json;
        NSDictionary *validator = validatorJson;
        BOOL result = YES;
        NSEnumerator *enumerator = [validator keyEnumerator];
        NSString *key;
        while ((key = [enumerator nextObject]) != nil)
        {
            id value = dict[key];
            id format = validator[key];
            if ([value isKindOfClass:[NSDictionary class]]
                || [value isKindOfClass:[NSArray class]])
            {
                result = [self checkJson:value withValidator:format noMatchKey:noMatchKey];
                if (!result)
                {
                    break;
                }
            }
            else
            {
                if ([value isKindOfClass:format] == NO &&
                    [value isKindOfClass:[NSNull class]] == NO)
                {
                    noMatchKey = [key copy];
                    result = NO;
                    break;
                }
            }
        }
        return result;
    }
    else if ([json isKindOfClass:[NSArray class]] && [validatorJson isKindOfClass:[NSArray class]])
    {
        NSArray *validatorArray = (NSArray *)validatorJson;
        if (validatorArray.count > 0)
        {
            NSArray *array = json;
            NSDictionary *validator = validatorJson[0];
            for (id item in array)
            {
                BOOL result = [self checkJson:item withValidator:validator noMatchKey:noMatchKey];
                if (!result)
                {
                    return NO;
                }
            }
        }
        return YES;
    }
    else if ([json isKindOfClass:validatorJson])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)urlParametersStringFromParameters:(NSDictionary *)parameters
{
    NSMutableString *urlParametersString = [[NSMutableString alloc] initWithString:@""];
    if (parameters && parameters.count > 0)
    {
        for (NSString *key in parameters)
        {
            NSString *value = parameters[key];
            value = [NSString stringWithFormat:@"%@",value];
            [urlParametersString appendFormat:@"&%@=%@", key, value];
        }
    }
    return urlParametersString;
}

+ (NSString *)urlStringWithOriginUrlString:(NSString *)originUrlString
                          appendParameters:(NSDictionary *)parameters
{
    NSString *filteredUrl = originUrlString;
    NSString *paraUrlString = [self urlParametersStringFromParameters:parameters];
    if (paraUrlString && paraUrlString.length > 0)
    {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound)
        {
            filteredUrl = [filteredUrl stringByAppendingString:paraUrlString];
        }
        else
        {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    }
    else
    {
        return originUrlString;
    }
}

+ (BOOL)HYNetworkIsEmptyString:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]])
    {
        return YES;
    }
    if (string == nil)
    {
        return YES;
    }
    if ([string length] == 0)
    {
        return YES;
    }
    return NO;
}


@end
