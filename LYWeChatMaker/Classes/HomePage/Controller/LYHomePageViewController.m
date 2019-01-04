//
//  LYHomePageViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYTWatermarkViewController.h"
#import "LYSettingViewController.h"
#import "LYHomePageBackgroundView.h"
#import "LYHomePageNavgationView.h"
#import "LYEmoticonPackageListViewController.h"
#import "LYAllEmoticonsViewController.h"

@interface LYHomePageViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) LYHomePageNavgationView *navView;
@property (nonatomic, strong) LYHomePageBackgroundView *btnsView;

@end

@implementation LYHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];



    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.btnsView];

    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(NAVBAR_HEIGHT));
        make.top.left.right.equalTo(self.view);
    }];

    [self.btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom);
    }];

    
}

#pragma mark - 添加水印
- (void)addWaterMark
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:1 delegate:self pushPhotoPickerVc:YES];
    // 不让选择视频和原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.allowPreview = NO;
    imagePickerVc.naviBgColor = LYColor(LYWhiteColorHex);
    imagePickerVc.naviTitleColor = LYColor(LYBlackColorHex);
    imagePickerVc.barItemTextColor = LYColor(LYBlackColorHex);
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 选取表情包
- (void)selectPhotoAddMark
{
    LYAllEmoticonsViewController *emoticonsVC = [[LYAllEmoticonsViewController alloc] init];
    [self.navigationController pushViewController:emoticonsVC animated:YES];


}

#pragma mark - 右侧更多
- (void)rightBarItemClick
{
    LYSettingViewController *settingVC = [[LYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    UIImage *cropImage = photos[0];
    
    if (cropImage != nil) {
        LYTWatermarkViewController *waterMarkVC = [[LYTWatermarkViewController alloc] init];
        waterMarkVC.targetImage = cropImage;
        [self.navigationController pushViewController:waterMarkVC animated:YES];
    }

}



#pragma mark - lazy loading
- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"homePageBackgroundImage_2")];
        imageV;
    }));
}
- (LYHomePageNavgationView *)navView{
    return LY_LAZY(_navView, ({
        WEAKSELF(weakSelf);
        LYHomePageNavgationView *view = [[LYHomePageNavgationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.btnBlock = ^(UIButton *sender) {
            [weakSelf rightBarItemClick];
        };
        view;
    }));
}
- (LYHomePageBackgroundView *)btnsView{
    return LY_LAZY(_btnsView, ({
        WEAKSELF(weakSelf);
        LYHomePageBackgroundView *view = [[LYHomePageBackgroundView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        view.btnBlock = ^(UIButton *sender) {
            if (sender.tag == 0) {
                //从相册
                [weakSelf addWaterMark];
            }else if (sender.tag == 1){
                //从表情包
                [weakSelf selectPhotoAddMark];
            }
        };
        view;
    }));
}
@end
