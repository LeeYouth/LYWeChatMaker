//
//  LYAboutUsViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYAboutUsViewController.h"
#import "LYAboutUsInfoView.h"

@interface LYAboutUsViewController ()

@property (nonatomic, strong) LYAboutUsInfoView *aboutUsView;

@end

@implementation LYAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"关于简单水印";
    
    [self.aboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(@300);
    }];
}

- (LYAboutUsInfoView *)aboutUsView{
    return LY_LAZY(_aboutUsView, ({
        LYAboutUsInfoView *view = [[LYAboutUsInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        [self.view addSubview:view];
        view;
    }));
}


@end
