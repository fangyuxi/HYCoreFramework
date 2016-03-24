//
//  HYFileStorage.h
//  FMDBTest
//
//  Created by knight on 15/6/25.
//  Copyright (c) 2015年 bj.58.com. All rights reserved.
//

#import "HYStorage.h"

@interface HYFileStorage : HYStorage

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithPath:(NSString *)aPath NS_DESIGNATED_INITIALIZER;

@end
