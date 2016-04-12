//
//  HYProgressHUD.h
//  HUDTest
//
//  Created by 58 on 3/30/16.
//  Copyright © 2016 Huang Wei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@interface HYProgressHUD : NSObject
/// HUD全局配置，只执行一次
+ (void)configure:(NSTimeInterval)duration;
+ (void)showToast:(NSString *)text atView:(UIView *)view;
+ (void)showToast:(NSString *)text atView:(UIView *)view withCompletionBlock:(void(^)(void))completion;
+ (void)showLoading:(NSString *)text atView:(UIView *)view;
+ (void)showProgress:(CGFloat)progress text:(NSString *)text atView:(UIView *)view;
+ (void)hideAllHUDsForView:(UIView *)view;
@end
