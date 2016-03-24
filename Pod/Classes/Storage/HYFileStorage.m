//
//  HYFileStorage.m
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//
//改成多线程的
#import "HYFileStorage.h"
#import "HYFileHelper.h"
@interface HYFileStorage ()
@property (nonatomic, strong) NSString * path;
@end
@implementation HYFileStorage

- (instancetype)init
{
    return [self initWithPath:nil];
}

- (instancetype)initWithPath:(NSString *)aPath {
    if (self = [super init]) {
        _path = aPath;
    }
    return self;
}
#pragma mark - private methods

#pragma mark - fileOperations
- (id)readDataFromPath:(NSString *)aPath {
    if ([HYFileHelper fileExistAtpath:aPath]) {
        return [[NSMutableArray alloc] initWithContentsOfFile:aPath];
    }
    return nil;
}

- (id)readDataWithFileName:(NSString *)aFileName {
    NSString * filePath = [HYFileHelper filePathWithName:aFileName];
    return [self readDataFromPath:filePath];
}

- (BOOL)writeData:(id)aData toPath:(NSString *)aPath {
    if ([HYFileHelper fileExistAtpath:aPath]) {
        [aData writeToFile:aPath atomically:YES];
        return YES;
    }
    return NO;
}

- (BOOL)writeDate:(id)aData withFileName:(NSString *)aFileName {
    NSString * filePath = [HYFileHelper filePathWithName:aFileName];
    return [self writeData:aData toPath:filePath];
}
@end
