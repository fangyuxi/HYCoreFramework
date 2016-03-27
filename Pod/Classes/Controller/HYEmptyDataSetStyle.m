//
//  HYEmptyDataSetStyle.m
//  Pods
//
//  Created by fangyuxi on 16/3/26.
//
//

#import "HYEmptyDataSetStyle.h"

@implementation HYEmptyDataSetInScrollViewStyleObject

@synthesize showType = _showType;
@synthesize verticalOffset = _verticalOffset;

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.verticalOffset;
}

@end

//@implementation HYEmptyDataSetInCommonViewStyleObject
//
//@synthesize showType = _showType;
//@synthesize verticalOffset = _verticalOffset;
//
//@end