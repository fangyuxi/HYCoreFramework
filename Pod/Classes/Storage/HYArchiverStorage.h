//
//  HYArchiverStorage.h
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYStorage.h"

@interface HYArchiverStorage : HYStorage

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 *  初始化函数
 *
 *  @param aPath 归档的路径
 *
 *  @return HYDataCenter实例
 */
- (instancetype)initWithPath:(NSString *)aPath NS_DESIGNATED_INITIALIZER;

/**
 *  设置归档数据
 *
 *  @param aData 需要归档的数据
 *  @param aKey  归档数据对应的key
 */
- (void)setObject:(id<NSCoding>)aData forKey:(id<NSCopying>)aKey;

/**
 *  根据key来获取归档的数据
 *
 *  @param aKey 遵循NSCopying协议的key
 *
 *  @return 遵循NSCoding协议的归档的数据
 */
- (id<NSCoding>)objectForKey:(id<NSCopying>)aKey;
@end
