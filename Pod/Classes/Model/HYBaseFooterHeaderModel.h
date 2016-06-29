//
//  HYBaseFooterHeaderModel.h
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import <Foundation/Foundation.h>
#import "HYBaseModel.h"

/**
 
 *  footer header 的位置
 
 */

typedef NS_ENUM(NSInteger, HYCustomFooterHeaderPosition)
{
    a = 1
};

typedef NS_ENUM(NSInteger, HYFooterHeaderType)
{
    HYFooterHeaderTypeFooter = 1,
    HYFooterHeaderTypeHeader
};


extern const CGFloat HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout;

@interface HYBaseFooterHeaderModel : HYBaseModel

@property (nonatomic, copy, readonly) NSString *reuseIdentifier;

/**
 *  默认为 HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout
 
 如果返回值不是 HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout，
 
 那么将对这种类型的cell 关闭AutoLyout的self-sizing，使用frame布局
 
 */
@property (nonatomic, assign, readonly)CGFloat footerHeaderHeight;

/**
 *  footer header 的位置
 */
@property (nonatomic, assign)HYCustomFooterHeaderPosition position;

/**
 *  是footer还是header
 */
@property (nonatomic, assign)HYFooterHeaderType type;

/**
 *
 如果不使用AutoLyout
 可以在这个方法中计算cell中各个元素的frame
 如果使用initWithDic: 那么，当map属性完成之后，
 会自动调用这个方法，如果没有使用initWithDic:
 或者创建完毕之后有更改了属性，那么请手动调用
 这个方法用来更新frame
 
 */
- (void)calculateFooterHeaderElementFrame;

@end
