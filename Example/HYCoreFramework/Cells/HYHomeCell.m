//
//  HYHomeCell.m
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/25.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYHomeCell.h"

@implementation HYHomeCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        return self;
    }
    return nil;
}
@end
