//
//  HYHistory.m
//  HYCoreFramework
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "HYHistory.h"

@interface HYHistory ()

@property (nonatomic, strong) NSMutableArray *itemsArray;

@end

@implementation HYHistory

- (NSArray *)items
{
    return self.itemsArray;
}

- (void)addItem:(id<NSCoding>)item
{
    if (!item) return;
    [self.itemsArray addObject:item];
    [self saveHistory];
}

- (void)insertItem:(id<NSCoding>)item atIndex:(NSUInteger)index
{
    if (!item) return;
    [self.itemsArray insertObject:item atIndex:index];
    [self saveHistory];
}

- (void)removeItem:(id<NSCoding>)item
{
    if (!item) return;
    [self.itemsArray removeObject:item];
    [self saveHistory];
}

- (void)removeItemAtIndex:(NSUInteger)index
{
    [self.itemsArray removeObjectAtIndex:index];
    [self saveHistory];
}

- (void)clearHistory
{
    [self.itemsArray removeAllObjects];
    return [self saveHistory];
}

- (void)saveHistory
{
    [self.cache setObject:self.itemsArray forKey:[self p_historyArrayKey] inDisk:YES withBlock:^{
        
    }];
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super initWithDictionary:nil];
    if (self)
    {
        self.storageDirectory = path;
        self.itemsArray = [self.cache objectForKey:[self p_historyArrayKey]];
    }
    return self;
}

- (NSString *)p_historyKey
{
    return NSStringFromClass([self class]);
}

- (NSString *)p_historyArrayKey
{
    return @"arrayKey";
}

@end
