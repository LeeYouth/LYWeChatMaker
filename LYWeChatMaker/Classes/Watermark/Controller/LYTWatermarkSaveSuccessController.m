//
//  LYTWatermarkSaveSuccessController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSaveSuccessController.h"
#import "LYTWatermarkSuccessView.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface LYTWatermarkSaveSuccessController ()<GADBannerViewDelegate>

@property (nonatomic, strong) LYTWatermarkSuccessView *backImageView;
@property (nonatomic, strong) GADBannerView *bannerView;//底部广告

@end

@implementation LYTWatermarkSaveSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"保存";
    [self.view addSubview:self.backImageView];

    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.mas_equalTo(@(NAVBAR_HEIGHT));
    }];
    
    self.backImageView.backImage = self.backImage;
    
    [self addGoogleAdmob];
    
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


#pragma mark - 懒加载
- (LYTWatermarkSuccessView *)backImageView{
    return LY_LAZY(_backImageView, ({
        WEAKSELF(weakSelf);
        LYTWatermarkSuccessView *imageV = [[LYTWatermarkSuccessView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
        imageV.btnBlock = ^(UIButton *sender) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        imageV;
    }));
}

@end
