//
//  HYBaseCell.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class HYBaseCellModel;

/** 自定义cell类型 **/

typedef NS_ENUM(NSInteger, HYCustomCellType)
{
    HYCustomCellTypeDefault = 0,
    HYCustomCellTypePlainTop,
    HYCustomCellTypePlainMiddle,
    HYCustomCellTypePlainBottom,
    HYCustomCellTypePlainSingle,
    
    HYCustomCellTypeGroupTop = HYCustomCellTypePlainTop,
    HYCustomCellTypeGroupMiddle = HYCustomCellTypePlainMiddle,
    HYCustomCellTypeGroupBottom = HYCustomCellTypePlainBottom,
    HYCustomCellTypeGroupSingle = HYCustomCellTypePlainSingle,
};

#pragma mark HYCellToControllerActionProtocal
/** 从cell到controller的各种操作统一接口 **/
@protocol HYCellToControllerActionProtocal <NSObject>
@optional

- (void)ActionFromView:(UIView *)view
          withEventTag:(NSString *)tag
   withParameterObject:(id)object;

@end

@interface HYBaseCell : UITableViewCell
{
    
}


@property (nonatomic, strong) HYBaseCellModel *cellModel;

- (void) updateCell;
- (void) resetCell;
- (void) reload;
- (void) cancel;

//updateCell方法内部会调用 bindCellModelIfNeeded 如果需要绑定CellModel和Cell，那么可以在这个方法里里面执行
- (void)bindCellModelIfNeeded;

//动画
- (void)startAnimationWithDelay:(CGFloat)delayTime;

@property (nonatomic, weak) id<HYCellToControllerActionProtocal> actionDelegate;
@property (nonatomic, assign) HYCustomCellType bgType;



@end
