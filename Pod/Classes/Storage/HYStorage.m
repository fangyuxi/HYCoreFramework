//
//  HYStorage.m
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYStorage.h"

@interface HYStorage ()
@property (nonatomic, strong) NSString * path;
@end
@implementation HYStorage

- (id)readDataWithFileName:(NSString *) aFileName
{
    return nil;
}

- (BOOL)writeDate:(id)aData withFileName:(NSString *) aFileName
{
    return NO;
}

- (id)readDataFromPath:(NSString *) aPath
{
    return nil;
}

- (BOOL)writeData:(id)aData toPath:(NSString *) aPath;
{
    return NO;
}

@end
