//
//  HYBaseViewController.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/17.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYViewControllerProtocal <NSObject>

@required

/**
 *  初始化View，子类必须实现，不实现会崩溃
 */
- (void)initView;

/**
 *  子类布局view的时候必须实现
 */
- (void)makeLayout;

@optional
/**
 *  配置导航栏和导航栏按钮按钮
 */
- (void)configNavigationBarItem;

/**
 *  如果controller想要关注source中model的变化，可以在这个方法中绑定
 */
- (void)bindViewModel;

/**
 *  在ViewDidLoad之前，需要初始化的内容，放在这里面
 */
- (void)initExtension;

@end

@interface HYBaseViewController : UIViewController<HYViewControllerProtocal>
{
    
}




@end
