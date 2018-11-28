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

@interface LYTWatermarkViewController ()

@end

@implementation LYTWatermarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
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


@end
