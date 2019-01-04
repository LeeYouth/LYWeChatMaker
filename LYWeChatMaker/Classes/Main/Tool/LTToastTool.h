//
//  LTToastTool.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGProgressHUD.h"
#import "SVProgressHUD.h"

@interface LTToastTool : NSObject


/** loading的HUD */
+ (void)showLoadingWithStatus:(NSString *)text;

/** loading的HUD（需要显示在view上） */
+ (void)showLoadingWithView:(UIView *)view;

/** view中间显示文本提示。 */
+ (void)centerShowWithText:(NSString *)text delay:(NSTimeInterval)delay;

/** view底部显示文本提示。 */
+ (void)bottomShowWithText:(NSString *)text delay:(NSTimeInterval)delay;

/** view底部显示文本提示2。 */
+ (void)bottomShowWithView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay;

/** 成功提示 */
+ (void)showSuccessWithStatus:(NSString *)text;

/** 错误提示 */
+ (void)showErrorWithStatus:(NSString *)text;

/** HUD消失 */
+ (void)dismiss;

@end
