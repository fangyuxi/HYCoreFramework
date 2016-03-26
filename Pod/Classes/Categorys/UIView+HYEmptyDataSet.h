//
//  UIView+HYEmptyDataSet.h
//  Pods
//
//  Created by fangyuxi on 16/3/27.
//
//

#import <Foundation/Foundation.h>

@protocol HYEmptyDataSetDataSource <NSObject>

@end

@protocol HYEmptyDataSetDelegate <NSObject>

@end

/**
 *  由于 UIScrollView+EmptyDataSet 仅仅考虑到了TableView和CellectionView
    的情况，但是我们业务中也需要在没有这两个View的情况下，也显示相同的空内容加载
    等，所以创建了一个基于UIView的分类解决这个问题
 */

@interface UIView(HYEmptyDataSet)

@end
