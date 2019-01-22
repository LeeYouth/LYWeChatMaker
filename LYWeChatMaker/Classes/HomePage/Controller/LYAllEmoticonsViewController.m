//
//  LYAllEmoticonsViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYAllEmoticonsViewController.h"
#import "LYAllEmoticonsTableCell.h"
#import "LYEmoticonListModel.h"
#import "LYEmoticonPackageListViewController.h"
#import "LYMakeEmoticonViewController.h"
#import "LYEmoticonModel.h"


@interface LYAllEmoticonsViewController ()<LYEmoticonPackageListViewControllerDelegate,GADBannerViewDelegate,GADRewardBasedVideoAdDelegate>
{
    NSInteger _currentIndex;
    NSInteger _selectIndex;

}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) GADBannerView *bannerView;//底部广告

@property (nonatomic, strong) NSMutableArray *xmrDataArray;//熊猫人
@property (nonatomic, strong) NSMutableArray *mgtDataArray;//，沟通

@end

@implementation LYAllEmoticonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"表情包";
    

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
        LYEmoticonListModel *model = [[LYEmoticonListModel alloc] init];
        model.emoticonType = [NSString stringWithFormat:@"%d",i];
        if (i == 0) {
            model.emoticonIntro = @"斗图我从来不怂";
            model.emoticonName = @"熊猫人";
            model.canCopy      = NO;
            model.isLock       = ![[NSUserDefaults standardUserDefaults] boolForKey:kXMRUNLOCKSTATUS];
            model.emoticonUrl  = LYLOADBUDLEIMAGE(@"LYXMRImageResources.bundle", @"10001");
            
        }else if (i == 1){
            model.emoticonIntro = @"您有我快吗";
            model.emoticonName = @"蘑菇头";
            model.canCopy      = YES;
            model.isLock       = ![[NSUserDefaults standardUserDefaults] boolForKey:kMGTUNLOCKSTATUS];;
            model.emoticonUrl  = LYLOADBUDLEIMAGE(@"LYMGTImageResources.bundle", @"10001");
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
    return [LYAllEmoticonsTableCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYAllEmoticonsTableCell *cell = [LYAllEmoticonsTableCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _selectIndex = indexPath.row;
    
    LYEmoticonListModel *model = self.dataArray[indexPath.row];

    if (model.isLock) {
        _currentIndex = indexPath.row;
        WEAKSELF(weakSelf);
        LYUnlockNewFeaturesAlertView *alertView = [LYUnlockNewFeaturesAlertView sharedInstance];
        alertView.btnBlock = ^(UIButton *sender) {
            [weakSelf showAdViewController];
        };
        [alertView showInViewWithTitle:@"" detailTitle:@"" buttonTitle:@"" animated:YES];
        return;
    }
    
    
    if (indexPath.row == 0) {
        //熊猫人
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:self.xmrDataArray title:model.emoticonName showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];

    }else if (indexPath.row == 1){
        //蘑菇头
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:self.mgtDataArray title:model.emoticonName showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];
    }
}


#pragma mark - LYEmoticonPackageListViewControllerDelegate
- (void)emoticonPackageListViewController:(LYEmoticonPackageListViewController *)lister didFinishPickingPhotos:(NSArray<UIImage *> *)photos{
    UIImage *cropImage = photos[0];
    if (cropImage != nil) {
        
        LYMakeEmoticonViewController *makeVC = [[LYMakeEmoticonViewController alloc] init];
        makeVC.emoticonCtl = YES;
        makeVC.faceCtl     = NO;
        makeVC.sentenceCtl = YES;
        makeVC.emoticonCtlTitle = _selectIndex == 0?@"熊猫人":@"蘑菇头";
        makeVC.defultEmojiImage  = cropImage;
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:makeVC];
        [self presentViewController:nav animated:YES completion:nil];

    }
}

#pragma mark - 加载广告
#pragma mark - 展示倒计时广告
- (void)showAdViewController{
    [LYToastTool showLoadingWithStatus:@""];
    NSString *unitID = [LYServerConfig LYConfigEnv] == LYServerEnvProduct?GOOGLEVIDEOAD_UNITID:GOOGLEVIDEOAD_TEST_UNITID;
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request]
                                           withAdUnitID:unitID];
    
}

#pragma mark - GADRewardBasedVideoAdDelegate
- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
   didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];

    LYLog(@"%@",rewardMessage);
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    LYLog(@"Reward based video ad is received.");
    
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [LYToastTool dismiss];
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    }
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    LYLog(@"Opened reward based video ad.");
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    LYLog(@"Reward based video ad started playing.");
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    LYLog(@"Reward based video ad has completed.");
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    if (_currentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kXMRUNLOCKSTATUS];
    }else if (_currentIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMGTUNLOCKSTATUS];
    }
    [self loadEmoticonsData];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    LYLog(@"Reward based video ad will leave application.");
    if (_currentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kXMRUNLOCKSTATUS];
    }else if (_currentIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMGTUNLOCKSTATUS];
    }
    [self loadEmoticonsData];
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd
    didFailToLoadWithError:(NSError *)error {
    LYLog(@"Reward based video ad failed to load.--%@",[error localizedDescription]);
    [LYToastTool dismiss];
    if (_currentIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kXMRUNLOCKSTATUS];
    }else if (_currentIndex == 1){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kMGTUNLOCKSTATUS];
    }
    [self loadEmoticonsData];
}

#pragma mark - GADBannerViewDelegate
- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error{
    LYLog(@"GADBannerView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

#pragma mark - lazyloading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)xmrDataArray{
    if (!_xmrDataArray) {
        _xmrDataArray = [NSMutableArray array];
        //熊猫人
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kXMRRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = LYLOADBUDLEIMAGE(@"LYXMRImageResources.bundle", nameStr);
            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.unLock        = [[NSUserDefaults standardUserDefaults] boolForKey:fileName];
            model.emoticonImage = [UIImage imageWithContentsOfFile:fileName];
            model.emoticonName  = @"";
            model.emoticonUrl   = fileName;
            [imageArray addObject:model];
        }
        _xmrDataArray = imageArray;
    }
    return _xmrDataArray;
}
- (NSMutableArray *)mgtDataArray{
    if (!_mgtDataArray) {
        _mgtDataArray = [NSMutableArray array];
        //蘑菇头
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kMGTRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = LYLOADBUDLEIMAGE(@"LYMGTImageResources.bundle", nameStr);

            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.unLock        = [[NSUserDefaults standardUserDefaults] boolForKey:fileName];
            model.emoticonImage = [UIImage imageWithContentsOfFile:fileName];
            model.emoticonName  = @"";
            model.emoticonUrl   = fileName;
            [imageArray addObject:model];
        }
        _mgtDataArray = imageArray;
    }
    return _mgtDataArray;
}

@end
