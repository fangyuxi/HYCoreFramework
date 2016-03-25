//
//  HYViewController.m
//  HYCoreFramework
//
//  Created by fangyuxi on 03/24/2016.
//  Copyright (c) 2016 fangyuxi. All rights reserved.
//

#import "HYViewController.h"
#import "HYHomeTableViewSource.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor redColor];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}

- (void)makeLayout
{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *maker)
     {
         maker.top.equalTo(self.view.mas_top);
         maker.left.equalTo(self.view.mas_left);
         maker.right.equalTo(self.view.mas_right);
         maker.bottom.equalTo(self.view.mas_bottom);
     }];
}

- (void)initTableViewSource
{
    HYHomeTableViewSource *source = [[HYHomeTableViewSource alloc] initWithDelegate:self];
    self.tableViewSource = source;
    [source refreshSource];
}

- (void)bindViewModel
{
    self.tableView.dataSource = self.tableViewSource;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
