//
//  LYTWatermarkSaveSuccessController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSaveSuccessController.h"
#import "LYTWatermarkSuccessView.h"

@interface LYTWatermarkSaveSuccessController ()

@property (nonatomic, strong) LYTWatermarkSuccessView *backImageView;

@end

@implementation LYTWatermarkSaveSuccessController

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"保存";
    [self.view addSubview:self.backImageView];

    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
    
    self.backImageView.backImage = self.backImage;
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
