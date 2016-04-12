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
#import "HYBaseCell.h"

typedef void (^HYTableViewSourceUpdateCompletionBlock)(NSUInteger section, NSUInteger row, HYBaseCellModel *cellModel);

@class HYBaseTableViewSource;

/**

 *  如果准备开发一个直接基于 HYBaseTableViewSource 的子类
 
    请参看 HYBaseNetTableViewSource，这个基类使用的一个例子是
 */

#pragma mark HYTableViewSourceProtocol

/**
 *  //子类需要实现这个协议
 */
@protocol HYTableViewSourceProtocol <NSObject>

@required
/**
 *  数据刷新回来之后需要组装数据，需要调Super
 *
 *  @param data 可以是网络回来的Data，可以是文件读出来的Data，子类通过refreshSource，
                 得到的数据后会回调这个方法
 */
- (void)refreshFinishWithData:(id)data;

/**
 *  返回支持的Model-Cell类型
 *
 *  @return 类似 @[CellModel1.class, CellModel2.class];
 */
- (NSArray<Class> *)containedCellModelsClassArray;


@optional
/**
 *  数据加载更多回来后需要组装数据，需要调Super
 *
 *  @param data 可以是网络回来的Data，可以是文件读出来的Data，子类通过loadMoreSource，
                得到的数据后会回调这个方法
 */
- (void)loadMoreFinishWithData:(id)data;

/**
 *  在Cell将要显示的时候，配置Cell resetCell updateCell with cellmodel
 *
 *  @param cell      这个Cell已经从dequeue中返回
 *  @param indexPath indexPath
 */
- (void)prepareCell:(HYBaseCell*)cell
              index:(NSIndexPath *)indexPath;

@end

#pragma mark HYTableViewSourceConnectControllerProtocol

/**
 *  tableViewSoure遵循这个协议，给控制器提供访问数据的接口
 
    必须要实现 refreshSource ，在该方法按照顺序调用 
    
    notifyWillRefresh
    refreshFinishWithData
    notifyDidFinishRefresh 或者 notifyRefreshError
 
    同样，如果实现了 loadMoreSource，那么在该方法中按照顺序调用
    
    notifyWillLoadMore
    loadMoreFinishWithData
    notifyDidFinishLoadMore 或者 notifyLoadMoreError
 
    notify方法会将状态回调给Controller
 */
@protocol HYTableViewSourceConnectControllerProtocol <NSObject>

@required
- (void)refreshSource;

@optional
- (void)loadMoreSource;
- (void)cancel;

@property (nonatomic, assign)BOOL canLoadMore;
@property (nonatomic, assign)NSInteger pageNum; //default 1

@end

#pragma mark HYBaseTableViewSourceDelegate

/**
 *  source向外部回调状态
 */
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
                        HYTableViewSourceProtocol,
                        HYTableViewSourceConnectControllerProtocol>
{
    
}

- (instancetype)initWithDelegate:(id<HYBaseTableViewSourceDelegate>)delegate NS_DESIGNATED_INITIALIZER;

@property (nonatomic, weak) id<HYBaseTableViewSourceDelegate> delegate;
@property (nonatomic, weak) id<HYCellToControllerActionProtocol> actionDelegate;

/**
 *  存放CellModels
 
    CellModels里面对应TableView的Section结构，一个数组对应一个secion
 
    如果只有一个section 那么cellModels里面就只有一个数组，数组里面是cellModel
 */
@property (nonatomic, strong) NSMutableArray *cellModels;

//根据ModelClass返回CellClass
- (Class)cellClassForCellViewModelClass:(Class)aClass;
//根据CellClass返回重用标识符
- (NSString *)cellIdentifierForCellViewModelClass:(Class)aClass;

@end

#pragma mark update source

/**
 *  外部用来更新source的时候调用
    内部也可以调用
 */
@interface HYBaseTableViewSource (UpdateSource)

/**
 *  清空self.cellModels
    会向控制器回调 tableSourceDidClearAllData
 *
 *  @param block block
 */
- (void)clearSourceWithCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block;

/**
 *  删除一行 sync执行
 *
 *  @param section section index
 *  @param row     row index
 *  @param block   block
 */
- (void)deleteSourceCellModelInSection:(NSUInteger)section
                                andRow:(NSUInteger)row
                   withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block;

/**
 *  向cellModels中插入一个model sync执行
    如果是Frame布局，那么再调这个方法前，请先调用 
    HYBaseCellModel calculateCellElementFrame
 *
 *  @param model   将要插入的model
 *  @param section section index
                   当section >= self.cellModels的时候，会插入一个新的section
 *  @param row     row index
 *  @param block   block
 */
- (void)insertSourceCellModel:(HYBaseCellModel *)model
                    inSection:(NSUInteger)section
                       andRow:(NSUInteger)row
          withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block;

/**
 *  用一个新的CellModel更新self.cellModels中的cellModel
    如果是Frame布局，那么再调这个方法前，请先调用
    HYBaseCellModel calculateCellElementFrame
 *
 *  @param model   model
 *  @param section section index
 *  @param row     row index
 *  @param block   block
 */
- (void)updateWithCellModel:(HYBaseCellModel *)model
                  inSection:(NSUInteger)section
                     andRow:(NSUInteger)row
        withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block;

@end

#pragma mark notify delegate

/**
 *  当子类自定义数据源的时候，需要在合适的位置调用这些方法来通知Controller更新
    具体参见HYBaseNetTableViewSource的列子
 */

@interface HYBaseTableViewSource (Notify)

- (void)notifyWillRefresh;
- (void)notifyWillLoadMore;
- (void)notifyDidFinishRefresh;
- (void)notifyDidFinishLoadMore;

- (void)notifyDidReceviedExtraData:(id)data;

- (void)notifyRefreshError:(NSError *)error;
- (void)notifyLoadMoreError:(NSError *)error;

- (void)notifySourceDidClear;

@end









