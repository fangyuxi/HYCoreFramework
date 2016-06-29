//
//  HYBaseSetting.m
//  Pods
//
//  Created by fangyuxi on 16/4/5.
//
//

#import "HYBaseSetting.h"

@interface HYBaseSetting ()

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
        return self;
    }
    return nil;
}

#pragma mark setting

- (void)clearSetting
{
   
}

- (void)resetSetting
{
    
}


- (void)storeSettingItem:(id)item forKey:(NSString *)key
{
    [self.cache setObject:item forKey:key inDisk:YES withBlock:^{
        
    }];
}

- (id)settingItemForKey:(NSString *)key
{
    return nil;
}

@end
