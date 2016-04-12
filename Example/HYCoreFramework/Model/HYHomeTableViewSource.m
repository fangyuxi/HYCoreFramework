//
//  HYHomeTableViewSource.m
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/24.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYHomeTableViewSource.h"
#import "HYHomeCellModel.h"
#import "MJExtension.h"

@implementation HYHomeTableViewSource


- (NSString *)apiURL
{
    return @"/api/user?method=skills.list.home";
}

- (NSDictionary *)requestParamDic
{
    return nil;
}

- (void)refreshFinishWithData:(id)data
{
    NSArray *dics = [[[data objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"skilllist"];
    NSMutableArray *section = [NSMutableArray array];
    
    for (NSDictionary *dic in dics)
    {
        HYHomeCellModel *cellModel = [[HYHomeCellModel alloc] initWithDictionary:dic];
        [section addObject:cellModel];
    }
    [self.cellModels addObject:section];
}

- (void)loadMoreFinishWithData:(id)data
{
    
}

- (id)jsonValidatorData
{
    return @{
             @"result":[NSDictionary class],
             @"result" :@{@"data":[NSDictionary class]},
             @"result":@{@"data":@{@"skilllist":[NSArray class]}},
             @"result":@{@"data":@{@"skilllist":@[@{@"cateName":[NSString class]}]}}
             };
}

- (NSArray<Class> *)containedCellModelsClassArray
{
    return @[[HYHomeCellModel class]];
}

@end
