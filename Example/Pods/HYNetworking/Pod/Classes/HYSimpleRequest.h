//
//  HYGeneralRequest.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/9.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseRequest.h"


@class HYSimpleRequest;

@interface HYSimpleRequest : HYBaseRequest<HYBaseRequestProtocal>
{
    
}

// 以下属性对应的是HYBaseRequestProtocal中的方法

@property (nonatomic, assign) HYRequestMethod simpleRequestMethod;
@property (nonatomic, copy) NSString *simpleApiUrl;
@property (nonatomic, copy) NSString *simpleIdentifier;
@property (nonatomic, copy) NSString *simpleFullUrl;
@property (nonatomic, strong) NSDictionary *simpleArgument;
@property (nonatomic, strong) NSDictionary *simpleHeaderValueDictionary;
@property (nonatomic, assign) NSTimeInterval simpleTimeoutInterval;
@property (nonatomic, copy) NSString *simpleDownloadPath;


@end
