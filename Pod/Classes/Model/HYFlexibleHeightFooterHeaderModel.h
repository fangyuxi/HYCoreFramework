//
//  HYFlexibleHeightFooterHeaderModel.h
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import <HYCoreFramework/HYCoreFramework.h>

/** 高度可以变化的SectionHeader和SectionFooter Model 一般用来占位或者调整section之间的距离用 **/

@interface HYFlexibleHeightFooterHeaderModel : HYBaseFooterHeaderModel

@property (nonatomic, assign)CGFloat flexibleHeight;
@property (nonatomic, strong)UIColor *backgroundColor;

@end
