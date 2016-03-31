//
//  HYBaseTableViewSource.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseTableViewSource.h"

@interface HYBaseTableViewSource ()<HYCellToControllerActionProtocol>
{
    
}

@end

@implementation HYBaseTableViewSource

@synthesize pageNum = _pageNum;
@synthesize canLoadMore = _canLoadMore;

- (instancetype)init
{
    self = [self initWithDelegate:nil];
    if (self)
    {
        return self;
    }
    return nil;
}

- (instancetype)initWithDelegate:(id<HYBaseTableViewSourceDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.cellModels = [NSMutableArray array];
        self.pageNum = 1;
        
        [self initExtension];
        return self;
    }
    return nil;
}

- (void)initExtension
{
    
}

#pragma mark UITableViewDataSourceProtocal

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.cellModels objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.cellModels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYBaseCellModel *cellModel = [[self.cellModels objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    HYBaseCell *cell = (HYBaseCell *)[tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
    cell.actionDelegate == nil ? cell.actionDelegate = self : nil;
    [self prepareCell:cell index:indexPath];
    return cell;
}

#pragma mark HYTableViewSourceProtocal

- (void)refreshFinishWithData:(id)data
{
    //清空数据源
    self.cellModels = [NSMutableArray array];
}

- (void)loadMoreFinishWithData:(id)data
{
    
}

- (NSArray<Class> *)containedCellModelsClassArray
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)prepareCell:(HYBaseCell *)cell index:(NSIndexPath *)indexPath
{
    [cell resetCell];
    cell.cellModel = [[self.cellModels objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell updateCell];
}

#pragma mark HYTableViewSourceDataProtocal

- (void)refreshSource
{
    [self doesNotRecognizeSelector:_cmd];
    return;
}

- (void)loadMoreSource
{
    
}

- (void)cancel
{
    
}

- (Class)cellClassForCellViewModelClass:(Class)aClass
{
    return NSClassFromString([NSStringFromClass(aClass) stringByReplacingOccurrencesOfString:@"CellModel" withString:@"Cell"]);
}

- (NSString *)cellIdentifierForCellViewModelClass:(Class)aClass
{
    return NSStringFromClass(aClass);
}

@end

@implementation HYBaseTableViewSource (Notify)

#pragma mark notify

- (void)notifyWillRefresh
{
    if ([(NSObject *)self.delegate respondsToSelector:@selector(tableSourceDidStartRefresh:)])
    {
        [self.delegate tableSourceDidStartRefresh:self];
    }
}
- (void)notifyWillLoadMore
{
    if ([self.delegate respondsToSelector:@selector(tableSourceDidStartLoadMore:)])
    {
        [self.delegate tableSourceDidStartLoadMore:self];
    }
}
- (void)notifyDidFinishRefresh
{
    if ([self.delegate respondsToSelector:@selector(tableSourceDidFinishRefresh:)])
    {
        [self.delegate tableSourceDidFinishRefresh:self];
    }
}
- (void)notifyDidFinishLoadMore
{
    if ([self.delegate respondsToSelector:@selector(tableSourceDidFinishLoadMore:)])
    {
        [self.delegate tableSourceDidFinishLoadMore:self];
    }
}

- (void)notifyDidReceviedExtraData:(id)data
{
    if ([self.delegate respondsToSelector:@selector(tableSource:didReceviedExtraData:)])
    {
        [self.delegate tableSource:self didReceviedExtraData:data];
    }
}

- (void)notifyRefreshError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableSource:refreshError:)])
    {
        [self.delegate tableSource:self refreshError:error];
    }
}
- (void)notifyLoadMoreError:(NSError *)error
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableSource:loadMoreError:)])
    {
        [self.delegate tableSource:self loadMoreError:error];
    }
}


@end
