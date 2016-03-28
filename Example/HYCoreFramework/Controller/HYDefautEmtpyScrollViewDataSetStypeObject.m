//
//  HYDefautEmtpyScrollViewDataSetStypeObject.m
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/27.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYDefautEmtpyScrollViewDataSetStypeObject.h"
#import "Masonry.h"

@implementation HYDefautEmtpyScrollViewDataSetStypeObject

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.showType == HYEmptyDataSetStyleShowTypeRefresh)
    {
        return [self emptyDataSetRefreshView];
    }
    else if (self.showType == HYEmptyDataSetStyleShowTypeNoContent)
    {
        return [self emptyDataSetNoContentView];
    }
    else if (self.showType == HYEmptyDataSetStyleShowTypeError)
    {
        return [self emptyDataSetErrorView];
    }
    return nil;
}

- (UIView *)emptyDataSetRefreshView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor clearColor];
    UIView *secon = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    secon.backgroundColor = [UIColor yellowColor];
    [v addSubview:secon];
    
    [secon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.centerX.equalTo(v.mas_centerX);
        make.centerY.equalTo(v.mas_centerY);
    }];
    
    self.emptyDataSetActions(@"10181");
    return v;
}

- (UIView *)emptyDataSetNoContentView
{
    return nil;
}

- (UIView *)emptyDataSetErrorView
{
    return nil;
}

@end
