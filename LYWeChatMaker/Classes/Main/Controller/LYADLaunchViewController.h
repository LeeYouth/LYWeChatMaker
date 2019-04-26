//
//  LYADLaunchViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/2/12.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  启动页

#import "LYBaseViewController.h"
@class LYADLaunchViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol LYADLaunchViewControllerDelegate <NSObject>

- (void)launchSuccessAction:(LYADLaunchViewController *)launchViewController;

@end

@interface LYADLaunchViewController : LYBaseViewController

@property (nonatomic, weak) id<LYADLaunchViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
