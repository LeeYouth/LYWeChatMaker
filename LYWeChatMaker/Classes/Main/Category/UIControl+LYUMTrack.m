//
//  UIControl+LYUMTrack.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "UIControl+LYUMTrack.h"
#import <objc/runtime.h>

@implementation UIControl (LYUMTrack)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method fromMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
        Method toMethod = class_getInstanceMethod([self class], @selector(zj_sendAction:to:forEvent:));
        
        BOOL didAddMethod = class_addMethod([self class], @selector(sendAction:to:forEvent:), method_getImplementation(toMethod), method_getTypeEncoding(toMethod));
        
        if (didAddMethod) {
            
            class_replaceMethod([self class], @selector(zj_sendAction:to:forEvent:), method_getImplementation(fromMethod), method_getTypeEncoding(fromMethod));
            
        }else{
            method_exchangeImplementations(fromMethod, toMethod);
        }
        
        
    });
}

- (void)zj_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([target isKindOfClass:[UIBarButtonItem class]]) {
        
        UIBarButtonItem *item = (UIBarButtonItem *)target;
        // 在此拼接NSStringFromClass([item.target class])和NSStringFromSelector(item.action)]]
        LYLog(@"swizzing method UIBarButtonItem = %@,%@",NSStringFromClass([item.target class]),NSStringFromSelector(item.action));
        
    }else if ([target isKindOfClass:[UIButton class]]) {
        
        UIButton *button = (UIButton *)target;
        // 在此拼接将NSStringFromClass([target class]) ,NSStringFromSelector(action)和tag三个值给拼起来
        LYLog(@"swizzing method UIButton = %@,%@",NSStringFromClass([button class]),button.titleLabel.text);
        
    }else{
        
        //此处添加你想统计的打点事件
        
        // 在此拼接将NSStringFromClass([target class]) ,NSStringFromSelector(action)和tag三个值给拼起来
        LYLog(@"swizzing method = %@,%@",NSStringFromClass([target class]),NSStringFromSelector(action));
        
    }
    
    return [self zj_sendAction:action to:target forEvent:event];
}

@end
