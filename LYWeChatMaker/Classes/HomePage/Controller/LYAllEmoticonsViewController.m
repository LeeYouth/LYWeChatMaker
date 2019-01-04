//
//  LYAllEmoticonsViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYAllEmoticonsViewController.h"
#import "LYAllEmoticonsTableCell.h"
#import "LYEmoticonModel.h"
#import "LYEmoticonPackageListViewController.h"
#import "LYTWatermarkViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "LYUnlockNewFeaturesAlertView.h"

@interface LYAllEmoticonsViewController ()<LYEmoticonPackageListViewControllerDelegate,GADBannerViewDelegate,GADInterstitialDelegate>
{
    NSInteger _currentIndex;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) GADBannerView *bannerView;//底部广告
@property (nonatomic, strong) GADInterstitial *interstitial;//倒计时广告

@end

@implementation LYAllEmoticonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"表情包";
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadEmoticonsData];
    [self addGoogleAdmob];
    
    _currentIndex = -1;
}

- (void)loadEmoticonsData
{
    if (self.dataArray.count) {
        [self.dataArray removeAllObjects];
    }
    
    for (int i = 0; i < 2; i++) {
        LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
        model.emoticonType = [NSString stringWithFormat:@"%d",i];
        if (i == 0) {
            model.emoticonName = @"熊猫人";
            model.canCopy      = NO;
            model.isLock       = ![[NSUserDefaults standardUserDefaults] boolForKey:kXMRUNLOCKSTATUS];
            NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYXMRImageResources.bundle"];
            model.emoticonUrl  = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"10005" ofType:@"jpg"];
            
        }else if (i == 1){
            model.emoticonName = @"蘑菇头";
            model.canCopy      = YES;
            model.isLock       = ![[NSUserDefaults standardUserDefaults] boolForKey:kMGTUNLOCKSTATUS];;
            NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYMGTImageResources.bundle"];
            model.emoticonUrl  = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"10001" ofType:@"jpg"];
            
        }else if (i == 2){
            model.emoticonName = @"我的收藏";
            model.canCopy      = YES;
            model.isLock       = NO;
            NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYMyCollectionResources.bundle"];
            model.emoticonUrl  = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"10001" ofType:@"jpg"];
            
        }
        [self.dataArray addObject:model];
    }
    
    [self.tableView reloadData];
}

- (void)addGoogleAdmob{
    CGFloat adHeight = kGADAdSizeBanner.size.height;
    LYLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, kScreenHeight - adHeight - kTabbarExtra, SCREEN_WIDTH, adHeight)];
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
    
    self.bannerView.adUnitID = [LYServerConfig LYConfigEnv] == LYServerEnvProduct?GOOGLEAD_UNITID:GOOGLEAD_TEST_UNITID;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    if ([LYServerConfig LYConfigEnv] != LYServerEnvProduct) {
        request.testDevices = @[ kGADSimulatorID ];
    }
    [self.bannerView loadRequest:request];

}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYAllEmoticonsTableCell *cell = [LYAllEmoticonsTableCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LYEmoticonModel *model = self.dataArray[indexPath.row];

    if (model.isLock) {
        _currentIndex = indexPath.row;
        WEAKSELF(weakSelf);
        LYUnlockNewFeaturesAlertView *alertView = [LYUnlockNewFeaturesAlertView sharedInstance];
        alertView.btnBlock = ^(UIButton *sender) {
            [weakSelf showAdViewController];
        };
        [alertView showInViewAnimated:YES];
        return;
    }
    
    
    if (indexPath.row == 0) {
        //熊猫人
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYXMRImageResources.bundle"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= 10037; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:nameStr ofType:@"jpg"]];
            [imageArray addObject:image];
        }
        
        
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:imageArray title:model.emoticonName showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];

    }else if (indexPath.row == 1){
        //蘑菇头
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYMGTImageResources.bundle"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= 10027; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:nameStr ofType:@"jpg"]];
            [imageArray addObject:image];
        }
        
        
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:imageArray title:model.emoticonName showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];
    }else if(indexPath.row == 2){
        //我的收藏
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYMyCollectionResources.bundle"];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= 10001; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle bundleWithPath:bundlePath] pathForResource:nameStr ofType:@"jpg"]];
            [imageArray addObject:image];
        }
        
        
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:imageArray title:model.emoticonName showAdd:YES delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];
    }
}


#pragma mark - LYEmoticonPackageListViewControllerDelegate
- (void)emoticonPackageListViewController:(LYEmoticonPackageListViewController *)lister didFinishPickingPhotos:(NSArray<UIImage *> *)photos{
    UIImage *cropImage = photos[0];
    if (cropImage != nil) {
        LYTWatermarkViewController *waterMarkVC = [[LYTWatermarkViewController alloc] init];
        waterMarkVC.targetImage = cropImage;
        [self.navigationController pushViewController:waterMarkVC animated:YES];
    }
}

#pragma mark - 加载广告
#pragma mark - 展示倒计时广告
- (void)showAdViewController{
    [LTToastTool showLoadingWithStatus:@""];
    NSString *interstitialID = [LYServerConfig LYConfigEnv] == LYServerEnvProduct?GOOGLEFULLAD_UNITID:GOOGLEFULLAD_TEST_UNITID;
    self.interstitial = [[GADInterstitial alloc]
                         initWithAdUnitID:interstitialID];
    GADRequest *request11 = [GADRequest request];
    self.interstitial.delegate = self;
    [self.interstitial loadRequest:request11];
}

#pragma mark - GADInterstitialDelegate
/// Tells the delegate an ad request succeeded.
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    if (self.interstitial.isReady) {
        [LTToastTool dismiss];
        [self.interstitial presentFromRootViewController:self];
    } else {
        LYLog(@"Ad wasn't ready");
    }

}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    LYLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    LYLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    LYLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    LYLog(@"interstitialDidDismissScreen");
    if (_currentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kXMRUNLOCKSTATUS];
    }else if (_currentIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMGTUNLOCKSTATUS];
    }
    [self loadEmoticonsData];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    LYLog(@"interstitialWillLeaveApplication");
    
    if (_currentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kXMRUNLOCKSTATUS];
    }else if (_currentIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMGTUNLOCKSTATUS];
    }
    [self loadEmoticonsData];
}

#pragma mark - lazyloading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
