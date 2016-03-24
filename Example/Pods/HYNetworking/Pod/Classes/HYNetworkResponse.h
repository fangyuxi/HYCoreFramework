//
//  HYNetworkResponse.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/12.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYBaseRequest;

//Response状态
typedef NS_ENUM(NSInteger , HYResponseStatus)
{
    HYResponseStatusDefault = 0,
    HYResponseStatusSuccess,
    HYResponseStatusSuccessWithoutValidator,
    HYResponseStatusConnectionFailed,
    HYResponseStatusCanceled,
    HYResponseStatusFailed,
    HYResponseStatusValidatorFailed
};

@interface HYNetworkResponse : NSObject<NSSecureCoding>
{
    
}

//状态
@property (nonatomic, assign, readonly)HYResponseStatus status;
@property (nonatomic, assign, readonly)BOOL fromCache;

//返回值
@property (nonatomic, strong, readonly)NSDictionary *responseHTTPHeadFields;
@property (nonatomic, assign, readonly)NSInteger responseHTTPStatusCode;
@property (nonatomic, strong, readonly)id content;

//error
@property (nonatomic, strong, readonly)NSError *error;
@property (nonatomic, copy, readonly)NSString *errorMSG;

//系统的NSURLResponse 方便调试
@property (nonatomic, strong, readonly)NSURLRequest *systemRequest;
@property (nonatomic, strong, readonly)HYBaseRequest *hyRequest;

//请求的相关属性
@property (nonatomic, copy, readonly)NSString *requestURL;
@property (nonatomic, copy, readonly )NSString *requestIdentifier;
@property (nonatomic, copy)NSDictionary *requestParams;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithResponseRequestId:(NSString *)requestIdentifier
                            systemReqeust:(NSURLRequest *)systemRequest
                                hyRequest:(HYBaseRequest *)hyRequest
                               requestURL:(NSString *)requestURL
                             responseData:(id)content
                           HTTPHeadFields:(NSDictionary *)responseHTTPHeadFields
                               statusCode:(NSInteger)statusCode
                                   status:(HYResponseStatus)status
                                    error:(NSError *)error NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end
