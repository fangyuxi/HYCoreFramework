//
//  SLRACDemoViewController.m
//  HYCoreFramework
//
//  Created by 58 on 3/31/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRACDemoViewController.h"
#import "SLRACDemoSource.h"

@interface SLRACDemoViewController ()

@property (nonatomic, strong) SLRACDemoSource *tableViewSource;

@end

@implementation SLRACDemoViewController

@dynamic tableViewSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    [self dragToRefreshWithoutAnimation];
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.tableView.backgroundColor = [UIColor greenColor];
    self.tableView.fd_debugLogEnabled = YES;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)initTableViewSource
{
    self.tableViewSource = [[SLRACDemoSource alloc] initWithDelegate:self];
    self.tableView.dataSource = self.tableViewSource;
}

@end
