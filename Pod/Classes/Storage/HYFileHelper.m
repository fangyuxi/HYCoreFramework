//
//  HYFileHelper.m
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYFileHelper.h"

@implementation HYFileHelper
+ (BOOL)fileExistAtpath:(NSString *) aPath {
    
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

+(NSString *) filePathWithName:(NSString *) aName
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                          NSUserDomainMask,
                                                          YES);
    NSString * path = paths[0];
    NSString * filePath = [path stringByAppendingPathComponent:aName];
    if (![self fileExistAtpath:filePath]) {
        return nil;
    }
    return filePath;
}
@end
