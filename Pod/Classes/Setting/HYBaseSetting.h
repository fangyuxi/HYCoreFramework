//
//  HYBaseSetting.h
//  Pods
//
//  Created by fangyuxi on 16/4/5.
//
//

#import "HYBaseModel.h"

/**
 *  setting的基类
 */
@interface HYBaseSetting : HYBaseModel
{
    
}

- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)clearSetting;
- (void)resetSetting;


/// 子类调用这两个方去存储自定义的setting item

/**
 *  存储设置项 首先会在内存缓存中存储一份，然后异步的存入闪存
 *
 *  @param item item
 *  @param key  key
 */
- (void)storeSettingItem:(id)item forKey:(NSString *)key;

/**
 *  取出数据项，如果为空，返回nil
 *
 *  @param key the item key
 *
 *  @return item
 */
- (id)settingItemForKey:(NSString *)key;

@end
