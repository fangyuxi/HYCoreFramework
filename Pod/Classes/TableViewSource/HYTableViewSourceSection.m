//
//  HYTableViewSourceSection.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYTableViewSourceSection.h"

@interface HYTableViewSourceSection ()

@property (nonatomic, strong) NSMutableArray *modelArray;

@end

@implementation HYTableViewSourceSection

#pragma mark public

- (void)addRowWithModel:(HYCellModel* )model;
{
    
}

- (void)addRowsWithModels:(NSArray<HYCellModel *> *)array
{
    
}

- (void)insertRowsWithModels:(NSArray<HYCellModel *> *)array
{
    
}

- (void)insertRowWithModel:(HYCellModel* )model atIndex:(NSUInteger)index
{
    
}

#pragma mark getter

- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
}

@end
