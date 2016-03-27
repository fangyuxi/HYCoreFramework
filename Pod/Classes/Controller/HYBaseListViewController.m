//
//  HYBaseListViewController.m
//  MyFirst
//
//  Created by fangyuxi on 16/3/16.
//  Copyright © 2016年 fangyuxi. All rights reserved.
//

#import "HYBaseListViewController.h"
#import "HYBaseCell.h"
#import "MJRefresh/MJRefresh.h"
#import "HYBaseCellModel.h"

@interface HYBaseListViewController ()

@property (nonatomic, strong, readwrite) MJRefreshHeader *refreshHeader;
@property (nonatomic, strong, readwrite) MJRefreshFooter *refreshFooter;

@end

@implementation HYBaseListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerClass = NSClassFromString(@"MJRefreshNormalHeader");
    self.footerClass = NSClassFromString(@"MJRefreshAutoStateFooter");
    
    self.needHeader = YES;
    self.needFooter = YES;
    
    [self configHeaderFooterAppearance];
}

- (void)initView
{
    [self initTableView];
    [self initTableViewSource];
    [self p_registTableViewWithTableViewSource];
    [self p_tableViewAndSourceInitFinish];
}

- (void)makeLayout
{
    
}

- (void)initTableView
{
    NSLog(@"Yout Must create TableView in initTableView Method");
    [self doesNotRecognizeSelector:_cmd];
}

- (void)initTableViewSource
{
    NSLog(@"Yout Must create TableViewSource in initTableViewSource Method");
    [self doesNotRecognizeSelector:_cmd];
}

- (void)configHeaderFooterAppearance
{
    
}

- (void)p_tableViewAndSourceInitFinish
{
    NSAssert(self.tableView,@"The TableView instance must assign to the self.tableView");
    if (!self.tableView.emptyDataSetDelegate){self.tableView.emptyDataSetDelegate = self;}
    if (!self.tableView.emptyDataSetSource){self.tableView.emptyDataSetSource = self.emptyViewStyle;}
    if (!self.tableView.delegate){self.tableView.delegate = self;}
}

#pragma mark registe cell-cellmodel

- (void)p_registTableViewWithTableViewSource
{
    for (Class aClass in [self.tableViewSource containedCellModelsClassArray])
    {
        Class cellClass = [self.tableViewSource cellClassForCellViewModelClass:aClass];
        NSString *cellIdentifier = [self.tableViewSource cellIdentifierForCellViewModelClass:aClass];
        NSString *cellNibPath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        if (cellNibPath)
        {
            [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:cellIdentifier];
        } else
        {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
        }
    }
}

#pragma mark controller refresh source

- (void)dragToRefresh
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)dragToRefreshWithoutAnimation
{
    [self p_refreshViewBeginRefreshing];
}

#pragma mark table view delegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *cellModels = self.tableViewSource.cellModels;
    NSArray *sectionArray = [cellModels objectAtIndex:indexPath.section];
    HYBaseCellModel *cellModel = [sectionArray objectAtIndex:indexPath.row];

    if (cellModel.cellHeight == HYBaseCellNoFrameHeightWhenUseAutoLayout)
    {
        return [tableView fd_heightForCellWithIdentifier:cellModel.reuseIdentifier
                                        cacheByIndexPath:indexPath
                                           configuration:^(HYBaseCell *cell)
        {
            [cell resetCell];
            cell.cellModel = cellModel;
            [cell updateCell];
        }];
    }
    
    return cellModel.cellHeight;
}

#pragma mark overwrite

- (void)bindViewModel
{
    
}

#pragma mark setter

- (void)setNeedHeader:(BOOL)needHeader
{
    _needHeader = needHeader;
    if (_needHeader)
    {
        [self p_addHeader];
    }
    else
    {
        self.tableView.mj_header = nil;
    }
}

- (void)setNeedFooter:(BOOL)needFooter
{
    _needFooter = needFooter;
    if (_needFooter && [self.tableViewSource canLoadMore])
    {
        [self p_addFooter];
    }
    else
    {
        self.tableView.mj_footer = nil;
    }
}

#pragma mark MJRefresh private

- (void)p_addHeader
{
    if (self.tableView.mj_header)
    {
        return;
    }
    
    if (!self.refreshHeader)
    {
        self.refreshHeader = [self.headerClass headerWithRefreshingTarget:self
                                                         refreshingAction:@selector(p_refreshViewBeginRefreshing)];
    }
    
    [self.tableView setMj_header:self.refreshHeader];
}

- (void)p_addFooter
{
    if (self.tableView.mj_footer)
    {
        return;
    }
    
    if (!self.refreshFooter)
    {
        self.refreshFooter = [self.footerClass footerWithRefreshingTarget:self
                                                         refreshingAction:@selector(p_refreshViewBeginLoadMore)];
    }
    
    [self.tableView setMj_footer:self.refreshFooter];
}

- (void)setHeaderClass:(Class)headerClass
{
    _headerClass = headerClass;
    self.refreshHeader = [self.headerClass headerWithRefreshingTarget:self
                                                     refreshingAction:@selector(p_refreshViewBeginRefreshing)];
    //重新调用set方法
    if (self.needHeader)
    {
        [self.tableView setMj_header:self.refreshHeader];
    }
}

- (void)setFooterClass:(Class)footerClass
{
    _footerClass = footerClass;
    self.refreshFooter = [self.footerClass footerWithRefreshingTarget:self
                                                   refreshingAction:@selector(p_refreshViewBeginLoadMore)];
    //重新调用set方法
    if (_needFooter && [self.tableViewSource canLoadMore])
    {
        [self.tableView setMj_footer:self.refreshFooter];
    }
}

- (void)p_refreshViewBeginRefreshing
{
    [self.tableViewSource refreshSource];
}

- (void)p_refreshViewBeginLoadMore
{
    [self.tableViewSource loadMoreSource];
}

#pragma mark TableViewSourceDelegate

- (void)tableSourceDidStartRefresh:(HYBaseTableViewSource *)tableSource
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeRefresh;
    [self.tableView reloadEmptyDataSet];
    
    if(self.needFooter)
    {
        self.tableView.mj_footer = nil;;
    }
}

- (void)tableSourceDidFinishRefresh:(HYBaseTableViewSource *)tableSource
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeNoContent;
    [self.tableView reloadEmptyDataSet];
    
    if (self.needFooter)
    {
        if ([tableSource canLoadMore])
        {
            [self p_addFooter];
        }
        else
        {
            self.tableView.mj_footer = nil;;
        }
    }
    if ([self.tableView isKindOfClass:[UITableView class]])
    {
        [(UITableView *)_tableView reloadData];
    }
    
    [self.tableView.mj_header endRefreshing];
}

- (void)tableSourceDidStartLoadMore:(HYBaseTableViewSource *)tableSource
{
    
}

- (void)tableSourceDidFinishLoadMore:(HYBaseTableViewSource *)tableSource
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeNoContent;
    [self.tableView reloadEmptyDataSet];
    
    if (self.needFooter)
    {
        if ([tableSource canLoadMore])
        {
            [self p_addFooter];
        }
        else
        {
            self.tableView.mj_footer = nil;
        }
    }
    
    [self.tableView.mj_footer endRefreshing];
    
    [(UITableView *)_tableView reloadData];
}

- (void)tableSource:(HYBaseTableViewSource *)tableSource
       refreshError:(NSError *)error
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeError;
    [self.tableView reloadEmptyDataSet];
    
    NSArray *cells = nil;
    if ([self.tableView isKindOfClass:[UITableView class]])
    {
        cells = [(UITableView *)_tableView visibleCells];
    }
    [self.tableView.mj_header endRefreshing];
    [self p_addFooter];
}

- (void)tableSource:(HYBaseTableViewSource *)tableSource
      loadMoreError:(NSError *)error
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeError;
    [self.tableView reloadEmptyDataSet];
    
    [self.tableView.mj_footer endRefreshing];
    
    if (self.needFooter)
    {
        if ([tableSource canLoadMore])
        {
            [self p_addFooter];
        }
        else
        {
            self.tableView.mj_footer = nil;;
        }
    }
}
- (void)tableSource:(HYBaseTableViewSource *)source
didReceviedExtraData:(id)data
{
    
}

- (void) tableSourceDidClearAllData:(HYBaseTableViewSource *)tableSource
{
    self.emptyViewStyle.showType = HYEmptyDataSetStyleShowTypeNoContent;
}

@end
