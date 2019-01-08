//
//  LYBaseViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYBaseViewController.h"

@interface LYBaseViewController ()

@end

@implementation LYBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navBarView.navBarTitle = self.title;
    [self.view bringSubviewToFront:self.navBarView];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    [self.view addSubview:self.navBarView];
    

    self.view.backgroundColor = LYTableViewBackColor;

}


- (void)backBarItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarItemClick{
    
}

- (LYCustomNavgationBarView *)navBarView{
    return LY_LAZY(_navBarView, ({
        WEAKSELF(weakSelf);
        LYCustomNavgationBarView *view = [[LYCustomNavgationBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, NAVBAR_HEIGHT)];
        view.btnBlock = ^(UIButton *sender) {
            if (sender.tag == 0) {
                [weakSelf backBarItemClick];
            }else{
                [weakSelf rightBarItemClick];
            }
        };
        view;
    }));
}

@end
