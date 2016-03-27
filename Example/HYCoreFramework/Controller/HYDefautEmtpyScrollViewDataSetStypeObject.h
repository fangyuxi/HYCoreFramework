//
//  HYDefautEmtpyScrollViewDataSetStypeObject.h
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/27.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYEmptyDataSetStyle.h"

/**
 *  默认的loading样式
 
    当没有缓存加载的时候：显示菊花
    当没有缓存，返回空内容的时候：一个空页面图片
    当没有缓存，返回错误内容的时候：一个图片，可点击继续加载
 */

@interface HYDefautEmtpyScrollViewDataSetStypeObject : HYEmptyDataSetInScrollViewStyleObject

@end
