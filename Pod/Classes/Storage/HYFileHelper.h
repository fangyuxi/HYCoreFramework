//
//  HYFileHelper.h
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYFileHelper : NSObject
/**
 *  指定路径下的文件是否存在
 *
 *  @param aPath 文件路径
 *
 *  @return 存在返回YES，否则返回NO
 */
+ (BOOL)fileExistAtpath:(NSString *) aPath;

/**
 *  根据名字产生对应的路径
 *
 *  @param aName 文件名
 *
 *  @return 文件所在全路径
 */
+(NSString *) filePathWithName:(NSString *) aName;
@end
