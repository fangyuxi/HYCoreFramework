//
//  HYHomeTableViewSource.m
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/24.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYHomeTableViewSource.h"

@implementation HYHomeTableViewSource


- (NSString *)apiURL
{
    return @"/api/user?method=skills.list.home";
}

- (NSDictionary *)requestParamDic
{
    return nil;
}

- (void)refreshFinishWithData:(id)data
{
    
}

- (void)loadMoreFinishWithData:(id)data
{
    
}

@end
