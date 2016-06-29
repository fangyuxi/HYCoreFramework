//
//  HYCollectionViewController.h
//  Pods
//
//  Created by fangyuxi on 16/6/16.
//
//

#import <UIKit/UIKit.h>
#import "HYCollectionViewSource.h"
#import "HYViewControllerProtocol.h"

@interface HYCollectionViewController : UIViewController<UICollectionViewDelegate, HYViewControllerProtocol>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HYCollectionViewSource *collectionViewSource;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewLayout;

@end
