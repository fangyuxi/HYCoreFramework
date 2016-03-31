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
    [self refreshFinishWithData:nil];
    [self notifyDidFinishRefresh];
}

- (void)refreshFinishWithData:(id)data
{
    [super refreshFinishWithData:data];
    
    @weakify(self);
    
    NSMutableArray *boolSignals = [NSMutableArray array];
    NSMutableArray *section = [NSMutableArray array];
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"标题";
        [section addObject:m];
        [boolSignals addObject:[RACObserve(m, content) map:^id(NSString *value) {
            return @(value.length > 0 && value.length < 10);
        }]];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"描述";
        [section addObject:m];
        [boolSignals addObject:[RACObserve(m, content) map:^id(NSString *value) {
            return @(value.length > 0 && value.length < 5);
        }]];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"方式";
        [section addObject:m];
        [boolSignals addObject:[RACObserve(m, content) map:^id(NSString *value) {
            return @(value.length > 0 && value.length < 6);
        }]];
    }
    
    {
        SLRACDemo1CellModel *m = [[SLRACDemo1CellModel alloc] initWithDictionary:nil];
        m.title = @"价格";
        [section addObject:m];
        [boolSignals addObject:[RACObserve(m, content) map:^id(NSString *value) {
            return @(value.length > 0 && value.length < 3);
        }]];
    }
    
    [self.cellModels addObject:section];
    
    [[RACSignal combineLatest:boolSignals] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        BOOL tmp = YES;
        for (NSNumber *b in tuple.allObjects) {
            tmp = tmp && b.boolValue;
        }
        self.canSubmit = tmp;
    }];
}

@end
