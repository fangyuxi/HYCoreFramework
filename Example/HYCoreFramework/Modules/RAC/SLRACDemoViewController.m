//
//  SLRACDemoViewController.m
//  HYCoreFramework
//
//  Created by 58 on 3/31/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRACDemoViewController.h"

@interface SLRACDemoViewController ()

@end

@implementation SLRACDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initTableView
{
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
}

- (void)initTableViewSource
{
    
}

@end
