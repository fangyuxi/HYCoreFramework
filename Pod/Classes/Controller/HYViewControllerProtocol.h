//
//  HYViewControllerProtocal.h
//  testHooker
//
//  Created by fangyuxi on 16/3/31.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#ifndef HYViewControllerProtocal_h
#define HYViewControllerProtocal_h

/**
 *               调用顺序
         ViewDidLoad
            initView
            configNavigationBarItem
            makeLayout
            bindViewModel
 
 */
@protocol HYViewControllerProtocol <NSObject>

@required

/**
 *  初始化View，子类必须实现，不实现会崩溃
 */
- (void)initView;

@optional

/**
 *  子类布局view的时候
 */
- (void)makeLayout;

/**
 *  配置导航栏和导航栏按钮按钮
 */
- (void)configNavigationBarItem;

/**
 *  如果controller想要关注source中model的变化，可以在这个方法中绑定
 */
- (void)bindViewModel;

@end


#endif /* HYViewControllerProtocal_h */
