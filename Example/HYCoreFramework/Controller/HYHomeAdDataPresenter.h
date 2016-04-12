//
//  HYHomeAdDataPresenter.h
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/27.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYCoreFramework.h"

/**
 *  首页广告
 */
@interface HYHomeAdDataPresenter : NSObject<HYDataPresenterProtocol>

- (id)dataPresenterWithSourceData:(id)sourceData businessName:(NSString *)name;

@end
