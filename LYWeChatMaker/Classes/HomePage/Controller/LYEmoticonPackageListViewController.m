//
//  LYEmoticonPackageListViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYEmoticonPackageListViewController.h"
#import "LYEmoticonPackageListCell.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "LYEmoticonModel.h"
#import "LYEmoticonsGuideView.h"

@interface LYEmoticonPackageListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,GADInterstitialDelegate>
{
    NSInteger _currentIndex;
}

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) GADInterstitial *interstitial;//倒计时广告

@end

@implementation LYEmoticonPackageListViewController

- (instancetype)initWithIamgeArray:(NSMutableArray *)imageArray title:(NSString *)title showAdd:(BOOL)showAdd delegate:(id<LYEmoticonPackageListViewControllerDelegate>)delegate{
    self = [super init];
    if (self) {
        self.dataListArray = imageArray;
        self.delegate = delegate;
        self.showAdd  = showAdd;
        if (title.length) {
            self.title = title;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setupSubViews];
    
    _currentIndex = -1;
    
   

}

- (void)_setupSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 10.0f;
    //最小两行之间的间距
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10, 10.0f, 0, 10.0f);
    
    CGFloat cellW = (kScreenWidth - 30)/2;
    layout.itemSize = CGSizeMake(cellW, cellW);
    

    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = LYCellLineColor;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    
    CGFloat topMargin = NAVBAR_HEIGHT;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topMargin);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setDataListArray:(NSMutableArray *)dataListArray{
    _dataListArray = dataListArray;
    
    [self.collectionView reloadData];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"LYEmoticonsGuideView"]) {
        LYEmoticonsGuideView *guidView = [[LYEmoticonsGuideView alloc] init];
        [guidView showInViewWithTargetView:self.view];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataListArray.count + (self.showAdd?1:0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WEAKSELF(weakSelf);
    LYEmoticonPackageListCell *cell = [LYEmoticonPackageListCell cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];
    cell.model = self.dataListArray[indexPath.row];
    cell.block = ^(UIButton *sender) {
        [weakSelf showAlertView:indexPath];
    };
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
    LYEmoticonModel *model= self.dataListArray[indexPath.row];
    NSArray *arr = [NSArray arrayWithObject:model.emoticonImage];
    if (self.delegate && [self.delegate respondsToSelector:@selector(emoticonPackageListViewController:didFinishPickingPhotos:)]) {
        [self.delegate emoticonPackageListViewController:self didFinishPickingPhotos:arr];
    }
}


#pragma mark - 打开广告
- (void)showAlertView:(NSIndexPath *)indexPath{
    _currentIndex = indexPath.row;
    
    WEAKSELF(weakSelf);
    LYUnlockNewFeaturesAlertView *alertView = [LYUnlockNewFeaturesAlertView sharedInstance];
    alertView.btnBlock = ^(UIButton *sender) {
        [weakSelf showAdViewController];
    };
    [alertView showInViewWithTitle:@"这是未解锁的表情!" detailTitle:@"观看广告后可立即解锁。\n点击下面的按钮很快保存这个表情包到相册哦！" buttonTitle:@"" animated:YES];

}
- (void)showAdViewController{

    [LYToastTool showLoadingWithStatus:@""];
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
        [LYToastTool dismiss];
        [self.interstitial presentFromRootViewController:self];
    } else {
        LYLog(@"Ad wasn't ready");
    }
    
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    LYLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    [LYToastTool dismiss];
    
    if (_currentIndex < 0) return;
    
    LYEmoticonModel *model = self.dataListArray[_currentIndex];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:model.emoticonUrl];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:model.emoticonUrl];
    model.unLock = YES;
    [self.collectionView reloadData];
    [self saveImageClick:savedImage];
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
    LYEmoticonModel *model = self.dataListArray[_currentIndex];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:model.emoticonUrl];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:model.emoticonUrl];
    model.unLock = YES;
    [self.collectionView reloadData];
    [self saveImageClick:savedImage];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    LYLog(@"interstitialWillLeaveApplication");
    LYEmoticonModel *model = self.dataListArray[_currentIndex];
    UIImage *savedImage = [UIImage imageWithContentsOfFile:model.emoticonUrl];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:model.emoticonUrl];
    model.unLock = YES;
    [self.collectionView reloadData];
    [self saveImageClick:savedImage];
}


- (void)saveImageClick:(UIImage *)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        
    }else{
        msg = @"保存图片成功" ;
    }
    [LYToastTool bottomShowWithText:msg delay:1.5f];
}

@end


