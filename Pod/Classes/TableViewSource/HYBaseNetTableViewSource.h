//
//  HYBaseNetTableViewSource.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseTableViewSource.h"
#import "HYDataPresenterProtocal.h"
#import "HYNetworking.h"

@interface HYBaseNetTableViewSource : HYBaseTableViewSource<HYDataPresenterProtocal, HYRequestValidator>
{
    
}

//@property (nonatomic, strong, readonly) HYBaseRequest *request;

/**
 *  请求的路径 子类覆盖
 *
 *  @return 类似 @"/api/user?method=skills.list.home"
 */
- (NSString *)apiURL;

/**
 *  请求的参数 子类覆盖
 *
 *  @return  返回字典类型，其中pageNum已经在基类里面传好
 */
- (NSDictionary *)requestParamDic;

/**
 *  HYRequestValidator 可以用来验证服务端返回的数据类型 子类覆盖
 *
 *  @return 字典或者数组 类似 @{@"result": @{@"data":@{@"appParamVersionVO":@{@"cateVersion":[NSNumber class]}}}};
 */
- (id)jsonValidatorData;

@end
