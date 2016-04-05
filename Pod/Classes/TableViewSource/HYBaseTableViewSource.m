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
        return self;
    }
    return nil;
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

@implementation HYBaseTableViewSource (UpdateSource)

- (void)clearSourceWithCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block
{
    self.cellModels = nil;
    [self notifySourceDidClear];
    
    if (block) block(0,0,nil);
}

- (void)deleteSourceCellModelInSection:(NSUInteger)section
                                andRow:(NSUInteger)row
                   withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block
{
    if (section >= self.cellModels.count) {return;}
    
    NSMutableArray *rows = [self.cellModels objectAtIndex:section];
    NSAssert([rows isKindOfClass:[NSMutableArray class]], @"如果要使用 deleteSourceCellModelInSection::: 那么source.cellModels中的数组必须是可变数组");
    
    if (row >= rows.count){return;}
    HYBaseCellModel *cellModel = [rows objectAtIndex:row];
    [rows removeObjectAtIndex:row];
    
    //当最后一条内容删除的时候，需要向控制器回调tableSourceDidClearAllData
    BOOL needNotifyClear = YES;
    if (self.cellModels.count == 0)
    {
        needNotifyClear = YES;
    }
    else
    {
        for (NSMutableArray *array in self.cellModels)
        {
            if (array.count != 0)
            {
                needNotifyClear = NO;
            }
        }
    }
    if (needNotifyClear) [self notifySourceDidClear];
    if (block) block(section,row,cellModel);
}

- (void)insertSourceCellModel:(HYBaseCellModel *)model
                    inSection:(NSUInteger)section
                       andRow:(NSUInteger)row
          withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block
{
    if (model == nil) return;
    
    if (section >= self.cellModels.count)
    {
        NSMutableArray *newSection = [[NSMutableArray alloc] initWithCapacity:1];
        [newSection addObject:model];
        [self.cellModels addObject:newSection];
        if (block) block(section, row, model);
    }
    
    if (section < self.cellModels.count)
    {
        NSMutableArray *rows = [self.cellModels objectAtIndex:section];
        NSAssert([rows isKindOfClass:[NSMutableArray class]], @"如果要使用 insertSourceCellModel:::: 那么source.cellModels中的数组必须是可变数组");
        
        if (row > rows.count) return;
        [rows insertObject:model atIndex:row];
        if (block) block(section, row, model);
    }
}

- (void)updateWithCellModel:(HYBaseCellModel *)model
                  inSection:(NSUInteger)section
                     andRow:(NSUInteger)row
        withCompletionBlock:(HYTableViewSourceUpdateCompletionBlock)block
{
    if (model == nil) return;
    if (section >= self.cellModels.count) return;
    
    NSMutableArray *rows = [self.cellModels objectAtIndex:section];
    NSAssert([rows isKindOfClass:[NSMutableArray class]], @"如果要使用 updateWithCellModel:::: 那么source.cellModels中的数组必须是可变数组");
    
    if (row > rows.count) return;
    [rows replaceObjectAtIndex:row withObject:model];
    if (block) block(section, row, model);
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

- (void)notifySourceDidClear
{
    if ([self.delegate respondsToSelector:@selector(tableSourceDidClearAllData:)])
    {
        [self.delegate tableSourceDidClearAllData:self];
    }
}


@end
