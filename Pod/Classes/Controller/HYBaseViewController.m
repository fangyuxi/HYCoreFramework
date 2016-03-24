//
//  HYBaseViewController.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/17.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseViewController.h"

@implementation HYBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self makeLayout];
    [self bindViewModel];
}

- (void)initView
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)makeLayout
{
    [self doesNotRecognizeSelector:_cmd];
}

- (void)configNavigationBarItem
{
    
}

- (void)bindViewModel
{
    
}

@end
