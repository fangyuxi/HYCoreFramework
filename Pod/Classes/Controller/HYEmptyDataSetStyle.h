//
//  HYEmptyDataSetStyle.h
//  Pods
//
//  Created by fangyuxi on 16/3/26.
//
//

#import <Foundation/Foundation.h>
#import "UIScrollView+EmptyDataSet.h"

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

@interface HYEmptyDataSetStyle : NSObject
{
    
}



@end
