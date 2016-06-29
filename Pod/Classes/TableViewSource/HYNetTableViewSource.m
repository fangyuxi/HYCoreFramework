//
//  HYBaseNetTableViewSource.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYNetTableViewSource.h"

@interface HYNetTableViewSource ()
{
    
}

@property (nonatomic, strong, readwrite)HYSimpleRequest *request;

@end

@implementation HYNetTableViewSource

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
    
    [self.request startWithSuccessHandler:^(HYBaseRequest * _Nonnull request, HYNetworkResponse * _Nonnull response) {
        
        [self refreshFinishWithData:response.content];
        [self notifyDidFinishRefresh];
        
    } failuerHandler:^(HYBaseRequest * _Nonnull request, HYNetworkResponse * _Nonnull response) {
        
        [self notifyRefreshError:response.error];
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
    
    
    [self.request startWithSuccessHandler:^(HYBaseRequest * _Nonnull request, HYNetworkResponse * _Nonnull response) {
        
        [self loadMoreFinishWithData:response.content];
        [self notifyDidFinishLoadMore];
        
    } failuerHandler:^(HYBaseRequest * _Nonnull request, HYNetworkResponse * _Nonnull response) {
        
        --self.pageNum;
        [self notifyLoadMoreError:response.error];
    }];
}

- (id)responseDataValidator
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
