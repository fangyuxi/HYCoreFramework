//
//  SLRACDemo1Cell.m
//  HYCoreFramework
//
//  Created by 58 on 3/31/16.
//  Copyright © 2016 fangyuxi. All rights reserved.
//

#import "SLRACDemo1Cell.h"
#import "SLRACDemo1CellModel.h"

@interface SLRACDemo1Cell ()
@property (nonatomic, strong) UILabel *myTitleLabel;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) SLRACDemo1CellModel *cellModel;
@property (nonatomic, strong) UIView *testView;

@end

@implementation SLRACDemo1Cell
@dynamic cellModel;
- (void)bindCellModelIfNeeded
{
    [super bindCellModelIfNeeded];
//    RAC(self, cellModel.content) = [self.contentTextField.rac_textSignal takeUntil:self.rac_prepareForReuseSignal];
}
- (void)updateCell
{
    [super updateCell];
    self.myTitleLabel.text = self.cellModel.title;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self.contentView addSubview:self.myTitleLabel];
//        [self.contentView addSubview:self.contentTextField];
//        [self.contentView addSubview:self.testView];
//        [self.testView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(50);
//            make.height.mas_equalTo(30);
//            make.centerX.equalTo(self.contentView);
//            make.top.bottom.equalTo(self.contentView);
//        }];
        
//        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(50);
//        }];
//        [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.bottom.equalTo(self.contentView);
//            make.right.equalTo(self.contentView);
//        }];
        
//        [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.contentView);
//            make.top.bottom.equalTo(self.myTitleLabel);
//            make.width.equalTo(self.contentView).dividedBy(2);
//        }];
    }
    return self;
}
- (UILabel *)myTitleLabel
{
    if (!_myTitleLabel) {
        _myTitleLabel = ({
            UILabel *l = [UILabel new];
            l;
        });
    }
    return _myTitleLabel;
}

- (UITextField *)contentTextField
{
    if (!_contentTextField) {
        _contentTextField = ({
            UITextField *v = [[UITextField alloc] init];
            v;
        });
    }
    return _contentTextField;
}

- (UIView *)testView
{
    if (!_testView) {
        _testView = [UIView new];
        _testView.backgroundColor = [UIColor redColor];
    }
    return _testView;
}
@end
