//
//  HYBaseRequestInternal.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/8.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseRequestInternal.h"
#import "HYNetworkTools.h"
#import "HYNetworkLogger.h"
#import <objc/runtime.h>

static HYBaseRequestInternal *sharedInstance       = nil;

@implementation HYBaseRequestInternal{

    AFHTTPSessionManager *_manager;
    NSMutableDictionary *_dataTaskDic;
    dispatch_queue_t _hynetwork_series_queue;
}


#pragma mark init

+ (HYBaseRequestInternal *)sharedInstance
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    

    return sharedInstance;
}

- (instancetype)init
{
    if (!sharedInstance)
    {
        sharedInstance = [super init];
        _hynetwork_series_queue = dispatch_queue_create([@"hynetwork_series_queue"
                                                         cStringUsingEncoding:NSUTF8StringEncoding],
                                                        DISPATCH_QUEUE_SERIAL);
        
        _manager = [AFHTTPSessionManager manager];
        
        _networkConfig = [HYNetworkConfig sharedInstance];
        _dataTaskDic = [NSMutableDictionary dictionary];
        
    }
    return sharedInstance;
}

#pragma mark send cancel

- (void)sendRequest:(HYBaseRequest *)request
{
    
    dispatch_async(_hynetwork_series_queue , ^{
        
        
        //require protocal method
        HYRequestMethod method = [request requestMethod];
        
        NSAssert(method == HYRequestMethodGet || method == HYRequestMethodPost || method == HYRequestMethodHead || method == HYRequestMethodPut || method == HYRequestMethodDelete || method == HYRequestMethodPatch,@"Please Provide Legal Request Method");
        
        NSString *url = [self p_buildFullUrlWithRequest:request];
        
        //optional protcal method
        NSString *downloadPath = [request respondsToSelector:@selector(downloadPath)] ? [request downloadPath] : nil;
        id param = [request respondsToSelector:@selector(requestArgument)] ? [request requestArgument] : nil;
        HYConstructingBlock constructingBlock = [request respondsToSelector:@selector(constructingBodyBlock)] ? [request constructingBodyBlock]: nil;
        
        //timeout
        _manager.requestSerializer.timeoutInterval = [request respondsToSelector:@selector(timeIntervalSinceNow)] ? [request requestTimeoutInterval] : KHYNetworkDefaultTimtout;
        
        //security
        NSUInteger pinningMode                  = [HYNetworkConfig sharedInstance].securityPolicy.pinningMode;
        AFSecurityPolicy *securityPolicy        = [AFSecurityPolicy policyWithPinningMode:pinningMode];
        securityPolicy.allowInvalidCertificates = [HYNetworkConfig sharedInstance].securityPolicy.allowInvalidCertificates;
        securityPolicy.validatesDomainName      = [HYNetworkConfig sharedInstance].securityPolicy.validatesDomainName;
        _manager.securityPolicy = securityPolicy;
        
        //header
        NSDictionary *headerFieldValueDictionary = [request respondsToSelector:@selector(requestHeaderFieldsWithCookies:)] ? [request requestHeaderValueDictionary]: nil;
        if (headerFieldValueDictionary != nil)
        {
            for (id httpHeaderField in headerFieldValueDictionary.allKeys)
            {
                id value = headerFieldValueDictionary[httpHeaderField];
                if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]])
                {
                    
                    [_manager.requestSerializer setValue:(NSString *)value
                                      forHTTPHeaderField:(NSString *)httpHeaderField];
                }
                else
                {
                    
                }
            }
        }

        
        [self p_sendRequestWithUrl:url
                             param:param
                            method:method
                           request:request
                      downloadPath:downloadPath
                 constructingBlock:constructingBlock];
    });
}

- (void)p_sendRequestWithUrl:(NSString *)url
                       param:(id)param
                      method:(HYRequestMethod)method
                     request:(HYBaseRequest *)request
                downloadPath:(NSString *)downloadPath
         constructingBlock:(HYConstructingBlock)constructingBlock
{
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionTask *task;
    void (^successBlock)(NSURLSessionDataTask *task, id responseObject)
    = ^(NSURLSessionDataTask * task, id responseObject)
    {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf p_handleSuccessWithResponse:responseObject andRequest:request];
    };
    
    void (^failureBlock)(NSURLSessionDataTask * task, NSError * error)
    = ^(NSURLSessionDataTask * task, NSError * error)
    {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf p_handleFailureWithError:error andRequest:request];
    };
    
    void (^progressBlock)(NSProgress *progress)
    = ^(NSProgress *progress)
    {
        if (progress.totalUnitCount <= 0)
        {
            return;
        }
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf p_handleProgress:progress.totalUnitCount andRequest:request];
    };
    
    if (method == HYRequestMethodGet)
    {
        //是不是下载任务
        if (![HYNetworkTools HYNetworkIsEmptyString:downloadPath])
        {
            task = [_manager GET:url
                      parameters:param
                        progress:progressBlock
                         success:successBlock
                         failure:failureBlock];
        }
        else
        {
            task = [_manager GET:url
                      parameters:param
                        progress:nil
                         success:successBlock
                         failure:failureBlock];
        }
    }
    else if (method == HYRequestMethodPost)
    {
        //有上传文件
        if (constructingBlock)
        {
            task = [_manager POST:url
                       parameters:param
        constructingBodyWithBlock:constructingBlock
                         progress:progressBlock
                          success:successBlock
                          failure:failureBlock];
        }
        else
        {
            task = [_manager POST:url
                       parameters:param
                         progress:progressBlock
                          success:successBlock
                          failure:failureBlock];
        }
        
    }
    else if (method == HYRequestMethodDelete)
    {
        task = [_manager DELETE:url parameters:param success:successBlock failure:failureBlock];
    }
    else if (method == HYRequestMethodHead)
    {
        task = [_manager HEAD:url parameters:param success:^void(NSURLSessionDataTask *task){
            
            if (successBlock)
            {
                successBlock(task, nil);
            }
        } failure:failureBlock];
    }
    else if (method == HYRequestMethodPut)
    {
        task = [_manager PUT:url parameters:param success:successBlock failure:failureBlock];
    }
    else if (method == HYRequestMethodPatch)
    {
        task = [_manager PATCH:url parameters:param success:successBlock failure:failureBlock];
    }
    
    if (task)
    {
        [request setValue:[task.currentRequest.URL absoluteString] forKey:@"URL"];
        [self p_recodeDataTaskRequest:request dataTask:task];
    }
    
    /**
     一边发送请求一边打印NSURLRequest 实例的时候会产生内部崩溃 故systemRequest暂时不传了
     *  见 https://github.com/AFNetworking/AFNetworking/pull/843/commits/db305db733da040974c12f5fc6653db4388ac230
     */
    [[HYNetworkLogger sharedInstance] logRequest:request systemRequest:nil];
}

- (void)cancelRequeset:(HYBaseRequest *)request
{
    dispatch_async(_hynetwork_series_queue, ^(){
    
        NSURLSessionTask *task = [_dataTaskDic objectForKey:[self p_requestHash:request]];
        [task cancel];
    });
    
}

- (void)cancelAllRequest
{
    
}

- (BOOL)isLoadingRequest:(HYBaseRequest *)request
{
    NSURLSessionTask *task = [_dataTaskDic objectForKey:[self p_requestHash:request]];
    if (task.state == NSURLSessionTaskStateRunning
        || task.state == NSURLSessionTaskStateSuspended)
    {
        return YES;
    }
    return NO;
}

#pragma mark build URL

- (NSString *)p_buildFullUrlWithRequest:(HYBaseRequest *)request
{
    NSString *url = nil;
    if ([request respondsToSelector:@selector(fullUrl)] &&
        ![HYNetworkTools HYNetworkIsEmptyString:[request fullUrl]])
    {
        url = [request fullUrl];
        return url;
    }
    else if ([[request apiUrl] hasPrefix:@"http"] ||
             [[request apiUrl] hasPrefix:@"https"])
    {
        url = [request apiUrl];
        return url;
    }
    
    url = [request apiUrl];
    
    //url filters
    if (request.urlFilter)
    {
        url = [request.urlFilter filterUrl:url withRequest:request];
    }
    else
    {
        NSArray *filters = [_networkConfig urlFilters];
        for (id<HYNetworkUrlFilterProtocal>filter in filters)
        {
            url = [filter filterUrl:url withRequest:request];
        }
    }
    
    NSString *baseUrl = nil;
    if (request.server)
    {
        baseUrl = [request.server baseUrl];
    }
    else
    {
        baseUrl = [_networkConfig.defaultSever baseUrl];
    }
    
    NSParameterAssert(url);
    NSParameterAssert(baseUrl);
    NSString *fullUrl = [NSString stringWithFormat:@"%@%@",baseUrl, url];
    return fullUrl;
}

#pragma mark store data task

- (NSString *)p_requestHash:(HYBaseRequest *)request
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)[request hash]];
}

- (void)p_recodeDataTaskRequest:(HYBaseRequest *)request dataTask:(NSURLSessionTask *)task
{
    if (request)
    {
       [_dataTaskDic setObject:task forKey:[self p_requestHash:request]];
    }
}

- (void)p_removeDataTaskRequest:(HYBaseRequest *)request
{
    if (request)
    {
       [_dataTaskDic removeObjectForKey:[self p_requestHash:request]];
    }
}

#pragma mark handle request

- (void)p_handleSuccessWithResponse:(id)responseObject
                         andRequest:(HYBaseRequest *)request
{
    NSURLSessionTask *task = [_dataTaskDic objectForKey:[self p_requestHash:request]];
    HYResponseStatus status = HYResponseStatusSuccessWithoutValidator;
    HYNetworkResponse *hyResponse = [self p_createResponseWithTask:task
                                                           request:request
                                                     systemReqeust:task.currentRequest
                                                            status:status
                                                      responseData:responseObject
                                                             error:nil];
    //过滤一下业务方定制的错误
    NSError *error = nil;
    if (request.responseFilter)
    {
        error = [request.responseFilter filterResponse:responseObject withRequest:request];
    }
    else
    {
        for (id<HYNetworkResponseFilterProtocal> filter in _networkConfig.responseFilters)
        {
            error = [filter filterResponse:responseObject withRequest:request];
        }
    }
    
    if (error)
    {
        [hyResponse setValue:error forKey:@"error"];
        [self p_toggleFailerRequestDelegateAndBlockWithRequest:request andResponse:hyResponse];
        [self p_removeDataTaskRequest:request];
        return;
    }
    
    if (request.validator)
    {
        if ([request.validator jsonValidatorData])
        {
            id noMatch = nil;
            if([HYNetworkTools checkJson:responseObject
                           withValidator:[request.validator jsonValidatorData] noMatchKey:noMatch])
            {
                status = HYResponseStatusSuccess;
                [hyResponse setValue:@(status) forKey:@"status"];
            }
            else
            {
                status = HYResponseStatusValidatorFailed;
                [hyResponse setValue:@(status) forKey:@"status"];
                [hyResponse setValue:[NSError errorWithDomain:KNetworkHYErrorDomain code:KNetworkResponseValidatetErrorCode userInfo:nil] forKey:@"error"];
                
                [self p_toggleFailerRequestDelegateAndBlockWithRequest:request andResponse:hyResponse];
                [self p_removeDataTaskRequest:request];
                return;
            }
        }
    }
    
    [self p_toggleSuccessRequestDelegateAndBlockWithRequest:request
                                                andResponse:hyResponse];
    [self p_removeDataTaskRequest:request];
}

- (void)p_handleFailureWithError:(NSError *)error
                    andRequest:(HYBaseRequest *)request
{
    NSURLSessionTask *task = [_dataTaskDic objectForKey:[self p_requestHash:request]];
    HYResponseStatus status = HYResponseStatusFailed;
    HYNetworkResponse *hyResponse = [self p_createResponseWithTask:task
                                                           request:request
                                                     systemReqeust:task.currentRequest
                                                            status:status
                                                      responseData:nil
                                                             error:error];
    
    [self p_toggleFailerRequestDelegateAndBlockWithRequest:request
                                               andResponse:hyResponse];
    [self p_removeDataTaskRequest:request];
}

- (void)p_handleProgress:(int64_t)progress
              andRequest:(HYBaseRequest *)request
{
    if ([request.delegate respondsToSelector:@selector(request:loadingProgress:)])
    {
        [request.delegate request:request loadingProgress:0];
    }
}

#pragma mark create response

- (HYNetworkResponse *)p_createResponseWithTask:(NSURLSessionTask *)task
                                        request:(HYBaseRequest *)request
                                  systemReqeust:(NSURLRequest *)systemRequest
                                         status:(HYResponseStatus)status
                                   responseData:(id)data
                                          error:(NSError *)error;
{
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
    NSURLRequest *urlRequest = task.currentRequest;
    HYNetworkResponse *response = [[HYNetworkResponse alloc] initWithResponseRequestId:[request identifier]
                                                                         systemReqeust:systemRequest
                                                                             hyRequest:request
                                                                           requestURL:[urlRequest.URL absoluteString]
                                                                         responseData:data
                                                                       HTTPHeadFields:urlResponse.allHeaderFields
                                                                           statusCode:urlResponse.statusCode
                                                                               status:status
                                                                                error:error];
    return response;
}

#pragma mark toggle request delegate & block

- (void)p_toggleSuccessRequestDelegateAndBlockWithRequest:(HYBaseRequest *)request
                                        andResponse:(HYNetworkResponse *)responseObject
{
    
    for (id<HYNetworkResponseFilterProtocal>filter in _networkConfig.responseFilters)
    {
        NSError *error = [filter filterResponse:responseObject withRequest:request];
        if (error)
        {
            [responseObject setValue:error forKey:@"error"];
            [self p_toggleFailerRequestDelegateAndBlockWithRequest:request andResponse:responseObject];
            return;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^(){
    
        [[HYNetworkLogger sharedInstance] logResponse:responseObject withRequest:request];
        
        if (request.successHandler)
        {
            request.successHandler(request, responseObject);
        }
        if ([request.delegate respondsToSelector:@selector(requestDidFinished:withResponse:)])
        {
            [request.delegate requestDidFinished:request withResponse:responseObject];
        }
        [request clearBlock];
    
    });
    
}

- (void)p_toggleFailerRequestDelegateAndBlockWithRequest:(HYBaseRequest *)request
                                                 andResponse:(HYNetworkResponse *)responseObject
{
    dispatch_async(dispatch_get_main_queue(), ^(){
    
        [[HYNetworkLogger sharedInstance] logResponse:responseObject withRequest:request];
        
        if (request.failerHandler)
        {
            request.failerHandler(request, responseObject);
        }
        if ([request.delegate respondsToSelector:@selector(request:withErrorResponse:)])
        {
            [request.delegate request:request withErrorResponse:responseObject];
        }
        [request clearBlock];
    
    });
    
}

@end
