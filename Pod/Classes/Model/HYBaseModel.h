//
//  HYModel.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYStorage.h"

@interface HYBaseModel : NSObject<NSCoding>
{
    
}

- (instancetype)initWithDictionary:(id)dic NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)initExtension;

@property (nonatomic, retain, readonly) NSDictionary *dic;
@property (nonatomic, retain)HYStorage *storage;


//转换完成后调用，手动修改后也可以调用更新
- (void)updateModel;

//隔离MJExtension中的方法，子类可以覆盖
+ (NSDictionary *)transferDic;
+ (NSDictionary *)hy_objectClassInArray;

@end
