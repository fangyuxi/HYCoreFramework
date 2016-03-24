//
//  HYNetworkResponse.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetworkResponse.h"
#import "HYNetworking.h"
#import <CommonCrypto/CommonDigest.h>

static NSString *const HYResponseStatusKey = @"HYResponseStatusKey";
static NSString *const HYResponseHTTPHeadFieldsKey = @"HYResponseHTTPHeadFieldsKey";
static NSString *const HYResponseHTTPStatusCodeKey = @"HYResponseHTTPStatusCodeKey";
static NSString *const HYResponseContentKey = @"HYResponseContentKey";
static NSString *const HYResponseRequestURLKey = @"HYResponseRequestURLKey";
static NSString *const HYResponseRequestIdentifierKey = @"HYResponseRequestIdentifierKey";
static NSString *const HYResponseErrorKey = @"HYResponseErrorKey";
static NSString *const HYResponseErrorMSGKey = @"HYResponseErrorMSGKey";
static NSString *const HYResponseNSRequestKey = @"HYResponseNSRequestKey";
static NSString *const HYResponseHYRequestKey = @"HYResponseHYRequestKey";
static NSString *const HYResponseCacheDate = @"HYResponseCacheDate";
static NSString *const HYResponseCacheMaxAge = @"HYResponseCacheMaxAge";

@interface HYNetworkResponse ()<HYResponseCacheProtocal>
{
    
}

//状态
@property (nonatomic, assign, readwrite)HYResponseStatus status;

//返回值
@property (nonatomic, strong, readwrite)NSDictionary *responseHTTPHeadFields;
@property (nonatomic, assign, readwrite)NSInteger responseHTTPStatusCode;
@property (nonatomic, strong, readwrite)id content;

//请求的相关属性
@property (nonatomic, copy, readwrite)NSString *requestURL;
@property (nonatomic, copy, readwrite)NSString *requestIdentifier;
@property (nonatomic, strong, readwrite)NSError *error;
@property (nonatomic, copy, readwrite)NSString *errorMSG;

@property (nonatomic, assign, readwrite)NSTimeInterval maxAge;
@property (nonatomic, copy, readwrite)NSDate *cacheDate;

@end

@implementation HYNetworkResponse

@synthesize maxAge = _maxAge;

- (void)dealloc
{
    
}

- (instancetype) init
{
    NSLog(@"Use \"initWithResponse to create");
    
    return [self initWithResponseRequestId:nil
                             systemReqeust:nil
                                 hyRequest:nil
                                requestURL:nil
                              responseData:nil
                            HTTPHeadFields:nil
                                statusCode:0
                                    status:0
                                     error:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        NSString *identifier = [aDecoder decodeObjectForKey:HYResponseRequestIdentifierKey];
        _requestIdentifier = identifier ? identifier : @"";
        _systemRequest = [aDecoder decodeObjectForKey:HYResponseNSRequestKey];
        
        NSString *url = [aDecoder decodeObjectForKey:HYResponseRequestURLKey];
        _requestURL = url ? url : @"";
        _content = [aDecoder decodeObjectForKey:HYResponseContentKey];
        _responseHTTPHeadFields = [aDecoder decodeObjectForKey:HYResponseHTTPHeadFieldsKey];
        _responseHTTPStatusCode = [[aDecoder decodeObjectForKey:HYResponseHTTPStatusCodeKey] integerValue];
        _status = [[aDecoder decodeObjectForKey:HYResponseStatusKey] integerValue];
        _cacheDate = [aDecoder decodeObjectForKey:HYResponseCacheDate];
        _maxAge = [[aDecoder decodeObjectForKey:HYResponseCacheMaxAge] doubleValue];
        
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.requestIdentifier forKey:HYResponseRequestIdentifierKey];
    self.systemRequest ? [aCoder encodeObject:self.systemRequest forKey:HYResponseNSRequestKey] : nil;
    self.requestURL ? [aCoder encodeObject:self.requestURL forKey:HYResponseRequestURLKey] :nil;
    self.content ? [aCoder encodeObject:self.content forKey:HYResponseContentKey] :nil;
    self.responseHTTPHeadFields ? [aCoder encodeObject:self.responseHTTPHeadFields
                                                forKey:HYResponseHTTPHeadFieldsKey] :nil;
    [aCoder encodeObject:@(self.responseHTTPStatusCode) forKey:HYResponseHTTPStatusCodeKey];
    [aCoder encodeObject:@(self.status) forKey:HYResponseStatusKey];
    [aCoder encodeObject:self.cacheDate forKey:HYResponseCacheDate];
    [aCoder encodeObject:[NSNumber numberWithDouble:self.maxAge] forKey:HYResponseCacheDate];
}

- (instancetype)initWithResponseRequestId:(NSString *)requestIdentifier
                            systemReqeust:(NSURLRequest *)systemRequest
                                hyRequest:(HYBaseRequest *)hyRequest
                               requestURL:(NSString *)requestURL
                             responseData:(id)content
                           HTTPHeadFields:(NSDictionary *)responseHTTPHeadFields
                               statusCode:(NSInteger)statusCode
                                   status:(HYResponseStatus)status
                                    error:(NSError *)error
{
    self = [super init];
    if (self)
    {
        _cacheDate = [NSDate new];
        _maxAge = [hyRequest cacheMaxAge];
        _status = status;
        _fromCache = NO;
        
        _requestIdentifier = [requestIdentifier copy];
        _requestURL = [requestURL copy];
        _content = content;
        
        _responseHTTPHeadFields = responseHTTPHeadFields;
        _responseHTTPStatusCode = statusCode;
        
        self.error = error;
        
        _systemRequest = systemRequest;
        _hyRequest = hyRequest;
        
        return self;
    }
    return nil;
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

#pragma mark error setter format error&msg

- (void)setError:(NSError *)error
{
    _error = error;
    //网络错误
    if (error.code == NSURLErrorNotConnectedToInternet ||
        error.code == NSURLErrorCannotConnectToHost ||
        error.code == NSURLErrorNetworkConnectionLost ||
        error.code == NSURLErrorTimedOut ||
        error.code == NSURLErrorCannotFindHost)
    {
        self.status = HYResponseStatusConnectionFailed;
        self.errorMSG = KNetworkConnectErrorMSG;
    }
    else if (error.code == NSURLErrorCancelled)
    {
        self.status = HYResponseStatusCanceled;
        self.errorMSG = KNetworkConnectCancelErrorMSG;
    }
    else if (error)
    {
        //参数验证错误
        if (self.status == HYResponseStatusValidatorFailed)
        {
            self.errorMSG = KNetworkResponseValidatetErrorMSG;
        }
        //其他错误
        else
        {
            self.errorMSG = error.localizedDescription;
        }
    }
}

#pragma mark cache 

- (BOOL)isExpire
{
    return [self.cacheDate timeIntervalSinceDate:[NSDate new]] >= (_maxAge ? _maxAge : [HYNetworkConfig sharedInstance].cache.maxAge);
}

- (NSData *)ResponsePresentingData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}

- (NSString *)cacheKey
{
    const char *str = [self.requestURL UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *key = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                                                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return key;
}


@end








