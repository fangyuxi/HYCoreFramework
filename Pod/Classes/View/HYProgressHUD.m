//
//  HYProgressHUD.m
//  HUDTest
//
//  Created by 58 on 3/30/16.
//  Copyright © 2016 Huang Wei. All rights reserved.
//

#import "HYProgressHUD.h"
#import "MBProgressHUD.h"

@interface HYProgressHUD ()
@property (nonatomic, assign) NSTimeInterval duration;
@end


@implementation HYProgressHUD
static HYProgressHUD *_instance = nil;

+ (void)configure:(NSTimeInterval)duration
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HYProgressHUD *manager = [self sharedInstance];
        manager.duration = duration;
    });
}

+ (HYProgressHUD *)sharedInstance
{
    if (!_instance) {
        _instance = [[HYProgressHUD alloc] init];
        // 以下是默认值
        _instance.duration = 2;
    }
    return _instance;
}

+ (void)showToast:(NSString *)text atView:(UIView *)view
{
    [self showToast:text atView:view withCompletionBlock:nil];
}

+ (void)showToast:(NSString *)text atView:(UIView *)view withCompletionBlock:(void(^)(void))completion
{
    if (!view) return;
    [self hideAllHUDsForView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.completionBlock = completion;
    [hud hide:YES afterDelay:[self sharedInstance].duration];
}

+ (void)showLoading:(NSString *)text atView:(UIView *)view
{
    if (!view) return;
    [self hideAllHUDsForView:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
}

+ (void)showProgress:(CGFloat)progress text:(NSString *)text atView:(UIView *)view
{
    if (!view) return;
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = text;
    hud.progress = progress;
}

+ (void)hideAllHUDsForView:(UIView *)view;
{
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end
