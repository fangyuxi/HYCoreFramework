//
//  HYModel.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYStorage;

@interface HYBaseModel : NSObject<NSCoding>
{
    
}

- (instancetype)initWithDictionary:(id)dic NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@property (nonatomic, retain, readonly) NSDictionary *dic;

/**
 *  storage & storageDirectory 
 
    当赋值storageDirectory的时候 默认创建的是HYArchiveStorage
    文件名是[self class]
 */
@property (nonatomic, retain)HYStorage *storage;
@property (nonatomic, copy)NSString *storageDirectory;

/**
 *  当字典转模型结束之后，会回调这个方法，做一些其他处理
 */
- (void)dicMapModelFinish;

/**
 *  如果服务端返回的某些字段和我们的属性值不符合
    那么在这个方法里面做一个转换，子类可以实现这个方法,注意是静态方法
 
    @{ourPropertyName : ServerPropertyName}
 *
 *  @return 转换的字典
 */
+ (NSDictionary *)transferDic;

/**
 *  如果服务端返回的数组里面的对象对应着我们的一个Model，那么需要告诉MJExtension
    
    @{ServerArrayName: [OurClass Class]}
 
    子类可以实现这个方法,注意是静态方法
 *
 *  @return 转换的字典
 */
+ (NSDictionary *)hy_objectClassInArray;

@end
