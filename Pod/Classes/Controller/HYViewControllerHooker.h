//
//  HYViewControllerHooker.h
//  Pods
//
//  Created by fangyuxi on 16/3/31.
//
//

#import <UIKit/UIKit.h>

@interface HYViewControllerHooker : NSObject

+ (HYViewControllerHooker *)registe;

/**
 *  覆盖点：如果业务方需要配置Controller的一些样式，那么继承这个类，
 
    重载这个函数，然后hooker你需要的函数，使用aspect
 */
- (void)initOtherHooker;

/**
 *  已经被hook的method，子类可以覆盖执行
 
    !!!子类覆盖一定要调用super
 */
- (void)controllerViewDidLoad:(UIViewController *)controller;
- (void)viewWillAppear:(BOOL)animated theViewController:(UIViewController *)viewController;
- (void)viewDidAppear:(BOOL)animated theViewController:(UIViewController *)viewController;
- (void)viewWillDisappear:(BOOL)animated theViewController:(UIViewController *)viewController;
- (void)viewDidDisappear:(BOOL)animated theViewController:(UIViewController *)viewController;

@end
