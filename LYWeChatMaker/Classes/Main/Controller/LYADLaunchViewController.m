//
//  LYADLaunchViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/2/12.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYADLaunchViewController.h"
#import "LYMainViewServices.h"
#import "LYLaunchModel.h"

@interface LYADLaunchViewController ()<GADBannerViewDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
//谷歌全屏广告
@property (nonatomic, strong) GADBannerView *bannerView;
//
@property (nonatomic, strong) UIImageView *launchImageView;

@end

@implementation LYADLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取启动图片
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    //横屏请设置成 @"Landscape"
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    UIImage * launchImage = [UIImage imageNamed:launchImageName];

    UIImageView *imageV = [UIImageView new];
    imageV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    imageV.image = launchImage;
    [self.view addSubview:imageV];
    
    self.navBarView.leftBarItemImage  = nil;
    self.navBarView.rightBarItemImage = nil;
    self.navBarView.navColor =LYClearColor;
    
    //预加载
    [self addGoogleAdmob];
    [self addCustomAd];
    self.bannerView.hidden = YES;
    self.launchImageView.hidden = YES;

    [LYMainViewServices getLaunchDataWithSuccess:^(NSArray * _Nonnull resultArray) {
        LYLaunchModel *model = resultArray[0];
        if (model.showStatus.boolValue) {
            if (model.type.intValue == 1) {
                //谷歌广告
                self.bannerView.hidden = NO;
                self.launchImageView.hidden = YES;

            }else if (model.type.intValue == 2){
                //普通广告
                self.bannerView.hidden = YES;
                self.launchImageView.hidden = NO;
            }else{
                [self launchSuccessAction];
            }
        }else{
            [self launchSuccessAction];
        }
        
    } failue:^(NSError * _Nonnull error) {
        [self launchSuccessAction];
    }];
}


- (void)addGoogleAdmob{
    
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
    
    self.bannerView.adUnitID = [LYServerConfig LYConfigEnv] == LYServerEnvProduct?GOOGLEAD_LAUNCH_UNITID:GOOGLEAD_TEST_UNITID;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    if ([LYServerConfig LYConfigEnv] != LYServerEnvProduct) {
        request.testDevices = @[ kGADSimulatorID ];
    }
    [self.bannerView loadRequest:request];
    
}


- (void)addCustomAd{
    UIImageView *imageV = [UIImageView new];
    imageV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:imageV];
    self.launchImageView = imageV;
}


- (void)launchSuccessAction{
    if (_delegate && [_delegate respondsToSelector:@selector(launchSuccessAction:)]) {
        [_delegate launchSuccessAction:self];
    }
}


@end
