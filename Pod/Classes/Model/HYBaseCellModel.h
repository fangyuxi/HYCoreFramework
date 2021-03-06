//
//  HYCellModel.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import "HYBaseModel.h"

/**
 
 *  自定义cell类型
 
 */

typedef NS_ENUM(NSInteger, HYCustomCellPosition)
{
    HYCustomCellPositionDefault = 0,
    HYCustomCellPositionPlainTop,
    HYCustomCellPositionPlainMiddle,
    HYCustomCellPositionPlainBottom,
    HYCustomCellPositionPlainSingle,
    
    HYCustomCellPositionGroupTop = HYCustomCellPositionPlainTop,
    HYCustomCellPositionGroupMiddle = HYCustomCellPositionPlainMiddle,
    HYCustomCellPositionGroupBottom = HYCustomCellPositionPlainBottom,
    HYCustomCellPositionGroupSingle = HYCustomCellPositionPlainSingle,
};


extern const CGFloat HYBaseCellNoFrameHeightWhenUseAutoLayout;

@interface HYBaseCellModel : HYBaseModel
{
    
}

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

/**
 *  默认为 HYBaseCellNoFrameHeightWhenUseAutoLayout
 
    如果返回值不是 HYBaseCellNoFrameHeightWhenUseAutoLayout，
 
    那么将对这种类型的cell 关闭AutoLyout的self-sizing，使用frame布局
 
 */
@property (nonatomic, assign)CGFloat cellHeight;

@property (nonatomic, assign)HYCustomCellPosition position;

/**
 *
    如果不使用AutoLyout
    可以在这个方法中计算cell中各个元素的frame
    如果使用initWithDic: 那么，当map属性完成之后，
    会自动调用这个方法，如果没有使用initWithDic:
    或者创建完毕之后有更改了属性，那么请手动调用
    这个方法用来更新frame
 
 */
- (void)calculateCellElementFrame;


@end
