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

#pragma mark HYCellToControllerActionProtocal

/**
 *  从cell到controller的各种操作统一接口
 
    比如Cell中有一个button，需要发送网络请求，那么代码如下：
    button.action = ^(){
 
 
    [self.actionDelegate ActionFromView:self withEventTag:yourtag withParameterObject:cellModel];
 
    actionDelegate是从tableviewsource中传到cell中的实现了此协议的controller对象
 };
 */
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

/**
 *  更新Cell 在次方法中做cellModel中的属性赋值给Cell中的UI元素操作
    一般不要在这个方法中做NSString, NSDate等格式化等操作，统一放到
    cellModel中操作，这个方法中只赋值，可以在这个方法中判断CellType，
    来根据不同的Type显示不同的界面元素
 */
- (void) updateCell;
/**
 *  重置Cell 因为cell会重用，那么在此方法中还原这个cell中的数据元素 比如 self.iconView.image = nil;
    对于状态的还原，官方推荐在- (void)prepareForReuse中处理,比如背景色，点击效果还原等
 */
- (void) resetCell;
- (void) reload;
- (void) cancel;

/**
 *  updateCell方法内部会调用 bindCellModelIfNeeded
    如果需要绑定CellModel和Cell，那么可以在这个方法里里面执行
 */
- (void)bindCellModelIfNeeded;

/**
 *  在controller中的tableviewdelegate的willdisplaycell中会调用cell的这个方法
    实现这个方法，在cell刚显示的时候，会出现动画，delayTime为延时
 *
 *  @param delayTime 延时
 */
- (void)startAnimationWithDelay:(CGFloat)delayTime;

/**
 *  见 上面 HYCellToControllerActionProtocal 协议
 */
@property (nonatomic, weak) id<HYCellToControllerActionProtocal> actionDelegate;
@property (nonatomic, assign) HYCustomCellPosition bgType;



@end
