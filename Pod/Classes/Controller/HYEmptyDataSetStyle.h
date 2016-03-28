//
//  HYEmptyDataSetStyle.h
//  Pods
//
//  Created by fangyuxi on 16/3/26.
//
//

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"
#import "UIView+HYEmptyDataSet.h"

typedef void(^HYEmptyDataSetActions)(NSString *events);

/**
 *  HYEmptyDataSetStyle 对象，显示的类型
 */
typedef NS_ENUM(NSInteger, HYEmptyDataSetStyleShowType)
{
    /**
     *  加载中，没有缓存，空页面的时候刷新
     */
    HYEmptyDataSetStyleShowTypeRefresh = 1,
    /**
     *  加载完毕，但是没有内容，没有缓存
     */
    HYEmptyDataSetStyleShowTypeNoContent,
    /**
     *  加载完毕，出现错误，没有缓存
     */
    HYEmptyDataSetStyleShowTypeError
};

/**
 *  所有style对象应该遵循这个协议，根据不同的ShowType，返回不同的View
 */
@protocol HYEmptyDataSetStyleProtocal <NSObject>

@required
@property (nonatomic, assign) HYEmptyDataSetStyleShowType showType;

@optional
@property (nonatomic, assign) CGFloat verticalOffset;
@property (nonatomic, copy) HYEmptyDataSetActions emptyDataSetActions;

- (UIView *)emptyDataSetRefreshView;
- (UIView *)emptyDataSetNoContentView;
- (UIView *)emptyDataSetErrorView;

@end


/**
 *  控制器的Style对象基类，实现了HYEmptyDataSetStyleProtocal
    
    根据不同的ShowType，在DZNEmptyDataSetSource回调方法中返回不同的View
*/
@interface HYEmptyDataSetInScrollViewStyleObject : NSObject<HYEmptyDataSetStyleProtocal,
                                                                DZNEmptyDataSetSource>
{
    
}

@end
