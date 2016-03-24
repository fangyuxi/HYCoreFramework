//
//  HYStorage.h
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HYDataType) {
    HYFileType = 1,
    HYDataBaseType = 2,
    HYArchiveType = 3,
    HYCoreDataType = 4
};

@protocol HYDataOperations <NSObject>

/**
 *  根据文件名来读取数据，默认路径
 *
 *  @param aFileName 文件名
 *
 *  @return 有数据则返回数据，没有数据返回nil
 */
- (id)readDataWithFileName:(NSString *) aFileName;

/**
 *  把数据写到对应的文件，默认路径
 *
 *  @param aFileName 文件名
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL)writeDate:(id)aData withFileName:(NSString *) aFileName;

/**
 *  从指定路径读数据，自定义路径，
 *
 *  @param aPath 文件路径
 *
 *  @return 有数据则返回数据，没有数据返回nil
 */
- (id)readDataFromPath:(NSString *) aPath;

/**
 *  把数据写到指定路径，自定义路径
 *
 *  @param aPath 文件路径
 *
 *  @return 成功返回YES，失败返回NO
 */
- (BOOL)writeData:(id)aData toPath:(NSString *) aPath;

@end


@interface HYStorage : NSObject <HYDataOperations>

@end
