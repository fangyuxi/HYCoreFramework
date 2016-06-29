//
//  HYBaseFooterHeaderModel.m
//  Pods
//
//  Created by fangyuxi on 16/6/15.
//
//

#import "HYBaseFooterHeaderModel.h"

const CGFloat HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout = -1.0f;

@interface HYBaseFooterHeaderModel ()

@property (nonatomic, copy, readwrite) NSString *reuseIdentifier;
@property (nonatomic, assign, readwrite)CGFloat footerHeaderHeight;

@end

@implementation HYBaseFooterHeaderModel

- (instancetype)initWithDictionary:(id)dic
{
    self = [super initWithDictionary:dic];
    if (self)
    {
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.footerHeaderHeight = HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.reuseIdentifier = NSStringFromClass([self class]);
        self.footerHeaderHeight = HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout;
    }
    return self;
}

- (void)mj_keyValuesDidFinishConvertingToObject
{
    [self dicMapModelFinish];
    [self calculateFooterHeaderElementFrame];
}

- (void)calculateFooterHeaderElementFrame
{
    self.footerHeaderHeight = HYBaseFooterHeaderNoFrameHeightWhenUseAutoLayout;
}

+ (NSDictionary *)transferDic
{
    return nil;
}


@end
