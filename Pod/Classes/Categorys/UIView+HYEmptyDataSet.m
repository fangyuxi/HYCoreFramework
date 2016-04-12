//
//  UIView+HYEmptyDataSet.m
//  HYEmptyDataSet
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 Huang Wei. All rights reserved.
//

#import "UIView+HYEmptyDataSet.h"
#import <objc/runtime.h>


@interface UIView ()
@property (nonatomic, strong) UIView *emptyDataSetContainerView;
@end

@implementation UIView (HYEmptyDataSet)

#pragma mark - Getters (Public)

- (id<HYEmptyDataSetSource>)hy_emptyDataSetSource
{
    return objc_getAssociatedObject(self, @selector(hy_emptyDataSetSource));
}

- (id<HYEmptyDataSetDelegate>)hy_emptyDataSetDelegate
{
    return objc_getAssociatedObject(self, @selector(hy_emptyDataSetDelegate));
}


#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet
{
    if ([self hy_canDisplay]) {
        
        [self hy_willAppear];
        
        UIView *containerView = self.emptyDataSetContainerView;
        
        if (!containerView.superview) {
            if (self.subviews.count > 1) {
                [self insertSubview:containerView atIndex:0];
            } else {
                [self addSubview:containerView];
            }
        }
        
        containerView.frame = containerView.superview.bounds;
        

        [containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [containerView removeConstraints:containerView.constraints];

        
        UIView *emptyView = nil;
        if (self.hy_emptyDataSetSource && [self.hy_emptyDataSetSource respondsToSelector:@selector(hy_customViewForEmptyDataSet:)]) {
            emptyView = [self.hy_emptyDataSetSource hy_customViewForEmptyDataSet:self];
            emptyView.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        NSAssert(emptyView != nil, @"CustomView must not be nill!");

        [containerView addSubview:emptyView];
        NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:emptyView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeCenterX
                                                                            multiplier:1.0
                                                                              constant:0.0];
        NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:emptyView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:containerView
                                                                             attribute:NSLayoutAttributeCenterY
                                                                            multiplier:1.0
                                                                              constant:0.0];
        [containerView addConstraint:centerXConstraint];
        [containerView addConstraint:centerYConstraint];
    
        [UIView performWithoutAnimation:^{
            [containerView layoutIfNeeded];
        }];
        
        [self hy_didAppear];
    } else {
        [self hy_invalidate];
    }
}

- (void)hy_invalidate
{
    [self hy_willDisappear];
    [self.emptyDataSetContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.emptyDataSetContainerView removeFromSuperview];
    [self.emptyDataSetContainerView removeConstraints:self.emptyDataSetContainerView.constraints];
    [self setEmptyDataSetContainerView:nil];
    [self hy_didDisappear];
}

#pragma mark - Setters (Public)

- (void)setHy_emptyDataSetSource:(id<HYEmptyDataSetSource>)hy_emptyDataSetSource
{
    if (!hy_emptyDataSetSource) {
        [self hy_invalidate];
    }
    objc_setAssociatedObject(self, @selector(hy_emptyDataSetSource), hy_emptyDataSetSource, OBJC_ASSOCIATION_ASSIGN);
}

- (void)setHy_emptyDataSetDelegate:(id<HYEmptyDataSetDelegate>)hy_emptyDataSetDelegate
{
    if (!hy_emptyDataSetDelegate) {
        [self hy_invalidate];
    }
    objc_setAssociatedObject(self, @selector(hy_emptyDataSetDelegate), hy_emptyDataSetDelegate, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Delegate Getters & Events (Private)

- (BOOL)hy_canDisplay
{
    if (self.hy_emptyDataSetDelegate && [self.hy_emptyDataSetDelegate respondsToSelector:@selector(hy_emptyDataSetCanDisplay:)]) {
        return [self.hy_emptyDataSetDelegate hy_emptyDataSetCanDisplay:self];
    }
    return YES;
}

- (void)hy_willAppear
{
    if (self.hy_emptyDataSetDelegate && [self.hy_emptyDataSetDelegate respondsToSelector:@selector(hy_emptyDataSetWillAppear:)]) {
        [self.hy_emptyDataSetDelegate hy_emptyDataSetWillAppear:self];
    }
}

- (void)hy_didAppear
{
    if (self.hy_emptyDataSetDelegate && [self.hy_emptyDataSetDelegate respondsToSelector:@selector(hy_emptyDataSetDidAppear:)]) {
        [self.hy_emptyDataSetDelegate hy_emptyDataSetDidAppear:self];
    }
}

- (void)hy_willDisappear
{
    if (self.hy_emptyDataSetDelegate && [self.hy_emptyDataSetDelegate respondsToSelector:@selector(hy_emptyDataSetWillDisappear:)]) {
        [self.hy_emptyDataSetDelegate hy_emptyDataSetWillDisappear:self];
    }
}

- (void)hy_didDisappear
{
    if (self.hy_emptyDataSetDelegate && [self.hy_emptyDataSetDelegate respondsToSelector:@selector(hy_emptyDataSetDidDisappear:)]) {
        [self.hy_emptyDataSetDelegate hy_emptyDataSetDidDisappear:self];
    }
}

#pragma mark - Getters

- (UIView *)emptyDataSetContainerView
{
    UIView *view = objc_getAssociatedObject(self, @selector(emptyDataSetContainerView));
    if (!view) {
        view = [UIView new];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self setEmptyDataSetContainerView:view];
    }
    return view;
}

#pragma mark - Setters

- (void)setEmptyDataSetContainerView:(UIView *)emptyDataSetContainerView
{
    objc_setAssociatedObject(self, @selector(emptyDataSetContainerView), emptyDataSetContainerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
