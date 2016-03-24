//
//  HYDatabase.h
//  HYCoreFramework
//
//  Created by knight on 15/9/13.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "FMDatabase.h"

@interface HYDatabase : FMDatabase

+ (instancetype)databaseWithPath:(NSString*)inPath;

- (instancetype)initWithPath:(NSString*)inPath;

@end
