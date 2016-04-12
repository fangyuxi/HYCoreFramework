//
//  HYBaseNetTableViewSource.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseNetTableViewSource.h"

@interface HYBaseNetTableViewSource ()
{
    
}

@property (nonatomic, strong, readwrite)HYSimpleRequest *request;

@end

@implementation HYBaseNetTableViewSource

- (instancetype)initWithDelegate:(id<HYBaseTableViewSourceDelegate>)delegate
{
    self = [super initWithDelegate:delegate];
    if (self)
    {
        self.request = [[HYSimpleRequest alloc] init];
        self.request.validator = self;
        return self;
    }
    return nil;
}

- (void)refreshSource
{
    [self notifyWillRefresh];
    
    self.request.simpleApiUrl = [self apiURL];
    NSDictionary *param = [self requestParamDic];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:param ? param : [NSDictionary new]];
    [paramDic setObject:@(self.pageNum) forKey:@"page"];
    self.request.simpleArgument = paramDic;
    
    [self.request startWithSuccessHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        [self refreshFinishWithData:response.content];
        [self notifyDidFinishRefresh];
        
    } failerHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        [self notifyRefreshError:response.error];
        
    } progressHandler:^(HYBaseRequest *request, int64_t progress) {
        
    }];
}

- (void)loadMoreSource
{
    ++self.pageNum;
    [self notifyWillLoadMore];

    self.request.simpleApiUrl = [self apiURL];
    NSDictionary *param = [self requestParamDic];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionaryWithDictionary:param ? param : [NSDictionary new]];
    [paramDic setObject:@(self.pageNum) forKey:@"page"];
    self.request.simpleArgument = paramDic;
    
    [self.request startWithSuccessHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        [self loadMoreFinishWithData:response.content];
        [self notifyDidFinishLoadMore];
        
    } failerHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        --self.pageNum;
        [self notifyLoadMoreError:response.error];
    } progressHandler:^(HYBaseRequest *request, int64_t progress) {
        
    }];
}

- (id)jsonValidatorData
{
    return nil;
}

- (void)cancel
{
    [self.request cancel];
}

- (void)refreshFinishWithData:(id)data
{
    [super refreshFinishWithData:data];
}

- (void)loadMoreFinishWithData:(id)data
{
    [super loadMoreFinishWithData:data];
}

- (NSDictionary *)requestParamDic
{
    return nil;
}

- (NSString *)apiURL
{
    [self doesNotRecognizeSelector:_cmd];
    return @"";
}

@end
