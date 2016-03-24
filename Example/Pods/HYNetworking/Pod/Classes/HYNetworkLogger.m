//
//  HYNetworkLogger.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkLogger.h"
#import "HYNetworkResponse.h"
#import "HYNetworkServer.h"
#import "HYBaseRequest.h"
#import "HYNetworkConfig.h"

@implementation HYNetworkLogger


+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static HYNetworkLogger *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)logResponse:(HYNetworkResponse *)response
        withRequest:(HYBaseRequest *)request
{
    BOOL needLog = request.debugMode ? YES : [HYNetworkConfig sharedInstance].responseLogOn;
    
    if (!needLog)
    {
        return;
    }
    
    //头
    NSMutableString *log = [NSMutableString stringWithFormat:@"\n==============================================================\n               Response  status:%ld code:%ld           \n==============================================================\n\n",(long)response.status, (long)response.responseHTTPStatusCode];
    
    //返回的内容
    [log appendString:@"\n---------------  Response Content Start  --------------\n\n"];
    if ([HYNetworkConfig sharedInstance].headerLogOn)
    {
        
        [log appendString:[self jsonStringWithObject:response.responseHTTPHeadFields]];
        [log appendString:@"\n\n"];
    }
    
    [log appendString:[self jsonStringWithObject:response.content]];
    [log appendString:@"\n"];
    [log appendString:@"\n---------------  Response Content End  --------------\n\n"];
    
    //error
    if (response.error)
    {
        [log appendString:@"\n---------------  Error MSG Start  --------------\n\n"];
        [log appendString:response.errorMSG ? response.errorMSG : @""];
        [log appendFormat:@"Error Domain:\t\t\t\t%@\n", response.error.domain];
        [log appendFormat:@"Error Domain Code:\t\t\t%ld\n", (long)response.error.code];
        [log appendFormat:@"Error Description:\t\t%@\n", response.error.localizedDescription];
        [log appendFormat:@"Error Failure Reason:\t%@\n", response.error.localizedFailureReason];
        [log appendFormat:@"Error Recovery Suggestion:%@\n\n", response.error.localizedRecoverySuggestion];
        [log appendString:@"\n---------------  Error MSG End  --------------\n\n"];
    }
    
    //这个response对应的request信息
    [log appendString:@"\n---------------  Related Request Start  -----------------\n\n"];
    if ([HYNetworkConfig sharedInstance].headerLogOn)
    {
        [log appendString:@"Request Header \n\n"];
        [log appendString:[self jsonStringWithObject:response.systemRequest.allHTTPHeaderFields]];
        [log appendString:@"\n\n"];
    }
    //request的参数
    [log appendString:@"Request param \n\n"];
    [log appendString:[self jsonStringWithObject:[request requestArgument]]];
    [log appendString:@"\n\n"];
    [log appendString:@"Request URL \n\n"];
    [log appendString:response.requestURL ? response.requestURL : @"url丢失"];
    [log appendString:@"\n"];
    [log appendString:@"\n---------------  Related Request End  --------------\n\n"];
    
    [log appendString:@"\n=============================================================\n                            All End           \n==============================================================\n\n"];
    NSLog(@"%@",log);
}

- (NSString *)jsonStringWithObject:(id)object
{
    if (object)
    {
        NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string ?string : @"数据有问题";
    }
    return @"none";
}

- (void)logRequest:(HYBaseRequest *)request
     systemRequest:(NSURLRequest *)systemRequest
{
    BOOL needLog = request.debugMode ? YES : [HYNetworkConfig sharedInstance].requestLogOn;
    
    if (!needLog)
    {
        return;
    }
    
    //头
    NSMutableString *log = [NSMutableString stringWithFormat:@"\n==============================================================\n                      Request Start            \n==============================================================\n\n"];
    
    //这个response对应的request信息
    if ([HYNetworkConfig sharedInstance].headerLogOn)
    {
        [log appendString:@"Request Header \n\n"];
        [log appendString:[self jsonStringWithObject:systemRequest.allHTTPHeaderFields]];
        [log appendString:@"\n\n"];
    }
    //request的参数
    [log appendString:@"Request param \n\n"];
    [log appendString:[self jsonStringWithObject:[request requestArgument]]];
    [log appendString:@"\n\n"];
    [log appendString:@"Request URL \n\n"];
    [log appendString:request.URL ? request.URL : @"url丢失"];
    [log appendString:@"\n"];
    
    [log appendString:@"\n=============================================================\n                        Reqeust End           \n==============================================================\n\n"];
    NSLog(@"%@",log);

}

@end
