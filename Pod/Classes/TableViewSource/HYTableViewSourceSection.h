//
//  HYTableViewSourceSection.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HYCellModel;

//代表一个section对象

@interface HYTableViewSourceSection : NSObject
{
    
}

@property (nonatomic, assign, readwrite)NSUInteger rowCount;

- (void)addRowWithModel:(HYCellModel* )model;
- (void)addRowsWithModels:(NSArray<HYCellModel *> *)array;
- (void)insertRowsWithModels:(NSArray<HYCellModel *> *)array;
- (void)insertRowWithModel:(HYCellModel* )model atIndex:(NSUInteger)index;

@end
