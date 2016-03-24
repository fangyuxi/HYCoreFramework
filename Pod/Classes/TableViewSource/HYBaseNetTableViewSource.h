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

@interface HYBaseNetTableViewSource : HYBaseTableViewSource<HYDataPresenterProtocal>
{
    
}


- (NSString *)apiURL;
- (NSDictionary *)requestParamDic;

@end
