//
//  LYBaseViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/8/16.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYCustomNavgationBarView.h"

@interface LYBaseViewController : UIViewController

@property (nonatomic, strong) LYCustomNavgationBarView *navBarView;

/** 返回按钮操作(若未重写，则pop上一级) */
- (void)backBarItemClick;
/** 返回按钮操作(若未重写，则pop上一级) */
- (void)rightBarItemClick;

@end
