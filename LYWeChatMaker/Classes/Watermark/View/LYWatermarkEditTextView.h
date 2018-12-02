//
//  LYWatermarkEditTextView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/1.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  水印文字输入框

#import <UIKit/UIKit.h>

typedef void(^LYWatermarkEditTextViewBlock)(NSString *inputText);

@interface LYWatermarkEditTextView : UIView

/** 视图消失的方法 */
- (void)dismiss;

/** block 内容传递 */
@property (nonatomic,copy) LYWatermarkEditTextViewBlock block;

@end
