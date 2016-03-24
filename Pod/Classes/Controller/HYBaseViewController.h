//
//  HYBaseViewController.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/17.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBaseViewController : UIViewController
{
    
}

//如果controller想要关注source中model的变化，可以在这个方法中绑定
- (void)bindViewModel;

@end
