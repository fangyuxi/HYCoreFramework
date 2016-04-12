//
//  HYRootViewController.m
//  HYCoreFramework
//
//  Created by 58 on 3/30/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRootViewController.h"
#import "SLRACDemoViewController.h"

@interface SLRootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation SLRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"HYCoreFramework Demos";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[SLRootViewController new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[SLRACDemoViewController new] animated:YES];
    }
}


#pragma mark - Getters

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[
                        @"EmptyDataSet demo",
                        @"RAC demo"
                        ];
    }
    return _dataSource;
}

@end
