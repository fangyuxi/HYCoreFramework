//
//  HYResponseCache.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/19.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HYNetworkResponse;
@class HYBaseRequest;

/**
 * HYResponseCacheProtocal 
 
   If you have a Class ,want to cache with HYResponseCache ,then you must comform this protocal
 
   and complete the @required 
 */

@protocol HYResponseCacheProtocal <NSObject>

@required

@property (nonatomic, assign, readonly)NSTimeInterval maxAge;

- (BOOL)isExpire;
- (NSData *)ResponsePresentingData;
- (NSString *)cacheKey;

@end

/**
 *  HYResponseCache The Cache is file based, Memory cache used NSCache
 */

@interface HYResponseCache : NSObject
{
    
}

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 *  This is the NS_DESIGNATED_INITIALIZER, Please Do not Use init and new
 *
 *  @param path   The File Full Path
 *
 *  @return The   Cache Object
 */
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

/**
 *  The Cache File Full Path
 */
@property (nonatomic, copy, readonly) NSString *path;

/**
 *  limits are imprecise/not strict for memory cache
 */
@property (nonatomic, assign) NSUInteger totalCostLimit;

/**
 *  limits are imprecise/not strict for memory cache
 */
@property (nonatomic, assign)NSUInteger countLimit;

/**
 *  The MaxAge of the cache
    
    If A Object whitch comform the HYResponseCacheProtocal, then, the Object's maxAge could 
 
    cover this property
 
 */
@property (nonatomic, assign)NSTimeInterval maxAge;

/**
 *  Store the object in memcache and diskcache
 *
 *  @param object object
 *  @param key    key is NSString type
 */
- (void)storeObject:(id<HYResponseCacheProtocal>)object forKey:(NSString *)key;

/**
 *  Store the object in memcache
 *
 *  @param object object
 *  @param key    key is NSString type
 *  @param onDisk if Yes store in disk too
 */
- (void)storeObject:(id<HYResponseCacheProtocal>)object forKey:(NSString *)key onDisk:(BOOL)onDisk;

@end
