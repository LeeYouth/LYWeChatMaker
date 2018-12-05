//
//  LYHomePageViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYTWatermarkViewController.h"
#import "LYDrawRectangleView.h"

@interface LYHomePageViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) UIImageView *backImageView;

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
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    
    CGFloat btnW = 80;
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = btnW/2;
    [button setTitle:@"加文字" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(addWaterMark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
    }];
    
    


}

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
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"homePageBackgroundImage_2")];
        imageV;
    }));
}

@end
