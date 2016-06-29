//
//  SLViewControllerHooker.m
//  testHooker
//
//  Created by fangyuxi on 16/3/31.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "SLViewControllerHooker.h"
#import "Aspects/Aspects.h"

@implementation SLViewControllerHooker

- (void)initOtherHooker
{
//    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
//        NSLog(@"SLDidLoad Hooker again");
//    } error:NULL];
//    
//    [UIViewController aspect_hookSelector:@selector(loadView) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
//        NSLog(@"SLLoadView Hooker");
//    } error:NULL];
}

- (void)controllerViewDidLoad:(UIViewController *)controller
{
    [super controllerViewDidLoad:controller];
}

- (void)viewWillAppear:(BOOL)animated theViewController:(UIViewController *)viewController
{
    
}



@end
