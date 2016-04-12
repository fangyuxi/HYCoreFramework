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

- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

- (void)saveSetting;
- (void)clearSetting;
- (void)resetSetting;

/**
 *  子类覆盖这个方法，初始化设置的默认值
 */
- (void)createDefaultSettingValues;

/**
 *  子类覆盖这个方法，使用自定义的Key，生成一个设置项的字典用于存储
    需要实现transferDic，映射到自己的属性名称
 *
 *  @return 字典
 */
- (NSDictionary *)generateSettingDic;

@end
