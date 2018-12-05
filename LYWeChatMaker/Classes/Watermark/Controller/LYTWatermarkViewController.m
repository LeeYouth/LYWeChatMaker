//
//  LYTWatermarkViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkViewController.h"
#import "LYAdvertisementAlertView.h"
#import "LYWKWebViewController.h"
#import "LYTWatermarkImageView.h"
#import "LYTWatermarkBottomToolBar.h"
#import "LYWatermarkInputConfig.h"

@interface LYTWatermarkViewController ()

@property (nonatomic, strong) LYTWatermarkImageView *backImageView;
@property (nonatomic, strong) LYTWatermarkBottomToolBar *bottomToolBar;
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;

@end

@implementation LYTWatermarkViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.bottomToolBar];
    
    CGFloat toolBarH = LYTWatermarkBottomToolBarH;
    
    [self.bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(toolBarH));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomToolBar.mas_top);
        make.top.left.right.equalTo(self.view);
    }];
    

    
    self.inputConfig = [[LYWatermarkInputConfig alloc] init];
    self.inputConfig.inputText    = @"";
    self.inputConfig.colorHex     = LYWhiteColorHex;
    self.inputConfig.selectBack   = NO;
    self.inputConfig.selectBold   = NO;
    self.inputConfig.selectShadow = NO;
    self.inputConfig.selectStroke = NO;

    self.backImageView.backImage = self.targetImage;
    self.backImageView.inputConfig = self.inputConfig;

}

- (void)showAlertView
{
    WEAKSELF(weakSelf);
    LYAdModel *adModel = [[LYAdModel alloc] init];
    adModel.imageUrl = @"https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2034075588,3066561264&fm=173&app=25&f=JPEG?w=640&h=439&s=496183465D5286CC1E41759603008090";
    adModel.linkUrl = @"https://www.baidu.com";
    LYAdvertisementAlertView *alertView = [LYAdvertisementAlertView showInView:self.view theADInfo:@[adModel,adModel]];
    alertView.block = ^(NSInteger index) {
        LYWKWebViewController *vc = [[LYWKWebViewController alloc] initWithURLString:@"https://www.baidu.com"];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}


#pragma mark - 底部按钮点击
- (void)bottomButtonClick:(NSInteger)index
{
    if (index == 0) {
        //取消
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index == 1){
        //确定(保存图片到相册)
        [self.backImageView saveWatermarkImage];
    }
}
#pragma mark - 底部样式按钮点击
- (void)bottomStyleBtnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        //阴影
        self.inputConfig.selectStroke = sender.selected;
        self.backImageView.inputConfig = self.inputConfig;
    }else if (sender.tag == 1){
        //阴影
        self.inputConfig.selectShadow = sender.selected;
        self.backImageView.inputConfig = self.inputConfig;
    }else if (sender.tag == 2){
        //加粗
        self.inputConfig.selectBold = sender.selected;
        self.backImageView.inputConfig = self.inputConfig;
    }
}


#pragma mark - 懒加载
- (LYTWatermarkImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        WEAKSELF(weakSelf);
        LYTWatermarkImageView *imageV = [[LYTWatermarkImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - LYTWatermarkBottomToolBarH)];
        imageV.success = ^{
            
            [MBProgressHUD showErrorMessage:@"保存成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];

        };
        imageV;
    }));
}
- (LYTWatermarkBottomToolBar *)bottomToolBar{
    return LY_LAZY(_bottomToolBar, ({
        
        WEAKSELF(weakSelf);
        CGFloat toolBarH = LYTWatermarkBottomToolBarH;
        LYTWatermarkBottomToolBar *toolView = [[LYTWatermarkBottomToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - toolBarH, SCREEN_WIDTH, toolBarH)];
        toolView.didSelectItemblock = ^(NSString *colorHex) {
            weakSelf.inputConfig.colorHex = colorHex;
            weakSelf.backImageView.inputConfig = weakSelf.inputConfig;
        };
        toolView.didSelectBackblock = ^(BOOL hasSelect) {
            weakSelf.inputConfig.selectBack = hasSelect;
            weakSelf.backImageView.inputConfig = weakSelf.inputConfig;
        };
        toolView.bottomBtnblock = ^(NSInteger index) {
            [weakSelf bottomButtonClick:index];
        };
        toolView.styleBlock = ^(UIButton *sender) {
            [weakSelf bottomStyleBtnClick:sender];
        };
        toolView;
    }));
}

@end
