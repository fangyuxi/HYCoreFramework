//
//  HYDBStorage.m
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYDBStorage.h"
#import "SQLStatement.h"
#import "HYDatabase.h"
#import "HYResultSet.h"
@interface HYDBStorage ()

@property (nonatomic , strong) NSString * table;
@property (nonatomic , strong) HYDatabase * database;

@end

@implementation HYDBStorage

- (instancetype)initWithDB:(NSString *)aDBName {
    if (self = [super init]) {
        _database = [HYDatabase databaseWithPath:aDBName];
    }
    return self;
}

- (void)changeTable:(NSString *)aTable {
    self.table = aTable;
}

- (NSString *)currentTalbe {
    return self.table;
}

- (BOOL)insert:(NSDictionary *)columns table:(NSString *)aTable
{
    if (!columns || !aTable) return NO;
    SQLStatement * statement = [self sqlStatementBy:columns];
    NSString * sql = [NSString  stringWithFormat:@"insert into %@(%@) values(%@)",aTable,statement.sql1stPart,statement.sql2ndPart];
    [self.database open];
    BOOL result =[self.database executeUpdate:sql];
    [self.database close];
    return result;
}

- (BOOL)update:(NSDictionary *)columns table:(NSString *)aTable whereCondition:(NSString *)where{
    if (!columns || !aTable || !where) return NO;
    __block NSString * sqlComponent = @"";
    [columns enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        sqlComponent = [sqlComponent stringByAppendingFormat:[obj isKindOfClass:[NSString class]]?@"%@ = '%@',":@"%@ = %@,",key,obj];
    }];
    sqlComponent = [sqlComponent substringToIndex:[sqlComponent length]-1];
    NSString * sql = [NSString stringWithFormat:@"update %@ set %@ where %@",aTable,sqlComponent,where];
    [self.database open];
    BOOL result =[self.database executeUpdate:sql];
    [self.database close];
    return result;
}

- (BOOL)deleteFromTable:(NSString *)aTable {
    if (!aTable) return NO;
    NSString *sql = [NSString stringWithFormat:@"delete from %@",aTable];
    [self.database open];
    BOOL result = [self.database executeUpdate:sql];
    [self.database close];
    return result;
}

- (void)query:(NSArray *)columns table:(NSString *)aTable completed:(void (^)(HYResultSet *))completed {
    if (!columns || !aTable) return;
    __block NSString * sqlComponent = @"";
    [columns enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        sqlComponent = [sqlComponent stringByAppendingFormat:@"%@",obj];
    }];
    sqlComponent = [sqlComponent substringToIndex:[sqlComponent length]-1];
    [self.database open];
    NSString * sql = [NSString stringWithFormat:@"select %@ from %@",sqlComponent,aTable];
    HYResultSet * result = [self executeQuery:sql];
    completed(result);
    [self.database close];
    return ;
}
- (void)queryAllColumnsInTable:(NSString *)aTable completed:(void (^)(HYResultSet *))completed {
    if (!aTable) return ;
    NSString * sql = [NSString stringWithFormat:@"select * from %@",aTable];
    [self.database open];
    HYResultSet * result = (HYResultSet *)[self.database executeQuery:sql];
    completed(result);
    [self.database close];
    return ;
}



- (HYResultSet *)executeQuery:(NSString *)sql {
    return (HYResultSet *)[self.database executeQuery:sql];
}

- (BOOL)executeUpdate:(NSString*)sql {
    return [self.database executeUpdate:sql];
}


- (SQLStatement *)sqlStatementBy:(NSDictionary *)columns {
    __block  NSString * sqlFirstPart = @"";
    __block  NSString * sqlSecondPart = @"";
    [columns enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        sqlFirstPart = [sqlFirstPart stringByAppendingFormat:@"%@,",key ];
        sqlSecondPart = [sqlSecondPart stringByAppendingFormat:[obj isKindOfClass:[NSString class]]?@"'%@',":@"%@,",obj ];
    }];
    sqlFirstPart = [sqlFirstPart substringToIndex:[sqlFirstPart length]-1];
    sqlSecondPart = [sqlSecondPart substringToIndex:[sqlSecondPart length]-1];
    SQLStatement * statement = [[SQLStatement alloc] init];
    statement.sql1stPart = sqlFirstPart;
    statement.sql2ndPart = sqlSecondPart;
    return statement;
}

- (BOOL)open {
    return [self.database open];
}

- (BOOL)close {
    return [self.database close];
}
@end
