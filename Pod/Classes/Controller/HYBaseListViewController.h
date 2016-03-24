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

@property (nonatomic, assign) BOOL needHeader;     // default yes
@property (nonatomic, strong) Class headerClass; // default MJRefreshStateHeader
@property (nonatomic, strong, readonly) MJRefreshHeader *refreshHeader;

@property (nonatomic, assign) BOOL needFooter;     // default yes
@property (nonatomic, strong) Class footerClass; // default MJRefreshAutoStateFooter
@property (nonatomic, strong, readonly) MJRefreshFooter *refreshFooter;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)HYBaseTableViewSource *tableViewSource;

- (void)dragToRefresh;
- (void)dragToRefreshWithoutAnimation;

- (void)initTableView;
- (void)initTableViewSource;

@end
