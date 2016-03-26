//
//  HYBaseCell.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseCell.h"

@implementation HYBaseCell

#pragma mark cell state

- (void)updateCell
{
    [self bindCellModelIfNeeded];
}

- (void)resetCell
{
    
}

- (void)reload
{
    
}

- (void)cancel
{
    
}

#pragma mark bind CellModel

- (void)bindCellModelIfNeeded
{
    //做绑定
}

#pragma mark animation

- (void)startAnimationWithDelay:(CGFloat)delayTime
{
    
}

#pragma mark cell position

+ (HYCustomCellPosition) groupStyleWithIndex:(NSInteger)index
                                       Count:(NSInteger)count
{
    if (count > 0)
    {
        if (count > 1)
        {
            if (index == 0)
            {
                return HYCustomCellPositionGroupTop;
            }
            if (index == count - 1)
            {
                return HYCustomCellPositionGroupBottom;
            }
            return HYCustomCellPositionGroupMiddle;
        }
        return HYCustomCellPositionGroupSingle;
    }
    return HYCustomCellPositionDefault;
}

+ (HYCustomCellPosition) plainStyleWithIndex:(NSInteger)index
                                       Count:(NSInteger)count
{
    if (count > 0)
    {
        if (count > 1)
        {
            if (index == 0)
            {
                return HYCustomCellPositionPlainTop;
            }
            if (index == count - 1)
            {
                return HYCustomCellPositionPlainBottom;
            }
            return HYCustomCellPositionPlainMiddle;
        }
        return HYCustomCellPositionPlainSingle;
    }
    return HYCustomCellPositionDefault;}


@end
