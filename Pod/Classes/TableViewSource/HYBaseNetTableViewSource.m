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

@property (nonatomic, strong, readwrite)HYBaseRequest *request;

@end

@implementation HYBaseNetTableViewSource

- (void)refreshSource
{
    [self notifyWillRefresh];
    
    HYSimpleRequest *request = [[HYSimpleRequest alloc] init];
    request.simpleApiUrl = [self apiURL];
    request.simpleArgument = [self requestParamDic];
    self.request = request;
    
    [request startWithSuccessHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
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
    
    HYSimpleRequest *request = [[HYSimpleRequest alloc] init];
    request.simpleApiUrl = [self apiURL];
    request.simpleArgument = [self requestParamDic];
    self.request = request;
    
    [request startWithSuccessHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        [self loadMoreFinishWithData:response.content];
        [self notifyDidFinishLoadMore];
        
    } failerHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
        
        --self.pageNum;
        [self notifyLoadMoreError:response.error];
    } progressHandler:^(HYBaseRequest *request, int64_t progress) {
        
    }];
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
    return @{@"pageNum":@(self.pageNum)};
}

- (NSString *)apiURL
{
    [self doesNotRecognizeSelector:_cmd];
    return @"";
}

@end
