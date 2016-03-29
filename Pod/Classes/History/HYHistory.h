//
//  HYHistory.h
//  HYCoreFramework
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "HYBaseModel.h"

/**
 *  所有history继承这个基类
 */

@interface HYHistory : HYBaseModel
- (NSArray *)items;
- (void)addItem:(id<NSCoding>)item;
- (void)insertItem:(id<NSCoding>)item atIndex:(NSUInteger)index;
- (void)removeItem:(id<NSCoding>)item;
- (void)removeItemAtIndex:(NSUInteger)index;
- (void)clearHistory;
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
@end
