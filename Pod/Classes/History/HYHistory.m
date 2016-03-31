//
//  HYHistory.m
//  HYCoreFramework
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "HYHistory.h"
#import "HYArchiveStorage.h"

@interface HYHistory ()
@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) HYArchiveStorage *storage;

@end

@implementation HYHistory

@dynamic storage;

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
    [self.storage setValue:@{[self p_historyArrayKey] : self.itemsArray} forKey:[self p_historyKey]];
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super initWithDictionary:nil];
    if (self) {
        self.storageDirectory = path;
        self.storage = [[HYArchiveStorage alloc] initWithPath:[self p_historyFilePath]];
        
        NSDictionary *dic = (NSDictionary *)[self.storage objectForKey:[self p_historyKey]];
        self.itemsArray = dic[[self p_historyArrayKey]] ? : [NSMutableArray array];
    }
    return self;
}

- (NSString *)p_historyFileName
{
    return NSStringFromClass([self class]);
}

- (NSString *)p_historyFilePath
{
    return [self.storageDirectory stringByAppendingPathComponent:[self p_historyFileName]];
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
