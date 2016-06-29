//
//  HYViewController.m
//  HYCoreFramework
//
//  Created by fangyuxi on 03/24/2016.
//  Copyright (c) 2016 fangyuxi. All rights reserved.
//

#import "HYViewController.h"
#import "HYHomeTableViewSource.h"
#import "MJRefreshGifHeader.h"
#import "Masonry.h"
#import "HYHomeAdDataPresenter.h"
#import "HYHomeAdView.h"
#import "HYViewControllerEmptyView.h"

@interface HYViewController ()

@property (nonatomic, strong)HYHomeAdDataPresenter *adPresenter;
@property (nonatomic, strong)HYHomeAdView *adView;


@end

@implementation HYViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.tableViewSource updateSectionAtIndex:0 userMaker:^(HYTableViewSourceSectionMaker *maker) {
//           
//            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 100)];
//            sectionView.backgroundColor = [UIColor blueColor];
//            
//            maker.addSectionHeaderView(sectionView);
//        }];
//        
//        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.emptyDataSetErrorView = [HYViewControllerEmptyView new];
    self.emptyDataSetNoContentView = [HYViewControllerEmptyView new];
    self.emptyDataSetRefreshView = [HYViewControllerEmptyView new];
    
    [self p_refreshAd];
    
    [self dragToRefreshWithoutAnimation];
}

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor redColor];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    self.view.hy_emptyDataSetSource = self;
    self.view.hy_emptyDataSetDelegate = self;
    [self.view addSubview:self.tableView];
}

- (void)makeLayout
{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *maker)
     {
         maker.top.equalTo(self.view.mas_top);
         maker.left.equalTo(self.view.mas_left);
         maker.right.equalTo(self.view.mas_right);
         maker.bottom.equalTo(self.view.mas_bottom);
     }];
}

- (void)initTableViewSource
{
    HYHomeTableViewSource *source = [[HYHomeTableViewSource alloc] initWithDelegate:self];
    self.tableViewSource = source;
}

- (void)configHeaderFooterAppearance
{
    self.headerClass = NSClassFromString(@"MJRefreshGifHeader");
    
    NSArray *images = [self imagesForPNGS:@"headRefresh" count:1];
    MJRefreshGifHeader *header = (MJRefreshGifHeader *)self.refreshHeader;
    
    [header setImages:images duration:1 forState:MJRefreshStateIdle];
    [header setImages:images duration:1 forState:MJRefreshStatePulling];
    [header setImages:images duration:1 forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}

- (void)bindViewModel
{
    self.tableView.dataSource = self.tableViewSource;
}

- (void)p_refreshAd
{
//    HYSimpleRequest *adRequest = [[HYSimpleRequest alloc] init];
//    [adRequest startWithSuccessHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
//        
//        [self.adView configViewWithData:[self.adPresenter dataPresenterWithSourceData:response
//                                                                         businessName:request.identifier]];
//        
//    } failerHandler:^(HYBaseRequest *request, HYNetworkResponse *response) {
//        
//        [self.adView configViewWithData:[self.adPresenter dataPresenterWithSourceData:response
//                                                                         businessName:request.identifier]];
//        
//    } progressHandler:^(HYBaseRequest *request, int64_t progress) {
//        
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSArray *)imagesForPNGS:(NSString *)pngFileName count:(NSInteger)count
{
    NSMutableArray *newImages = [NSMutableArray new];
    for (int i = 0; i <= count; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"%@_%d", pngFileName, i];
        [newImages addObject:[UIImage imageNamed:imageName]];
    }
    return newImages;
}

#pragma mark getter 

- (HYHomeAdDataPresenter *)adPresenter
{
    if (!_adPresenter)
    {
        _adPresenter = [[HYHomeAdDataPresenter alloc] init];
    }
    return _adPresenter;
}

@end
