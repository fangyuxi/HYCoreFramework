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
#import "HYDefautEmtpyScrollViewDataSetStypeObject.h"
#import "HYHomeAdDataPresenter.h"
#import "HYHomeAdView.h"

@interface HYViewController ()

@property (nonatomic, strong)HYHomeAdDataPresenter *adPresenter;
@property (nonatomic, strong)HYHomeAdView *adView;


@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.emptyViewStyle = [[HYDefautEmtpyScrollViewDataSetStypeObject alloc] init];
    
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
