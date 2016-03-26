//
//  HYCellModel.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseCellModel.h"

const CGFloat HYBaseCellNoFrameHeightWhenUseAutoLayout = -1.0f;

@interface HYBaseCellModel()

@end

@implementation HYBaseCellModel

- (void)initExtension
{
    self.reuseIdentifier = NSStringFromClass([self class]);
}


- (void)dicMapModelFinish
{
    [self calculateCellElementFrame];
}

- (void)calculateCellElementFrame
{
    self.cellHeight = HYBaseCellNoFrameHeightWhenUseAutoLayout;
}

+ (NSDictionary *)transferDic
{
    return nil;
}

@end
