//
//  HYEmptyDataSetStyle.m
//  Pods
//
//  Created by fangyuxi on 16/3/26.
//
//

#import "HYEmptyDataSetStyle.h"

@implementation HYEmptyDataSetViewStyleObject

@synthesize showType = _showType;
@synthesize verticalOffset = _verticalOffset;
@synthesize emptyDataSetActions = _emptyDataSetActions;

- (UIView *)hy_customViewForEmptyDataSet:(UIView *)view
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.verticalOffset;
}

@end