//
//  HYBaseListViewController.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseViewController.h"
#import "HYBaseTableViewSource.h"
#import "UITableView+FDTemplateLayoutCell.h"

@class MJRefreshHeader;
@class MJRefreshFooter;

@interface HYBaseListViewController : HYBaseViewController<UITableViewDelegate>
{
    
}

#pragma mark Header & Footer

/**
 *  是否需要下拉刷新 default yes
 */
@property (nonatomic, assign) BOOL needHeader;

/**
 *  下拉刷新的 Header的Class 见 MJRefresh中的各种Header，找到自己需要的
    默认是 MJRefreshStateHeader
 */
@property (nonatomic, strong) Class headerClass;
/**
 *  子类中可以根据 headerClass 去配置refreshHeader
 */
@property (nonatomic, strong, readonly) MJRefreshHeader *refreshHeader;

/**
 *  是否需要上拉加载更多 default yes
 */
@property (nonatomic, assign) BOOL needFooter;
@property (nonatomic, strong) Class footerClass;
@property (nonatomic, strong, readonly) MJRefreshFooter *refreshFooter;

#pragma mark tableView & tableViewSource

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HYBaseTableViewSource *tableViewSource;


#pragma mark refresh action

/**
 *  下拉刷新，带有动画
 */
- (void)dragToRefresh;
/**
 *  下拉刷新，没有动画
 */
- (void)dragToRefreshWithoutAnimation;

#pragma mark creation

/**
 *  在这两个方法中创建TableView和TableViewSource
    如果不实现，会崩溃
 */
- (void)initTableView;
- (void)initTableViewSource;

/**
 *  配置Header和Footer的样式
 */
- (void)configHeaderFooterAppearance;
@end
