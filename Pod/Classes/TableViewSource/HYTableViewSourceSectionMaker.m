//
//  HYTableViewSourceSectionMaker.m
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import "HYTableViewSourceSectionMaker.h"

@interface HYTableViewSourceSectionMaker ()

@property (nonatomic, strong, readwrite) HYTableViewSourceSection *section;

@end

@implementation HYTableViewSourceSectionMaker

- (instancetype)initWithSection:(HYTableViewSourceSection *)section
{
    self = [super init];
    if (self)
    {
        section == nil ? (_section = [HYTableViewSourceSection new]) : (_section = section);
        return self;
    }
    return nil;
}

- (HYTableViewSourceSectionMaker *(^)(NSString *identifier))setIdentifier
{
    return ^HYTableViewSourceSectionMaker *(NSString *identifier){
        
        self.section.identifier = identifier;
        return self;
    };
}

- (HYTableViewSourceRowMaker *(^)(NSUInteger index))row
{
    return ^HYTableViewSourceRowMaker *(NSUInteger index){
        
        HYBaseCellModel *model = [self.section rowAtIndex:index];
        return [[HYTableViewSourceRowMaker alloc] initWithModel:model];
    };
}

- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model))addRow
{
    return ^HYTableViewSourceRowMaker *(HYBaseCellModel *model){
    
        [self.section addRowWithModel:model];
        return [[HYTableViewSourceRowMaker alloc] initWithModel:model];
    };
}

- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model, NSUInteger index))insertRow
{
    return ^HYTableViewSourceRowMaker *(id model, NSUInteger index){
        
        [self.section insertRowWithModel:model atIndex:index];
        return [[HYTableViewSourceRowMaker alloc] initWithModel:model];
    };
}

- (HYTableViewSourceSectionMaker *(^)(NSArray *models))addRows
{
    return ^HYTableViewSourceSectionMaker *(NSArray *models){
        
        [self.section addRowsWithModels:models];
        return self;
    };
}

- (HYTableViewSourceRowMaker *(^)(HYBaseCellModel *model, NSUInteger index))replaceRow
{
    return ^HYTableViewSourceRowMaker *(id model, NSUInteger index){
        
        [self.section replaceRowAtIndex:index withModel:model];
        return [[HYTableViewSourceRowMaker alloc] initWithModel:model];
    };
}

- (HYTableViewSourceSectionMaker *(^)(NSUInteger idx1, NSUInteger idx2))exchangeRow
{
    return ^HYTableViewSourceSectionMaker *(NSUInteger idx1, NSUInteger idx2){
        
        [self.section exchangeRowAtIndex:idx1 withRowAtIndex:idx2];
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)(NSUInteger index))deleteRowIndex
{
    return ^HYTableViewSourceSectionMaker *(NSUInteger index){
        
        [self.section deleteRowAtIndex:index];
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)(HYBaseCellModel *model))deleteRowModel
{
    return ^HYTableViewSourceSectionMaker *(id model){
        
        [self.section deleteRowWithModel:model];
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)())deleteAllRows
{
    return ^HYTableViewSourceSectionMaker *(){
        
        [self.section deleteAllRows];
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderView *headerView))addUnReusedSectionHeaderView
{
    return ^HYTableViewSourceSectionMaker *(HYBaseFooterHeaderView *headerView){
        
        self.section.headerView = headerView;
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderView *footerView))addUnReusedSectionFooterView
{
    return ^HYTableViewSourceSectionMaker *(HYBaseFooterHeaderView *footerView){
        
        self.section.footerView = footerView;
        return self;
    };
}

- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderModel *model))addSectionHeaderModel
{
    return ^HYTableViewSourceSectionMaker *(HYBaseFooterHeaderModel *model){
        
        model.type = HYFooterHeaderTypeHeader;
        self.section.headerModel = model;
        return self;
    };
}
- (HYTableViewSourceSectionMaker *(^)(HYBaseFooterHeaderModel *model))addSectionFooterModel
{
    return ^HYTableViewSourceSectionMaker *(HYBaseFooterHeaderModel *model){
        
        model.type = HYFooterHeaderTypeFooter;
        self.section.footerModel = model;
        return self;
    };
}

- (HYTableViewSourceSectionMaker *)and
{
    return self;
}

- (HYTableViewSourceSection *)section
{
    if (!_section) {
        _section = [HYTableViewSourceSection new];
    }
    return _section;
}


@end
