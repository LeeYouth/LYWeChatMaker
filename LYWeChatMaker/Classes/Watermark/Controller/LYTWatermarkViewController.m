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
#import "LYTWatermarkSaveSuccessController.h"

@interface LYTWatermarkViewController ()

@property (nonatomic, strong) LYTWatermarkImageView *backImageView;
@property (nonatomic, strong) LYTWatermarkBottomToolBar *bottomToolBar;
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;

@end

@implementation LYTWatermarkViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    
}

- (void)setupSubViews
{
    
    
    self.navBarView.leftBarItemImage = [UIImage imageNamed:@"bottomToolBar_close"];
    self.navBarView.rightBarItemImage = [UIImage imageNamed:@"bottomToolBar_next"];
    self.navBarView.navColor = LYColor(LYBlackColorHex);
    self.navBarView.hiddenShadow = YES;

    [self.view addSubview:self.backImageView];
    [self.view addSubview:self.bottomToolBar];
    
    CGFloat bottomToolBarH = kLYTWatermarkBottomToolBarH;
    
    [self.bottomToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(bottomToolBarH));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottomToolBar.mas_top);
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.equalTo(self.view);
    }];
    
    
    self.inputConfig = [[LYWatermarkInputConfig alloc] init];
    self.inputConfig.inputText    = @"";
    self.inputConfig.colorHex     = self.defultColorHex?self.defultColorHex:LYWhiteColorHex;
    self.inputConfig.fontName     = @"defult";
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

- (void)popRootViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 返回按钮
- (void)backBarItemClick{
    
    WEAKSELF(weakSelf);
    if ((self.inputConfig.inputText.length && ![self.inputConfig.inputText isEqualToString:LYWatermarkInputViewDefultText]) || ![self.inputConfig.colorHex isEqualToString:LYWhiteColorHex] || self.inputConfig.selectBack || self.inputConfig.selectBold  || self.inputConfig.selectStroke || ![self.inputConfig.fontName isEqualToString:@"defult"]) {
        
        LYEnsureOrCancelAlertView *alertView = [LYEnsureOrCancelAlertView sharedInstance];
        [alertView showInViewWithTitle:@"确定丢弃吗？" leftTitle:@"取消" rightTitle:@"丢弃" animated:YES];
        alertView.btnBlock = ^(UIButton *sender) {
            if (sender.tag == 0)
            {
                
            }else if (sender.tag == 1)
            {
                //返回
                [weakSelf popRootViewController];
            }
        };
    }else{
        //返回
        [self popRootViewController];
    }
}
- (void)rightBarItemClick{
    //确定(保存图片到相册)
    [self.backImageView saveWatermarkImage];
}

#pragma mark - 底部样式按钮点击
- (void)bottomStyleBtnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        //阴影
        self.inputConfig.selectStroke = sender.selected;
    }else if (sender.tag == 1){
        //阴影
        self.inputConfig.selectShadow = sender.selected;
    }else if (sender.tag == 2){
        //加粗
        self.inputConfig.selectBold = sender.selected;
    }
    self.backImageView.inputConfig = self.inputConfig;
}
#pragma mark - 底部字体设置
- (void)bottomFontBtnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        //系统字体
        self.inputConfig.fontName = @"defult";
    }else if (sender.tag == 1){
        //站酷
        self.inputConfig.fontName = @"HappyZcool-2016";
    }else if (sender.tag == 2){
        //汉仪
        self.inputConfig.fontName = @"Hanyi Senty Journal";
    }
    self.backImageView.inputConfig = self.inputConfig;
}

#pragma mark - 懒加载
- (LYTWatermarkImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        WEAKSELF(weakSelf);
        LYTWatermarkImageView *imageV = [[LYTWatermarkImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kLYTWatermarkBottomToolBarH - NAVBAR_HEIGHT)];
        imageV.success = ^(UIImage *image) {
            [LYToastTool bottomShowWithText:@"保存成功" delay:1];
            LYTWatermarkSaveSuccessController *vc = [[LYTWatermarkSaveSuccessController alloc] init];
            vc.backImage = image;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        imageV;
    }));
}

- (LYTWatermarkBottomToolBar *)bottomToolBar{
    return LY_LAZY(_bottomToolBar, ({
        
        WEAKSELF(weakSelf);
        CGFloat toolBarH = kLYTWatermarkBottomToolBarH;
        LYTWatermarkBottomToolBar *toolView = [[LYTWatermarkBottomToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - toolBarH, SCREEN_WIDTH, toolBarH)];
        toolView.didSelectItemblock = ^(NSString *colorHex) {
            weakSelf.inputConfig.colorHex = colorHex;
            weakSelf.backImageView.inputConfig = weakSelf.inputConfig;
        };
        toolView.didSelectBackblock = ^(BOOL hasSelect) {
            weakSelf.inputConfig.selectBack = hasSelect;
            weakSelf.backImageView.inputConfig = weakSelf.inputConfig;
        };
        toolView.styleBlock = ^(UIButton *sender) {
            [weakSelf bottomStyleBtnClick:sender];
        };
        toolView.fontBlock = ^(UIButton *sender) {
            [weakSelf bottomFontBtnClick:sender];
        };
        toolView;
    }));
}

@end
