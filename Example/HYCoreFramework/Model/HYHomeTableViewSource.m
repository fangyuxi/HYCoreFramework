//
//  HYHomeTableViewSource.m
//  HYCoreFramework
//
//  Created by fangyuxi on 16/3/24.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYHomeTableViewSource.h"
#import "HYHomeCellModel.h"
#import "MJExtension.h"
#import "HYBaseFooterHeaderView.h"
#import "HYFlexibleHeightFooterHeader.h"
#import "HYFlexibleHeightFooterHeaderModel.h"

@implementation HYHomeTableViewSource


- (NSString *)apiURL
{
    return @"/api/user?method=skills.list.home";
}

- (NSDictionary *)requestParamDic
{
    return nil;
}

- (void)refreshFinishWithData:(id)data
{
    [super refreshFinishWithData:data];
    
    NSArray *dics = [[[data objectForKey:@"result"] objectForKey:@"data"] objectForKey:@"skilllist"];
    
    [self makeSection:^(HYTableViewSourceSectionMaker *maker) {
       
        for (NSDictionary *dic in dics)
        {
            HYHomeCellModel *cellModel = [[HYHomeCellModel alloc] initWithDictionary:dic];
            [cellModel calculateCellElementFrame];
            
            maker.addRow(cellModel).rowPosition([HYBaseCell groupStyleWithIndex:0 Count:0]);
        }
        
        //重用版本
        HYFlexibleHeightFooterHeaderModel *modelHeader = [[HYFlexibleHeightFooterHeaderModel alloc] init];
        modelHeader.backgroundColor = [UIColor blackColor];
        modelHeader.flexibleHeight = 20.0f;
        
        //非重用版本
        HYBaseFooterHeaderView *footer = [[HYBaseFooterHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        footer.backgroundColor = [UIColor blueColor];
        footer.contentView.backgroundColor = [UIColor blueColor];
        footer.tintColor = [UIColor blueColor];
        
        
        maker.addUnReusedSectionFooterView(footer).and.addSectionFooterModel(modelHeader);
    }];
}

- (void)loadMoreFinishWithData:(id)data
{
    
}

- (id)responseDataValidator
{
    return @{
             @"result":[NSDictionary class],
             @"result" :@{@"data":[NSDictionary class]},
             @"result":@{@"data":@{@"skilllist":[NSArray class]}},
             @"result":@{@"data":@{@"skilllist":@[@{@"cateName":[NSString class]}]}}
             };
}

- (NSArray<Class> *)containedCellModelsClassArray
{
    return @[[HYHomeCellModel class]];
}

- (NSArray<Class> *)containedHeaderFooterViewClassArray
{
    return @[[HYFlexibleHeightFooterHeaderModel class]];
}

@end
