//
//  LTToastTool.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LTToastTool.h"
#import "MTLoadingHUD.h"
#import "MTProgressHUDManager.h"

#define TOAST_TIMEOUT 20
#define kDefaultView [UIApplication sharedApplication].delegate.window

@interface LTToastTool ()

@end

@implementation LTToastTool

#pragma mark - loading的HUD
+ (void)showLoadingWithStatus:(NSString *)text{
    
    //    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    
    [MTProgressHUDManager hide];
    [MTProgressHUDManager showProgressCircleNoValue:@"" inView:kDefaultView dimBackground:YES];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    //    [MTLoadingHUD showIn:kDefaultView];
    
}

#pragma mark - view中间显示文本提示。
+ (void)centerShowWithText:(NSString *)text delay:(NSTimeInterval)delay{
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    [MTProgressHUDManager hide];
    
    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 0, 50);
    [HUD showInView:kDefaultView];
    [HUD dismissAfterDelay:delay];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        JGProgressHUD *HUD = [self newJGHUD];
    //        HUD.indicatorView = nil;
    //        HUD.textLabel.text = text;
    //        HUD.cornerRadius = 5;
    //        HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    //        HUD.position = JGProgressHUDPositionCenter;
    //        HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //        HUD.marginInsets = UIEdgeInsetsMake(0, 50, 0, 50);
    //        [HUD showInView:kDefaultView];
    //        [HUD dismissAfterDelay:delay];
    //    });
}

#pragma mark - view底部显示文本提示。
+ (void)bottomShowWithText:(NSString *)text delay:(NSTimeInterval)delay{
    
    [MTProgressHUDManager hide];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    
    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 60, 50);
    [HUD showInView:kDefaultView];
    [HUD dismissAfterDelay:delay];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        JGProgressHUD *HUD = [self newJGHUD];
    //        HUD.indicatorView = nil;
    //        HUD.textLabel.text = text;
    //        HUD.cornerRadius = 5;
    //        HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    //        HUD.position = JGProgressHUDPositionBottomCenter;
    //        HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    //        HUD.marginInsets = UIEdgeInsetsMake(0, 50, 60, 50);
    //        [HUD showInView:kDefaultView];
    //        [HUD dismissAfterDelay:delay];
    //    });
}

#pragma mark - 错误提示
+ (void)showSuccessWithStatus:(NSString *)text{
    
    [MTProgressHUDManager hide];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    
    [self newSVHUDClearType];
    [SVProgressHUD showSuccessWithStatus:text];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        [self newSVHUDClearType];
    //        [SVProgressHUD showSuccessWithStatus:text];
    //    });
}

#pragma mark - 成功提示
+ (void)showErrorWithStatus:(NSString *)text{
    
    [MTProgressHUDManager hide];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    
    [self newSVHUDClearType];
    [SVProgressHUD showErrorWithStatus:text];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        [self newSVHUDClearType];
    //        [SVProgressHUD showErrorWithStatus:text];
    //    });
}

#pragma mark - hud消失
+ (void)dismiss{
    
    [MTProgressHUDManager hide];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    
}


#pragma mark - view底部显示文本提示2。
+ (void)bottomShowWithView:(UIView *)view text:(NSString *)text delay:(NSTimeInterval)delay{
    
    [MTProgressHUDManager hide];
    
    //    [MTLoadingHUD hideIn:kDefaultView];
    
    JGProgressHUD *HUD = [self newJGHUD];
    HUD.indicatorView = nil;
    HUD.textLabel.text = text;
    HUD.cornerRadius = 5;
    HUD.textLabel.font = [UIFont systemFontOfSize:15.f];
    HUD.position = JGProgressHUDPositionBottomCenter;
    HUD.contentInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    HUD.marginInsets = UIEdgeInsetsMake(0, 50, 60, 50);
    [HUD showInView:view];
    [HUD dismissAfterDelay:delay];
    
}

#pragma mark - loading的HUD
+ (void)showLoadingWithView:(UIView *)view{
    [MTProgressHUDManager hide];
    [MTProgressHUDManager showProgressCircleNoValue:@"" inView:view dimBackground:YES];
}

#pragma mark - private methd
#pragma mark 初始化可点击的HUD
+ (void)newSVHUDNoneType{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
#pragma mark 初始化不可点击的HUD
+ (void)newSVHUDClearType{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
#pragma mark 初始化不可点击的JGHUD
+ (JGProgressHUD *)newJGHUD{
    JGProgressHUD *currentHUD = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleDark];
    currentHUD.interactionType = JGProgressHUDInteractionTypeBlockAllTouches;
    return currentHUD;
}



@end
