//
//  LYTWatermarkSaveSuccessController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseTableViewController.h"

typedef void(^LYTWatermarkSaveSuccessControllerBlock)();

@interface LYTWatermarkSaveSuccessController : LYBaseTableViewController

/** 背景图 */
@property (nonatomic, strong) UIImage *backImage;
/** 隐藏收藏 */
@property (nonatomic, assign) BOOL hiddenCollection;

@property (nonatomic, copy) LYTWatermarkSaveSuccessControllerBlock dismissSuccess;


@end
