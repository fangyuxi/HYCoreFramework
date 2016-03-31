//
//  UIViewController+HYControllerCatetory.h
//  Pods
//
//  Created by fangyuxi on 16/3/31.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYEmptySetViewProtocol.h"
#import "UIView+HYEmptyDataSet.h"
#import "HYViewControllerProtocol.h"


@interface UIViewController (HYControllerCatetory)<HYEmptyDataSetSource,
                                                   HYEmptyDataSetDelegate>


@property (nonatomic, strong, readonly) UIView<HYEmptySetViewProtocol> *emptyView;

- (void)showEmptyView:(UIView<HYEmptySetViewProtocol> *)emptyView;
- (void)hideEmptyView;

@end
