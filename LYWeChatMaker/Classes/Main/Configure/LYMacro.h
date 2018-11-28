//
//  LYMacro.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#ifndef LYMacro_h
#define LYMacro_h

#define LYLog(FORMAT, ...) fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)

//懒加载
#define LY_LAZY(object, assignment) (object = object ?: assignment)

//颜色
#define LYColor(name) [UIColor colorWithHexString:(name)]

/// RGB颜色
#define LYRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//屏幕宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//NSUserDefaults本地化
#define kUserDefault [NSUserDefaults standardUserDefaults]

//是否iPhoneX及以后的设备 1:iPhoneX屏幕 0:传统屏幕
#define kiPhoneXLater ({\
int tmp = 0;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
tmp = 1;\
}else{\
tmp = 0;\
}\
}else{\
tmp = 0;\
}\
tmp;\
})
#define kNavBarExtra (kiPhoneXLater?24:0)
#define kTabbarExtra (kiPhoneXLater?34:0)
#define STATUSBAR_HEIGHT (kiPhoneXLater?24:20)
#define NAVBAR_HEIGHT (64 + kNavBarExtra)
#define TABBAR_HEIGHT (49 + kTabbarExtra)

#define LYBUNDLE_NAME @"LYResources.bundle"
#define LYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: LYBUNDLE_NAME]
#define LYBUNDLE_IMAGEPATH(name)  [[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:(name) ofType:@"png"]

#define LYSystemFont(font)       [UIFont systemFontOfSize:(font)]


#endif /* LYMacro_h */
