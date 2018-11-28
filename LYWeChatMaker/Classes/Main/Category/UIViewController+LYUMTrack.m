//
//  UIViewController+LYUMTrack.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "UIViewController+LYUMTrack.h"
#import <UMAnalytics/MobClick.h>
#import <objc/runtime.h>

@implementation UIViewController (LYUMTrack)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method fromMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
        Method toMethod = class_getInstanceMethod([self class], @selector(zj_viewWillAppear:));
        
        BOOL didAddMethod1 = class_addMethod([self class], @selector(viewWillAppear:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
        
        if (didAddMethod1) {
            class_replaceMethod([self class], @selector(zj_viewWillAppear:), method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
        }else{
            method_exchangeImplementations(fromMethod, toMethod);
        }
        
        Method fromMethod2 = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
        Method toMethod2 = class_getInstanceMethod([self class], @selector(zj_viewWillDisappear:));
        
        BOOL didAddMethod2 = class_addMethod([self class], @selector(viewWillDisappear:), method_getImplementation(toMethod2), method_getTypeEncoding(toMethod2));
        
        if (didAddMethod2) {
            class_replaceMethod([self class], @selector(zj_viewWillDisappear:), method_getImplementation(fromMethod2), method_getTypeEncoding(fromMethod2));
        }else{
            method_exchangeImplementations(fromMethod2, toMethod2);
        }
        
        
    });
}

- (void)zj_viewWillAppear:(BOOL)animated
{
    [self zj_viewWillAppear:animated];
    
    if ([LYServerConfig LYConfigEnv] == LYServerEnvProduct) {
        //正式环境，打开友盟页面统计
        NSString *controllerName = [NSString stringWithFormat:@"%@",[[self class] description]];
        [MobClick beginLogPageView:controllerName];
    }
    
    LYLog(@"LY_viewWillAppear = %@",NSStringFromClass([self class]));
}

- (void)zj_viewWillDisappear:(BOOL)animated
{
    [self zj_viewWillDisappear:animated];
    
    if ([LYServerConfig LYConfigEnv] == LYServerEnvProduct) {
        //正式环境，打开友盟页面统计
        NSString *controllerName = [NSString stringWithFormat:@"%@",[[self class] description]];
        [MobClick endLogPageView:controllerName];
    }
    
    LYLog(@"LY_viewWillDisappear = %@",NSStringFromClass([self class]));
}

@end
