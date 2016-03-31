//
//  HYViewControllerHooker.m
//  Pods
//
//  Created by fangyuxi on 16/3/31.
//
//

#import "HYViewControllerHooker.h"
#import "UIViewController+HYControllerCatetory.h"
#import "Aspects.h"

@implementation HYViewControllerHooker

+ (HYViewControllerHooker *)registe
{
    return [[[self class] alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self p_registeHookerMethod];
        [self initOtherHooker];
    }
    return self;
}

- (void)p_registeHookerMethod
{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        
        if ([[aspectInfo instance] conformsToProtocol:@protocol(HYViewControllerProtocol)])
        {
             [self controllerViewDidLoad:[aspectInfo instance]];
        }
       
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
        
        if ([[aspectInfo instance] conformsToProtocol:@protocol(HYViewControllerProtocol)])
        {
            [self viewWillAppear:animated theViewController:[aspectInfo instance]];
        }
        
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
        if ([[aspectInfo instance] conformsToProtocol:@protocol(HYViewControllerProtocol)])
        {
            [self viewDidAppear:animated theViewController:[aspectInfo instance]];
        }
        
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
        
        if ([[aspectInfo instance] conformsToProtocol:@protocol(HYViewControllerProtocol)])
        {
            [self viewWillDisappear:animated theViewController:[aspectInfo instance]];
        }
        
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewDidDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
        
        if ([[aspectInfo instance] conformsToProtocol:@protocol(HYViewControllerProtocol)])
        {
            [self viewDidDisappear:animated theViewController:[aspectInfo instance]];
        }
    } error:NULL];
}

- (void)initOtherHooker
{
    
}

#pragma mark hooder method

- (void)controllerViewDidLoad:(UIViewController *)controller
{
    [(UIViewController<HYViewControllerProtocol> *)controller initView];
    
    if ([controller respondsToSelector:@selector(configNavigationBarItem)])
    {
        [(UIViewController<HYViewControllerProtocol> *)controller configNavigationBarItem];
    }
    
    if ([controller respondsToSelector:@selector(makeLayout)])
    {
        [(UIViewController<HYViewControllerProtocol> *)controller makeLayout];
    }
    
    if ([controller respondsToSelector:@selector(bindViewModel)])
    {
        [(UIViewController<HYViewControllerProtocol> *)controller bindViewModel];
    }
}

- (void)viewWillAppear:(BOOL)animated theViewController:(UIViewController *)viewController
{
    
}

- (void)viewDidAppear:(BOOL)animated theViewController:(UIViewController *)viewController
{
    
}

- (void)viewWillDisappear:(BOOL)animated theViewController:(UIViewController *)viewController
{
    
}

- (void)viewDidDisappear:(BOOL)animated theViewController:(UIViewController *)viewController
{
    
}

@end




