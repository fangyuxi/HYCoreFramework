//
//  HYFlexibleHeightFooterHeader.m
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import "HYFlexibleHeightFooterHeader.h"
#import "HYFlexibleHeightFooterHeaderModel.h"

@implementation HYFlexibleHeightFooterHeader

- (void)updateFooterHeader
{
    HYFlexibleHeightFooterHeaderModel *model = (HYFlexibleHeightFooterHeaderModel *)self.footerHeaderModel;
    self.backgroundColor = model.backgroundColor;
    self.contentView.backgroundColor = model.backgroundColor;
    self.tintColor = model.backgroundColor;
}

@end
