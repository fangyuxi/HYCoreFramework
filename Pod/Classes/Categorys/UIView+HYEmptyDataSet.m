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
    if ([self hy_canDisplay] && [self hy_itemsCount] == 0) {
        
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
        
        if (self.hy_emptyDataSetSource && [self.hy_emptyDataSetSource respondsToSelector:@selector(hy_verticalOffsetForEmptyDataSet:)]) {
            centerYConstraint.constant = [self.hy_emptyDataSetSource hy_verticalOffsetForEmptyDataSet:self];
        }
        
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
    
    // We add method sizzling for injecting -dzn_reloadData implementation to the native -reloadData implementation
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }

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

- (NSInteger)hy_itemsCount
{
    NSInteger items = 0;
    
    // UIScollView doesn't respond to 'dataSource' so let's exit
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}

#pragma mark - Setters

- (void)setEmptyDataSetContainerView:(UIView *)emptyDataSetContainerView
{
    objc_setAssociatedObject(self, @selector(emptyDataSetContainerView), emptyDataSetContainerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const HYSwizzleInfoPointerKey = @"pointer";
static NSString *const HYSwizzleInfoOwnerKey = @"owner";
static NSString *const HYSwizzleInfoSelectorKey = @"selector";

// Based on Bryce Buchanan's swizzling technique http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
// And Juzzin's ideas https://github.com/juzzin/JUSEmptyViewController

void hy_original_implementation(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    NSString *key = hy_implementationKey(self, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:HYSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self reloadEmptyDataSet];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *hy_implementationKey(id target, SEL selector)
{
    if (!target || !selector) {
        return nil;
    }
    
    Class baseClass;
    if ([target isKindOfClass:[UITableView class]]) baseClass = [UITableView class];
    else if ([target isKindOfClass:[UICollectionView class]]) baseClass = [UICollectionView class];
    else if ([target isKindOfClass:[UIScrollView class]]) baseClass = [UIScrollView class];
    else return nil;
    
    NSString *className = NSStringFromClass([baseClass class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

- (void)swizzleIfPossible:(SEL)selector
{
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:HYSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:HYSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    NSString *key = hy_implementationKey(self, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:HYSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod([self class], selector);
    IMP dzn_newImplementation = method_setImplementation(method, (IMP)hy_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{HYSwizzleInfoOwnerKey: [self class],
                                   HYSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   HYSwizzleInfoPointerKey: [NSValue valueWithPointer:dzn_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

@end
