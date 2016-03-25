//
//  HYBaseViewController.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/17.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseViewController.h"

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
    [self doesNotRecognizeSelector:_cmd];
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

@end
