//
//  UIViewController+HYControllerCatetory.m
//  Pods
//
//  Created by fangyuxi on 16/3/31.
//
//

#import "UIViewController+HYControllerCatetory.h"
#import <objc/runtime.h>

@interface UIViewController ()
@property (nonatomic, strong, readwrite) UIView<HYEmptySetViewProtocol> *emptyView;
@property (nonatomic, assign) BOOL canDisplayEmptyView;
@end

@implementation UIViewController(HYControllerCatetory)

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

#pragma mark getter setter

- (UIView<HYEmptySetViewProtocol> *)emptyView
{
    return objc_getAssociatedObject(self, @selector(emptyView));
}

- (void)setEmptyView:(UIView<HYEmptySetViewProtocol> *)emptyView
{
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)canDisplayEmptyView
{
    return [objc_getAssociatedObject(self, @selector(canDisplayEmptyView)) boolValue];
}

- (void)setCanDisplayEmptyView:(BOOL)canDisplayEmptyView
{
    objc_setAssociatedObject(self, @selector(emptyView), @(canDisplayEmptyView), OBJC_ASSOCIATION_ASSIGN);
}


@end
