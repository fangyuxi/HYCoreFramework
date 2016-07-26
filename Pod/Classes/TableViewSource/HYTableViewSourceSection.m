//
//  HYTableViewSourceSection.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYTableViewSourceSection.h"

@interface HYTableViewSourceSection ()

@property (nonatomic, strong, readwrite) NSMutableArray<HYTableViewSourceSection *> *rows;

@end

@implementation HYTableViewSourceSection

#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        return self;
    }
    return nil;
}

- (HYBaseCellModel *)rowAtIndex:(NSUInteger)index
{
    if (index < self.rowCount)
    {
        return [self.rows objectAtIndex:index];
    }
    return nil;
}

#pragma mark add row

- (void)addRowWithModel:(HYBaseCellModel *)model
{
    [self insertRowWithModel:model atIndex:[self.rows count]];
}

- (void)addRowsWithModels:(NSArray*)array
{
    if (array)
    {
        [self.rows addObjectsFromArray:array];
    }
}

- (void)insertRowWithModel:(HYBaseCellModel *)model atIndex:(NSUInteger)index
{
    if (model && index <= self.rows.count)
    {
        [self.rows insertObject:model atIndex:index];
    }
}

- (void)deleteRowAtIndex:(NSUInteger)index
{
    if (index < self.rows.count)
    {
        [self.rows removeObjectAtIndex:index];
    }
}

- (void)deleteRowWithModel:(HYBaseCellModel *)model
{
    [self.rows removeObject:model];
}

- (void)deleteAllRows
{
    [self.rows removeAllObjects];
}

- (void)replaceRowAtIndex:(NSUInteger)index
                withModel:(HYBaseCellModel *)Model
{
    if (Model)
    {
        [self.rows replaceObjectAtIndex:index withObject:Model];
    }
}

- (void)exchangeRowAtIndex:(NSUInteger)idx1
            withRowAtIndex:(NSUInteger)idx2
{
    if (idx1 < self.rows.count && idx2 < self.rows.count)
    {
        [self.rows exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}

#pragma mark getter

- (NSMutableArray *)rows
{
    if (!_rows)
    {
        _rows = [NSMutableArray<HYTableViewSourceSection *> array];
    }
    return _rows;
}

- (NSUInteger)rowCount
{
    return [self.rows count];
}

- (NSString *)headerViewReusedIdentifier
{
    return NSStringFromClass([self.headerModel class]);
}

- (NSString *)footerViewReusedIdentifier
{
    return NSStringFromClass([self.footerModel class]);
}

- (CGFloat)headerViewHeight
{
    if (!self.headerModel)
    {
        return self.headerView.frame.size.height;
    }
    
    if (self.headerModel.footerHeaderHeight == HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout)
    {
        return [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    return self.headerModel.footerHeaderHeight;
}

- (CGFloat)footerViewHeight
{
    if (!self.footerModel)
    {
        return self.footerView.frame.size.height;
    }
    
    if (self.footerModel.footerHeaderHeight == HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout)
    {
        return [self.footerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    }
    return self.footerModel.footerHeaderHeight;
}

@end
