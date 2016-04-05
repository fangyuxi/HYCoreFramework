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

- (instancetype)initWithDictionary:(id)dic
{
    self = [super initWithDictionary:dic];
    if (self)
    {
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.cellHeight = HYBaseCellNoFrameHeightWhenUseAutoLayout;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.cellHeight = HYBaseCellNoFrameHeightWhenUseAutoLayout;
    }
    return self;
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
    [self dicMapModelFinish];
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
