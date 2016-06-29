//
//  HYNetworkSignatureUrlFilter.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/13.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkSignatureUrlFilter.h"
#import "HYTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation HYNetworkSignatureUrlFilter{

    NSDictionary *_signDic;
    NSString *_paramURL;

}

@synthesize outUrl = _outUrl;
@synthesize inUrl = _inUrl;
@synthesize inRequest = _inRequest;
@synthesize outParameterDic = _outParameterDic;
@synthesize inParameterDic = _inParameterDic;

- (NSString *)outUrl
{
    return [HYTools urlStringWithOriginUrlString:self.inUrl appendParameters:[self outParameterDic]];
}

- (NSDictionary *)outParameterDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:[self.inRequest requestArgument]];
    
    NSString *query = [NSURL URLWithString:self.inUrl].query;
    if (query)
    {
        NSArray *parameters = [query componentsSeparatedByString:@"&"];
        dic = [self dicConvertByArray:parameters];
    }
    
    if ([self.inRequest requestMethod] == HYRequestMethodPost)
    {
        [dic addEntriesFromDictionary:self.inParameterDic];
    }
    
    [dic addEntriesFromDictionary:[self.inRequest requestArgument]];
    
    NSString *sign = [self makeSign:dic];
    if (sign)
    {
        _signDic = @{@"sign":sign};
    }
    return _signDic;
}

- (void)setInParameterDic:(NSDictionary *)inParameterDic
{
    _inParameterDic = inParameterDic;
}

- (NSDictionary *)inParameterDic
{
    return _inParameterDic;
}

- (NSString *)makeSign:(NSDictionary *)dic
{
    NSString *sortedString = [self sortedStringInDic:dic];
    NSString *signedString = [self sha1String:sortedString];
    return [signedString uppercaseString];
}

- (NSMutableDictionary *)dicConvertByArray:(NSArray *)array
{
    if (!array)
    {
        return  nil;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *temArray = [( NSString *)obj componentsSeparatedByString:@"="];
        [dic setObject:temArray[1] forKey:temArray[0]];
    }];
    return dic;
}

- (NSString *)sortedStringInDic:(NSDictionary *)dic
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@%@",key,obj]];
    }];
    NSArray * sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    NSMutableString * resultStr = [[NSMutableString alloc] init];
    [sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [resultStr appendString:obj];
    }];
    
    return [NSString stringWithFormat:@"%@%@%@",@"KUEADF3",resultStr,@"KUEADF3"];
}

- (NSString *)sha1String:(NSString *)string
{
    NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x",digest[i]];
    }
    return  output;
}


@end
