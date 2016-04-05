//
//  HYBaseSetting.m
//  Pods
//
//  Created by fangyuxi on 16/4/5.
//
//

#import "HYBaseSetting.h"
#import "HYArchiveStorage.h"

@interface HYBaseSetting ()
@property (nonatomic, strong, readwrite) NSDictionary *dic;
@end

@implementation HYBaseSetting

@synthesize dic = _dic;

#pragma mark init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        return self;
    }
    return nil;
}

- (instancetype)initWithDictionary:(id)dic
{
    return [self initWithPath:nil];
}

- (instancetype)initWithPath:(NSString *)path
{
    self = [super initWithDictionary:nil];
    if (self)
    {
        self.storageDirectory = path;
        //会调用mj的方法赋值
        self.dic = (NSDictionary *)[self.storage objectForKey:[self p_keyForSettingDic]];
        if (!self.dic || [self.dic count])
        {
            [self createDefaultSettingValues];
        }
        return self;
    }
    return nil;
}

- (void)createDefaultSettingValues
{
    
}

- (NSDictionary *)generateSettingDic
{
    return nil;
}

#pragma mark setting save reset

- (void)saveSetting
{
    [self.storage setValue:[self generateSettingDic] forKey:[self p_keyForSettingDic]];
}
- (void)clearSetting
{
   
}
- (void)resetSetting
{
    [self createDefaultSettingValues];
    [self saveSetting];
}

#pragma mark key

- (NSString *)p_keyForSettingDic
{
    return NSStringFromClass([self class]);
}


@end
