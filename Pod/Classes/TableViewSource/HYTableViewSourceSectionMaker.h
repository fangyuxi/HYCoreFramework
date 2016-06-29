//
//  HYTableViewSourceSectionMaker.h
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import <Foundation/Foundation.h>
#import "HYTableViewSourceSection.h"
#import "HYTableViewSourceRowMaker.h"

@class HYBaseFooterHeaderView;
@class HYBaseFooterHeaderModel;

@interface HYTableViewSourceSectionMaker : NSObject

/**
 *  初始化方法
 *
 *  @param section section 对象
 *
 *  @return maker
 */
- (instancetype)initWithSection:(HYTableViewSourceSection *)section;

/**
 *  链式语法的连词
 *
 *  @return self
 */
- (HYTableViewSourceSectionMaker *)and;

/*************************************************************************************/
/*******************               section Row                  **********************/
/*************************************************************************************/

/**
 *  返回一行
 */
- (HYTableViewSourceRowMaker *(^)(NSUInteger index))row;

/**
 *  追加一行 返回该行的RowMaker
 */
- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model))addRow;

/**
 *  在指定位置插入一行 返回该行的RowMaker
 */
- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model, NSUInteger index))insertRow;

/**
 *  追加多行
 */
- (HYTableViewSourceSectionMaker *(^)(NSArray *models))addRows;

/**
 *  替换一行 返回新的一行的RowMaker
 */
- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model, NSUInteger index))replaceRow;

/**
 *  交换两行
 */
- (HYTableViewSourceSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeRow;

/**
 *  删除操作
 */
- (HYTableViewSourceSectionMaker *(^)(NSUInteger index))deleteRowIndex;
- (HYTableViewSourceSectionMaker *(^)(HYBaseCellModel *model))deleteRowModel;


/*************************************************************************************/
/*******************       section header & footer         ***************************/
/*************************************************************************************/


//addUnReusedSectionHeaderView addUnReusedSectionFooterView 这两个方法添加的footerheader是不重用的
//对于那种比较简单的占位的footerheader比较合适，因为比较简单，不用创建model
//addSectionHeaderModel addSectionHeaderModel 这两个方法添加的footer header是重用的
//对于那种比较复杂的footerheader，比较合适，减少内存占用

//如果都设置了，那么以重用的版本优先

/**
 *  配置 本Section的不可复用的HeaderView和FooterView
 */
- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderView *headerView))addUnReusedSectionHeaderView;
- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderView *footerView))addUnReusedSectionFooterView;

/**
 *  配置 本Section的HeaderView和FooterView model 优先
 */
- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderModel *model))addSectionHeaderModel;
- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderModel *model))addSectionFooterModel;


/**
 *  maker关联的section
 */
@property (nonatomic, strong, readonly) HYTableViewSourceSection *section;

@end






