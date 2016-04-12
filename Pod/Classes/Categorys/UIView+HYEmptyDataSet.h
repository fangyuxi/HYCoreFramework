//
//  UIView+HYEmptyDataSet.h
//  HYEmptyDataSet
//
//  Created by 58 on 3/28/16.
//  Copyright © 2016 Huang Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HYEmptyDataSetSource;
@protocol HYEmptyDataSetDelegate;


@interface UIView (HYEmptyDataSet)
@property (nonatomic, weak) id <HYEmptyDataSetSource> hy_emptyDataSetSource;
@property (nonatomic, weak) id <HYEmptyDataSetDelegate> hy_emptyDataSetDelegate;

/// If the class is UITableView or UIColloctionView, you don't need to call this method manually, just call `reloadData` method. Otherwise, you should call this method by yourself.
- (void)reloadEmptyDataSet;
@end


@protocol HYEmptyDataSetSource <NSObject>
@required
- (UIView *)hy_customViewForEmptyDataSet:(UIView *)view;
@end


@protocol HYEmptyDataSetDelegate <NSObject>
@optional
- (BOOL)hy_emptyDataSetCanDisplay:(UIView *)view;
- (void)hy_emptyDataSetWillAppear:(UIView *)view;
- (void)hy_emptyDataSetDidAppear:(UIView *)view;
- (void)hy_emptyDataSetWillDisappear:(UIView *)view;
- (void)hy_emptyDataSetDidDisappear:(UIView *)view;
@end
