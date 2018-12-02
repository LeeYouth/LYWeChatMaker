//
//  LYTWatermarkImageView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYTWatermarkImageView : UIView

/** 背景图 */
@property (nonatomic, strong) UIImage *backImage;
/** 文字颜色 */
@property (nonatomic, copy) NSString *colorHex;
/** 是否选中了背景颜色 */
@property (nonatomic, assign) BOOL selectBack;

@end
