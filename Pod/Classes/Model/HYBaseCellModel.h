//
//  HYCellModel.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HYBaseModel.h"

extern const CGFloat HYBaseCellDefaultHeightWhenUseAutoLayout;

@interface HYBaseCellModel : HYBaseModel
{
    
}

@property (nonatomic, copy) NSString *reuseIdentifier;

@end
