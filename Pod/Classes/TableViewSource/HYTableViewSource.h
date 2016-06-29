//
//  HYTableViewSource.h
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import <Foundation/Foundation.h>
#import "HYTableViewSourceSectionMaker.h"
#import "HYBaseCell.h"

typedef void (^HYTableViewSourceUpdateCompletionBlock)(NSUInteger section, NSUInteger row, HYBaseCellModel *cellModel);

@class HYTableViewSource;

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
 *  返回支持的Model-HeaderFooter类型
 *
 *  @return 类似 @[HeaderModel1.class, FooterModel2.class];
 */
- (NSArray<Class> *)containedHeaderFooterViewClassArray;

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

- (void)tableSourceDidStartRefresh:(HYTableViewSource *)tableSource;
- (void)tableSourceDidFinishRefresh:(HYTableViewSource *)tableSource;
- (void)tableSourceDidFinishLoadMore:(HYTableViewSource *)tableSource;
- (void)tableSourceDidStartLoadMore:(HYTableViewSource *)tableSource;
- (void)tableSource:(HYTableViewSource *)tableSource refreshError:(NSError *)error;
- (void)tableSource:(HYTableViewSource *)tableSource loadMoreError:(NSError *)error;
- (void)tableSource:(HYTableViewSource *)source didReceviedExtraData:(id)data;

- (void) tableSourceDidClearAllData:(HYTableViewSource *)tableSource;

@end

#pragma mark HYBaseTableViewSource

@interface HYTableViewSource : NSObject<
                    UITableViewDataSource,
                    HYTableViewSourceProtocol,
                    HYTableViewSourceConnectControllerProtocol,
                    HYCellToControllerActionProtocol>
{
    
}

- (instancetype)initWithDelegate:(id<HYBaseTableViewSourceDelegate>)delegate NS_DESIGNATED_INITIALIZER;

/**
 *  存放Sections
 */
@property (nonatomic, strong) NSMutableArray<HYTableViewSourceSection *> *sections;

@property (nonatomic, weak) id<HYBaseTableViewSourceDelegate> delegate;
@property (nonatomic, weak) id<HYCellToControllerActionProtocol> cellActionDelegate;

/**
 *  追加新的section
 *
 *  @param block block
 */
- (void)makeSection:(void(^)(HYTableViewSourceSectionMaker *maker))block;

/**
 *  在指定位置添加新的section
 *
 *  @param block block
 *  @param index 指定位置
 */
- (void)insertSection:(void(^)(HYTableViewSourceSectionMaker *maker))block
            atIndex:(NSUInteger)index;

/**
 *  更新指定的section
 *
 *  @param section section
 *  @param block   block
 */
- (void)updateSection:(HYTableViewSourceSection *)section
            userMaker:(void(^)(HYTableViewSourceSectionMaker *maker))block;

- (void)updateSectionAtIndex:(NSUInteger)index
                   userMaker:(void(^)(HYTableViewSourceSectionMaker *maker))block;

@end

#pragma mark notify delegate

/**
 *  当子类自定义数据源的时候，需要在合适的位置调用这些方法来通知Controller更新
 具体参见HYBaseNetTableViewSource的列子
 */

@interface HYTableViewSource (Notify)

- (void)notifyWillRefresh;
- (void)notifyWillLoadMore;
- (void)notifyDidFinishRefresh;
- (void)notifyDidFinishLoadMore;

- (void)notifyDidReceviedExtraData:(id)data;

- (void)notifyRefreshError:(NSError *)error;
- (void)notifyLoadMoreError:(NSError *)error;

- (void)notifySourceDidClear;

@end
