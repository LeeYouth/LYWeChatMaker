//
//  LYWatermarkEditTextView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/1.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  水印文字输入框

#import <UIKit/UIKit.h>
@class LYWatermarkInputConfig;

typedef void(^LYWatermarkEditTextViewBlock)(LYWatermarkInputConfig *config);

@interface LYWatermarkEditTextView : UIView

/** 视图消失的方法 */
- (void)dismiss;

/** block 内容传递 */
@property (nonatomic,copy) LYWatermarkEditTextViewBlock block;
/** 文字框配置 */
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;

@end
