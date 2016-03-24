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
    
}

- (void)makeLayout
{
    
}

- (void)initTableViewSource
{
    HYHomeTableViewSource *source = [[HYHomeTableViewSource alloc] initWithDelegate:self];
    [source refreshSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
