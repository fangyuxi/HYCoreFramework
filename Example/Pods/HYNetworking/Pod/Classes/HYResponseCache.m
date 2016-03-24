//
//  HYResponseCache.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/19.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYResponseCache.h"
#import "HYNetworking.h"

@implementation HYResponseCache{

    NSCache *_memoryCache;
    NSOperationQueue *_cacheDiskInQueue;
    NSOperationQueue *_cacheDiskOutQueue;
}

#pragma mark init

- (instancetype)init
{
    return [self initWithPath:nil];
}

- (instancetype)initWithPath:(NSString *)path
{
    if (path.length == 0 || ![self p_createDirectoryWithPath:_path])
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _path = [path copy];
        _memoryCache = [[NSCache alloc] init];
        _maxAge = KHYResponseCacheMaxAge;
        
        _cacheDiskInQueue = [[NSOperationQueue alloc] init];
        _cacheDiskOutQueue.maxConcurrentOperationCount = 1;
        _cacheDiskOutQueue = [[NSOperationQueue alloc] init];
        _cacheDiskOutQueue.maxConcurrentOperationCount = 1;
        
        return self;
    }
    return nil;
}

#pragma mark setter

- (void)setTotalCostLimit:(NSUInteger)totalCostLimit
{
    _totalCostLimit = totalCostLimit;
    _memoryCache.totalCostLimit = totalCostLimit;
}

- (void)setCountLimit:(NSUInteger)countLimit
{
    _countLimit = countLimit;
    _memoryCache.countLimit = countLimit;
}

#pragma mark store

- (void)storeObject:(id)object forKey:(NSString *)key
{
    if (!object || !key || ![key isKindOfClass:[NSString class]] || key.length == 0)
    {
        return;
    }
    
    [self storeObject:object forKey:key onDisk:YES];
}

- (void)storeObject:(id)object forKey:(NSString *)key onDisk:(BOOL)onDisk
{
    if (!object || !key || ![key isKindOfClass:[NSString class]] || key.length == 0)
    {
        return;
    }
    [_memoryCache setObject:object forKey:key];
    
    if (onDisk)
    {
        NSDictionary *param = @{@"object":object, @"key":key};
        
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
                                                                                selector:@selector(p_storeKeyWithDataToDisk:)
                                                                                  object:param];
        [_cacheDiskInQueue addOperation:operation];
    }
}

#pragma mark store private

- (void)p_storeKeyWithDataToDisk:(NSDictionary *)param
{
    id<HYResponseCacheProtocal> object = [param objectForKey:@"object"];
    NSString *key = [param objectForKey:@"key"];
    
    NSData *data = [object ResponsePresentingData];
    if (data)
    {
        [self p_fileWriteWithName:key data:data];
    }
}

#pragma mark file

- (BOOL)p_fileWriteWithName:(NSString *)filename data:(NSData *)data
{
    NSString *path = [self.path stringByAppendingPathComponent:filename];
    return [data writeToFile:path atomically:NO];
}

- (NSData *)p_fileReadWithName:(NSString *)filename
{
    NSString *path = [self.path stringByAppendingPathComponent:filename];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (BOOL)p_fileDeleteWithName:(NSString *)filename
{
    NSString *path = [self.path stringByAppendingPathComponent:filename];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}

- (BOOL)p_createDirectoryWithPath:(NSString *)path
{
    BOOL suc = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    return suc;
}


@end
