//
//  HYArchiverStorage.m
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYArchiverStorage.h"
#import "HYFileHelper.h"
@interface HYArchiverStorage ()
@property (nonatomic, strong) NSString * path;
@property (nonatomic, strong) NSMutableDictionary * dic;
@end

@implementation HYArchiverStorage

- (instancetype)init
{
    return [self initWithPath:nil];
}

- (instancetype)initWithPath:(NSString *)aPath {
    if (self = [super init]) {
        _path = aPath;
        _dic = [self unArchiverDicFromPath:_path];
    }
    return self;
}

- (void)setObject:(id<NSCoding>)aData forKey:(id<NSCopying>)aKey {
    id<NSCoding> data = nil;
    if (!self.dic) {
        self.dic = [[NSMutableDictionary alloc] init];
    }else {
        data = (self.dic)[aKey];
    }
    if (data != aData) {
        (self.dic)[aKey] = aData;
        [self writeData:self.dic toPath:_path];
    }
}

- (id<NSCoding>)objectForKey:(id<NSCopying>)aKey {
    return (self.dic)[aKey];
}

- (NSMutableDictionary *)unArchiverDicFromPath:(NSString *)aPath {
   NSMutableDictionary * data = [self readDataFromPath:aPath];
    if (!data) {
        data = [[NSMutableDictionary alloc] init];
    }
    return data;
}

- (id)readDataFromPath:(NSString *)aPath {
    if ([HYFileHelper fileExistAtpath:aPath]) {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
    }
    return nil;
}

- (id)readDataWithFileName:(NSString *)aFileName {
    NSString * filePath = [HYFileHelper filePathWithName:aFileName];
    return [self readDataFromPath:filePath];
}

- (BOOL)writeData:(id)aData toPath:(NSString *)aPath
{
    //全覆盖
    if (aPath == nil)
    {
        return NO;
    }
    return [NSKeyedArchiver archiveRootObject:aData toFile:aPath];
}

- (BOOL)writeDate:(id)aData withFileName:(NSString *)aFileName {
    NSString * filePath = [HYFileHelper filePathWithName:aFileName];
    return [self writeData:aData toPath:filePath];
}
@end
