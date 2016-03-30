//
//  HYCellModel.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HYBaseModel.h"

extern const CGFloat HYBaseCellNoFrameHeightWhenUseAutoLayout;

@interface HYBaseCellModel : HYBaseModel
{
    
}

@property (nonatomic, copy) NSString *reuseIdentifier;

/**
 *  默认为 HYBaseCellNoFrameHeightWhenUseAutoLayout
 
    如果返回值不是 HYBaseCellNoFrameHeightWhenUseAutoLayout，
 
    那么将对这种类型的cell 关闭AutoLyout的self-sizing，使用frame布局
 
 */
@property (nonatomic, assign)CGFloat cellHeight;

/**
 *
    如果不使用AutoLyout
    可以在这个方法中计算cell中各个元素的frame
 
 */
- (void)calculateCellElementFrame;


@end
