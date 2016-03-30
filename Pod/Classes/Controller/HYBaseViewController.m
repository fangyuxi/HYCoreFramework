//
//  HYBaseViewController.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/17.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseViewController ()

@property (nonatomic, strong, readwrite) UIView<HYEmptySetViewProtocol> *emptyView;
@property (nonatomic, assign) BOOL canDisplayEmptyView;

@end

@implementation HYBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self initExtension];
        return self;
    }
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self configNavigationBarItem];
    [self makeLayout];
    [self bindViewModel];
}

- (void)initView
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)makeLayout
{
    //[self doesNotRecognizeSelector:_cmd];
}

- (void)configNavigationBarItem
{
    
}

- (void)bindViewModel
{
    
}

- (void)initExtension
{
    
}

#pragma mark empty view

- (void)showEmptyView:(UIView<HYEmptySetViewProtocol> *)emptyView
{
    self.canDisplayEmptyView = YES;
    self.emptyView = emptyView;
    [self.view reloadEmptyDataSet];
}

- (void)hideEmptyView
{
    self.canDisplayEmptyView = NO;
    [self.view reloadEmptyDataSet];
    
    self.emptyView = nil;
}

#pragma mark HYEmptyDataSetDataSource

- (UIView *)hy_customViewForEmptyDataSet:(UIView *)view
{
    return self.emptyView;
}

#pragma mark HYEmptyDataSetDelegate

- (BOOL)hy_emptyDataSetCanDisplay:(UIView *)view
{
    return self.canDisplayEmptyView;
}

@end
