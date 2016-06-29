//
//  HYTableViewSource.m
//  Pods
//
//  Created by fangyuxi on 16/6/14.
//
//

#import "HYTableViewSource.h"

@interface HYTableViewSource ()

@property (nonatomic, strong) NSMutableSet *registedCellSet;

@end

@implementation HYTableViewSource

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
        self.sections = [NSMutableArray array];
        self.pageNum = 1;
        return self;
    }
    return nil;
}

#pragma mark UITableViewDataSourceProtocal

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HYTableViewSourceSection *sectionObject = [self.sections objectAtIndex:section];
    NSUInteger rowCount = sectionObject.rowCount;
    return rowCount;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYTableViewSourceSection *section = [self.sections objectAtIndex:indexPath.section];
    HYBaseCellModel *cellModel = [section rowAtIndex:indexPath.row];
    
    HYBaseCell *cell = (HYBaseCell *)[tableView dequeueReusableCellWithIdentifier:cellModel.reuseIdentifier];
    cell.actionDelegate == nil ? cell.actionDelegate = self : nil;
    [self prepareCell:cell index:indexPath];
    return cell;
}

#pragma mark HYTableViewSourceProtocal

- (void)refreshFinishWithData:(id)data
{
    //清空数据源
    self.sections = [NSMutableArray array];
}

- (void)loadMoreFinishWithData:(id)data
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

- (Class)footerHeaderclassForFooterHeaderModelClass:(Class)aClass
{
    return NSClassFromString([NSStringFromClass(aClass) stringByReplacingOccurrencesOfString:@"Model" withString:@""]);
}

- (NSString *)identifierForFooterHeaderModelClass:(Class)aClass
{
    return NSStringFromClass(aClass);
}

- (NSArray<Class> *)containedCellModelsClassArray
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)prepareCell:(HYBaseCell *)cell index:(NSIndexPath *)indexPath
{
    [cell resetCell];
    HYTableViewSourceSection *section = [self.sections objectAtIndex:indexPath.section];
    HYBaseCellModel *cellModel = [section rowAtIndex:indexPath.row];
    cell.cellModel = cellModel;
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

- (void)makeSection:(void(^)(HYTableViewSourceSectionMaker *maker))block
{
    [self insertSection:block atIndex:[self.sections count]];
}

- (void)insertSection:(void(^)(HYTableViewSourceSectionMaker *maker))block
            atIndex:(NSUInteger)index
{
    if (index > self.sections.count)
    {
        return;
    }
    
    HYTableViewSourceSectionMaker *maker = [[HYTableViewSourceSectionMaker alloc] initWithSection:nil];
    block(maker);
    
    if (maker.section.rowCount == 0)
    {
        return;
    }
    
    [self.sections insertObject:maker.section atIndex:index];
}

- (void)updateSection:(HYTableViewSourceSection *)section
            userMaker:(void(^)(HYTableViewSourceSectionMaker *maker))block
{
    HYTableViewSourceSectionMaker *maker = [[HYTableViewSourceSectionMaker alloc] initWithSection:section];
    block(maker);
}

- (void)updateSectionAtIndex:(NSUInteger)index
                   userMaker:(void(^)(HYTableViewSourceSectionMaker *maker))block
{
    if (index >= self.sections.count)
    {
        return;
    }
    HYTableViewSourceSection *section = [self.sections objectAtIndex:index];
    [self updateSection:section userMaker:block];
}

@end

@implementation HYTableViewSource (Notify)

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

#pragma mark HYCellToControllerActionProtocol

- (void)actionFromCell:(UIView *)view
          withEventTag:(NSString *)tag
   withParameterObject:(id)object
{
    if(self.cellActionDelegate && [self.cellActionDelegate respondsToSelector:@selector(actionFromCell:withEventTag:withParameterObject:)])
    {
        [self.cellActionDelegate actionFromCell:view withEventTag:tag withParameterObject:object];
    }
}

@end