//
//  HYHistory.h
//  HYCoreFramework
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import <HYCoreFramework/HYCoreFramework.h>

/**
 *  所有history继承这个基类
 */

@interface HYHistory : HYBaseModel
- (NSArray *)items;
- (void)addItem:(id<NSCoding>)item;
- (BOOL)insertItem:(id<NSCoding>)item atIndex:(NSUInteger)index;
- (BOOL)removeItem:(id<NSCoding>)item;
- (BOOL)removeItemAtIndex:(NSUInteger)index;
- (BOOL)clearHistory;
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
@end
