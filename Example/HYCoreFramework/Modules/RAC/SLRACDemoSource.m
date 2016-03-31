//
//  SLRACDemoSource.m
//  HYCoreFramework
//
//  Created by 58 on 3/31/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRACDemoSource.h"
#import "SLRACDemo1CellModel.h"

@implementation SLRACDemoSource

#pragma mark - HYTableViewSourceProtocol

- (NSArray<Class> *)containedCellModelsClassArray
{
    return @[SLRACDemo1CellModel.class];
}

- (void)refreshSource
{
//    [self notifyWillRefresh];
    [self refreshFinishWithData:nil];
    [self notifyDidFinishRefresh];
}

- (void)refreshFinishWithData:(id)data
{
    [super refreshFinishWithData:data];
    
    NSMutableArray *section = [NSMutableArray array];
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"标题";
        [section addObject:m];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"描述";
        [section addObject:m];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"方式";
        [section addObject:m];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"价格";
        [section addObject:m];
    }
    
    [self.cellModels addObject:section];
}

@end
