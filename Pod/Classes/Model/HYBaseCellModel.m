//
//  HYCellModel.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseCellModel.h"

const CGFloat HYBaseCellDefaultHeightWhenUseAutoLayout = -1.0f;

@implementation HYBaseCellModel


- (CGFloat)cellHeight
{
    return HYBaseCellDefaultHeightWhenUseAutoLayout;
}

- (void)dicMapModelFinish
{
    if (self.cellHeight != HYBaseCellDefaultHeightWhenUseAutoLayout)
    {
        [self calculateCellElementFrame];
    }
}

- (void)calculateCellElementFrame
{
    [self doesNotRecognizeSelector:_cmd];
}

@end
