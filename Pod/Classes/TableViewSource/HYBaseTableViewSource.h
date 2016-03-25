//
//  HYBaseTableViewSource.h
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYBaseCellModel.h"

@class HYBaseCell;
@class HYTableViewSourceSection;
@class HYBaseTableViewSource;

#pragma mark HYTableViewSourceProtocal

//子类需要实现这个协议
@protocol HYTableViewSourceProtocal <NSObject>

@required
//数据刷新回来之后需要组装数据，需要调Super
- (void)refreshFinishWithData:(id)data;

//返回支持的Model-Cell类型 类似 @[CellModel1.class, CellModel2.class]; //BCell BCellModel
- (NSArray<Class> *)containedCellModelsClassArray;


@optional
//数据加载更多回来后需要组装数据，需要调Super
- (void)loadMoreFinishWithData:(id)data;

//准备Cell
- (void)prepareCell:(HYBaseCell*)cell
              index:(NSIndexPath *)indexPath;

@end

#pragma mark HYTableViewSourceConnectControllerProtocal

//tableviewsoure遵循这个协议，给控制器提供访问数据的接口
@protocol HYTableViewSourceConnectControllerProtocal <NSObject>

@required
- (void)refreshSource;

@optional
- (void)loadMoreSource;
- (void)cancel;

@property (nonatomic, assign)BOOL canLoadMore;
@property (nonatomic, assign)NSInteger pageNum;

@end

#pragma mark HYBaseTableViewSourceDelegate

//source向外部回调
@protocol HYBaseTableViewSourceDelegate <NSObject>

@optional

- (void)tableSourceDidStartRefresh:(HYBaseTableViewSource *)tableSource;
- (void)tableSourceDidFinishRefresh:(HYBaseTableViewSource *)tableSource;
- (void)tableSourceDidFinishLoadMore:(HYBaseTableViewSource *)tableSource;
- (void)tableSourceDidStartLoadMore:(HYBaseTableViewSource *)tableSource;
- (void)tableSource:(HYBaseTableViewSource *)tableSource refreshError:(NSError *)error;
- (void)tableSource:(HYBaseTableViewSource *)tableSource loadMoreError:(NSError *)error;
- (void)tableSource:(HYBaseTableViewSource *)source didReceviedExtraData:(id)data;

- (void) tableSourceDidClearAllData:(HYBaseTableViewSource *)tableSource;

@end

#pragma mark HYBaseTableViewSource

@interface HYBaseTableViewSource : NSObject<
                        UITableViewDataSource,
                        HYTableViewSourceProtocal,
                        HYTableViewSourceConnectControllerProtocal>
{
    
}

- (void)initExtension;

- (instancetype)initWithDelegate:(id<HYBaseTableViewSourceDelegate>)delegate
                                                        NS_DESIGNATED_INITIALIZER;

@property (nonatomic, weak) id<HYBaseTableViewSourceDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *cellModels;

//根据ModelClass返回CellClass
- (Class)cellClassForCellViewModelClass:(Class)aClass;
//根绝CellClass返回重用标识符
- (NSString *)cellIdentifierForCellViewModelClass:(Class)aClass;

@end


#pragma mark notify delegate

//当子类自定义数据源的时候，需要在合适的位置调用这些方法来通知Controller更新
//具体参见HYBaseNetTableViewSource的列子

@interface HYBaseTableViewSource (Notify)

- (void)notifyWillRefresh;
- (void)notifyWillLoadMore;
- (void)notifyDidFinishRefresh;
- (void)notifyDidFinishLoadMore;

- (void)notifyDidReceviedExtraData:(id)data;

- (void)notifyRefreshError:(NSError *)error;
- (void)notifyLoadMoreError:(NSError *)error;


@end









