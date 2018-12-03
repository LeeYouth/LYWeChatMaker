//
//  LYWatermarkEditTextView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/1.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  水印文字输入框

#import <UIKit/UIKit.h>

typedef void(^LYWatermarkEditTextViewBlock)(NSString *inputText);
typedef void(^LYWatermarkEditTextViewColorBlock)(NSString *inputColor);

@interface LYWatermarkEditTextView : UIView

/** 视图消失的方法 */
- (void)dismiss;


@property (nonatomic,copy) LYWatermarkEditTextViewColorBlock colorBlock;
/** block 内容传递 */
@property (nonatomic,copy) LYWatermarkEditTextViewBlock block;
/** 默认显示内容 */
@property (nonatomic,copy) NSString *defultText;

@end
