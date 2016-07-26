//
//  HYTableViewSourceSection.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBaseCellModel.h"
#import "HYBaseFooterHeaderView.h"
#import "HYBaseFooterHeaderModel.h"

//代表一个section对象

@interface HYTableViewSourceSection : NSObject
{
    
}

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, strong, readonly) NSMutableArray *rows;
@property (nonatomic, assign, readonly) NSUInteger rowCount;

@property (nonatomic, strong) HYBaseFooterHeaderModel *headerModel;
@property (nonatomic, strong) HYBaseFooterHeaderModel *footerModel;

@property (nonatomic, strong) HYBaseFooterHeaderView *headerView;
@property (nonatomic, strong) HYBaseFooterHeaderView *footerView;

@property (nonatomic, assign, readonly) CGFloat headerViewHeight;
@property (nonatomic, assign, readonly) CGFloat footerViewHeight;

@property (nonatomic, copy) NSString *headerViewReusedIdentifier;
@property (nonatomic, copy) NSString *footerViewReusedIdentifier;

- (HYBaseCellModel *)rowAtIndex:(NSUInteger)index;

- (void)addRowWithModel:(HYBaseCellModel *)model;
- (void)addRowsWithModels:(NSArray *)array;
- (void)insertRowWithModel:(HYBaseCellModel *)model
                   atIndex:(NSUInteger)index;

- (void)deleteRowAtIndex:(NSUInteger)index;
- (void)deleteRowWithModel:(HYBaseCellModel *)model;
- (void)deleteAllRows;

- (void)replaceRowAtIndex:(NSUInteger)index
                withModel:(HYBaseCellModel *)Model;

- (void)exchangeRowAtIndex:(NSUInteger)idx1
            withRowAtIndex:(NSUInteger)idx2;

@end
