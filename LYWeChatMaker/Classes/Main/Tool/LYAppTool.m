//
//  LYAppTool.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYAppTool.h"

@implementation LYAppTool

+ (UIViewController *)getCurrentViewController{
    
    UIWindow *result = nil;
    
    do {
        if ([[UIApplication sharedApplication].delegate respondsToSelector:@selector(window)]) {
            result = [[UIApplication sharedApplication].delegate window];
        }
        if (result) {
            break;
        }
    } while (NO);
    
    UIViewController *rootVC =  result.rootViewController;
    
    // 跳转控制器
    UITabBarController *tabBarController = (UITabBarController *)[rootVC.childViewControllers firstObject];
    if (![tabBarController isKindOfClass:[UITabBarController class]]) {
        return nil;
    }
    // 当前选中的导航控制器
    UINavigationController *currentNavigationController = (UINavigationController *)tabBarController.selectedViewController;
    
    // 多态 父类子针指向子类
    UIViewController *vc = currentNavigationController.childViewControllers.lastObject;
    
    return vc;
}

@end
