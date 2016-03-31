//
//  HYBaseListViewController.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYBaseTableViewSource.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HYViewControllerProtocol.h"
#import "UIViewController+HYControllerCatetory.h"

@class MJRefreshHeader;
@class MJRefreshFooter;

@interface HYBaseListViewController : UIViewController<HYBaseTableViewSourceDelegate,
                                                        UITableViewDelegate,
                                                        HYViewControllerProtocol>
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
 
    基类会先调用initTableView 再调用initTableViewSource 再调用bindViewModel
 
    调用顺序
    ViewDidLoad
        initView
            initTableView
            initTableViewSource
        configHeaderFooterAppearance
 */
- (void)initTableView;
- (void)initTableViewSource;

/**
 *  配置Header和Footer的样式
 */
- (void)configHeaderFooterAppearance;


#pragma mark default empty view for list style controller
/**
 *  对于列表类型的控制器，默认有三种情况下的emptyDataSetView
 */
@property (nonatomic, strong, readwrite) UIView<HYEmptySetViewProtocol> *emptyDataSetRefreshView;
@property (nonatomic, strong, readwrite) UIView<HYEmptySetViewProtocol> *emptyDataSetNoContentView;
@property (nonatomic, strong, readwrite) UIView<HYEmptySetViewProtocol> *emptyDataSetErrorView;

/**
 *  对于列表类型的控制器，默认内置了三种类型的空页面提示
 *
 *  这三个方法中默认实现了各个空页面提示可以显示的条件
 
    子类如果对默认的不满意，可以重写
 
    比如 shouldShowEmptyDataSetContentView 就是当
 
    self.cellModels的count为0时才可以显示，那么子类可以
 
    改成当count == 1的时候才显示 等。
 
 *  @return BOOL
 */
- (BOOL)shouldShowEmptyDataSetRefreshView;
- (BOOL)shouldShowEmptyDataSetContentView;
- (BOOL)shouldShowEmptyDataSetErrorView;

@end
