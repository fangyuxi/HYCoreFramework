//
//  HYHomeCellModel.h
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/25.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYCoreFramework.h"

@interface HYHomeCellModel : HYBaseCellModel

@property (nonatomic, assign) NSInteger messageCount;

@property (nonatomic, assign) NSInteger clickCount;

@property (nonatomic, copy) NSString *descript;

@property (nonatomic, assign) NSInteger offlineCert;

@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy) NSString *skillPrice;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, assign) NSInteger cateId;

@property (nonatomic, copy) NSString *lon;

@property (nonatomic, copy) NSString *cateName;

@property (nonatomic, assign) long long skillId;

@property (nonatomic, copy) NSString *headUrl;

@property (nonatomic, assign) NSInteger auth;

@property (nonatomic, copy) NSString *skillName;

@property (nonatomic, copy) NSString *distance;

@property (nonatomic, strong) NSArray<NSString *> *pics;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger skillOrderCount;

@property (nonatomic, assign) long long userId;

@end
