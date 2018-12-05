//
//  LYTWatermarkImageView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYWatermarkInputConfig;

typedef void(^LYTWatermarkImageViewBlock)();

@interface LYTWatermarkImageView : UIView

/** 背景图 */
@property (nonatomic, strong) UIImage *backImage;
/** 文字框配置 */
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;
@property(nonatomic, copy) LYTWatermarkImageViewBlock success;
/** 保存水印 */
- (void)saveWatermarkImage;

@end
