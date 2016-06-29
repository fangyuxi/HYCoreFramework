//
//  SLRACDemoViewController.m
//  HYCoreFramework
//
//  Created by 58 on 3/31/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRACDemoViewController.h"
#import "SLRACDemoSource.h"
#import "HYBaseSetting.h"

@interface SLRACDemoViewController ()

@property (nonatomic, strong) SLRACDemoSource *tableViewSource;
@property (nonatomic, strong) UIBarButtonItem *submitButton;

@end

@implementation SLRACDemoViewController

@dynamic tableViewSource;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    self.navigationItem.rightBarButtonItem = self.submitButton;
    
    [self dragToRefreshWithoutAnimation];
}

- (void)initTableView
{
    self.tableView = [UITableView new];
    self.tableView.dataSource = self.tableViewSource;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)initTableViewSource
{
    self.tableViewSource = [[SLRACDemoSource alloc] initWithDelegate:self];
}

- (void)bindViewModel
{
    RAC(self, submitButton.enabled) = RACObserve(self, tableViewSource.canSubmit);
}
                                              
#pragma mark - Getters
                                              
- (UIBarButtonItem *)submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:NULL];
    }
    return _submitButton;
}

@end
