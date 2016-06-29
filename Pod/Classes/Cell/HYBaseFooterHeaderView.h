//
//  HYBaseFooterHeaderView.h
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import <Foundation/Foundation.h>
#import "HYBaseFooterHeaderModel.h"

//TableView中SectionHeader和Footer的基类View 本类注释同HYBaseCell 请参见HYBaseCell

@protocol HYFooterHeaderToControllerActionProtocol <NSObject>
@optional

- (void)actionFromFooterHeader:(UIView *)view
          withEventTag:(NSString *)tag
   withParameterObject:(id)object;

@end

/**
 *  UITableView Footer和Header的基类
 */
@interface HYBaseFooterHeaderView : UITableViewHeaderFooterView
{
    
}


@property (nonatomic, strong) HYBaseFooterHeaderModel *footerHeaderModel;


- (void) updateFooterHeader;
- (void) resetFooterHeader;
- (void) reload;
- (void) cancel;

- (void)bindFooterHeaderModelIfNeeded;

- (void)startAnimationWithDelay:(CGFloat)delayTime;

@property (nonatomic, weak) id<HYFooterHeaderToControllerActionProtocol> actionDelegate;

@property (nonatomic, assign) HYCustomFooterHeaderPosition position;

@end
