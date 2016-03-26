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

@end







/**
 *  带有列表样式的控制器的Style对象基类，实现了HYEmptyDataSetStyleProtocal
    
    根据不同的ShowType，在HYEmptyDataSetStyleProtocal回调方法中返回不同的View
*/
@interface HYEmptyDataSetInScrollViewStyleObject : NSObject<HYEmptyDataSetStyleProtocal,
                                                                DZNEmptyDataSetSource>
{
    
}

@end

/**
 *  由于 UIScrollView+EmptyDataSet 仅仅考虑到了TableView和CellectionView
    的情况，但是我们业务中也需要在没有这两个View的情况下，也显示相同的空内容加载
    等，所以创建了一个基于UIView的分类解决这个问题
 
    等HYEmptyDataSet完成的时候，这两个类就可以合体了，因为对上层业务接口相同，所以上层不用
    基本不用改代码
 */

@interface HYEmptyDataSetInCommonViewStyleObject : NSObject<HYEmptyDataSetStyleProtocal,
                                                                HYEmptyDataSetDataSource>

@end
