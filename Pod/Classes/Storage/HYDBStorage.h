//
//  HYDBStorage.h
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYStorage.h"
@class HYDatabas;
@class HYResultSet;

@interface HYDBStorage : HYStorage

- (instancetype)initWithDB:(NSString *)aDBName;
/**
 *  改变要操作的数据库中的表
 *  接下来所有对数据库的操作都在该表中操作，直到下次切换表为止。
 *
 *  @param aTable 要操作的表名
 */
- (void)changeTable:(NSString *)aTable;

/**
 *  向表中插入数据
 *
 *  @param columns 字典，key为要更新的字段名，value为对应的字段值
 *  @param aTable 要操作的表名
 */
- (BOOL)insert:(NSDictionary *)columns table:(NSString *)aTable;

/**
 *  更新表中数据
 *
 *  @param columns 字典，key为要更新的字段名，value为对应的字段值
 *  @param aTable 要操作的表名
 *  @param where where条件
 */
- (BOOL)update:(NSDictionary *)columns table:(NSString *)aTable whereCondition:(NSString *)where;

/**
 *  删除表中数据
 *
 *  @param aTable 要操作的表名
 */
- (BOOL)deleteFromTable:(NSString *)aTable;

/**
 *  查询表中数据
 *
 *  @param columns 字典，key为要更新的字段名，value为对应的字段值
 *  @param aTable 要操作的表名
 *  @param completed 查询之后的block
 */
- (void)query:(NSArray *)columns table:(NSString *)aTable completed:(void (^)(HYResultSet * resultSet)) completed;

/**
 *  查询表中数据
 *  @param aTable 要操作的表名
 *  @param completed 查询之后的block
 */
- (void)queryAllColumnsInTable:(NSString *)aTable completed:(void (^)(HYResultSet * resultSet)) completed;

/**
 *  查询表中数据,FMDB中的query方法，与FMDB操作一致,sql为完整的参数
 *
 */
- (HYResultSet *)executeQuery:(NSString*)sql;

/**
 *  更新表中的数据,FMDB中的update方法，与FMDB操作一致,sql为完整的参数
 *
 */
- (BOOL)executeUpdate:(NSString*)sql;
/**
 *  获取当前正在操作的数据表
 *
 *  @return 当前正在操作的数据表的名字
 */

- (BOOL)open ;
- (BOOL)close;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *currentTalbe;
@end
