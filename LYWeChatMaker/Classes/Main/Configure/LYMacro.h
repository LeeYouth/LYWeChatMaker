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
//加载plist文件
#define LYBUNDLE_PLISTPATH(name)  [[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:(name) ofType:@"plist"]
#define LYBUNDLE_IMAGEPATH(name)  [[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:(name) ofType:@"png"]

//加载bundle图片
#define LYLOADBUDLEIMAGE(bundleName,sourceName) ({\
NSString *tmp = @"";\
if ([[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"jpg"].length) {\
tmp = [[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"jpg"];\
}else{\
tmp = [[NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: (bundleName)]] pathForResource:(sourceName) ofType:@"png"];\
}\
tmp;\
})

#define LYSystemFont(font)       [UIFont systemFontOfSize:(font)]

//资源最后一张图片
//熊猫人资源最后一张图片
#define kXMRRESOURCELASTNAME @"10058"
//蘑菇头资源最后一张图片
#define kMGTRESOURCELASTNAME @"10037"

//表情最后一张图片
#define kMAKEMOJIFACERESOURCELASTNAME @"10052"
//形象最后一张图片
#define kMAKEMOJIEMCTICONESOURCELASTNAME @"10048"

//主题颜色
#define LYThemeColor       LYColor(@"#FE4365")
//主题线的颜色
#define LYCellLineColor       LYColor(@"#EEEEEE")
//主题线的高度
#define LYCellLineHeight       0.8f
//主题tableview背景色
#define LYTableViewBackColor       LYColor(@"#EEEDEE")
//主题导航栏默认颜色
#define LYNavBarBackColor       LYColor(@"#ffffff")
//白色
#define LYWhiteColorHex       @"#FFFFFF"
//黑色
#define LYBlackColorHex       @"#000000"
#define LYClearColor       [UIColor clearColor]


//按钮颜色
#define LYButtonThemeColor       LYColor(@"#428BCA")
//首页的背景颜色
#define LYHomePageColor       LYColor(@"#ffffff")
//图片背景颜色
#define LYImageBackColor       LYColor(LYBlackColorHex)

//样式高度
#define LYWatermarkStyleViewH  (70 + kTabbarExtra)
//样式颜色
#define LYWatermarkStyleColor  LYColor(@"#ffffff")

//样式的圆角
#define kLYViewCornerRadius   2.f
//样式的圆角边框颜色
#define kLYViewBorderColor    LYColor(@"#EAEAEA")
//样式的圆角边框宽度
#define kLYViewBorderWidth   0.3


#define LYWatermarkInputViewDefultText @"点击添加文字"


#define kLYWatermarkColorsListViewH  70
#define kLYWatermarkBottomBtnsViewH 44.f

#define kLYHomepageItemSizeLeft 36.f
#define kLYHomepageItemSizeWidth ((kScreenWidth - 3*kLYHomepageItemSizeLeft)/2)

#define kLYTWatermarkBottomToolBarH (kLYWatermarkColorsListViewH + kLYWatermarkBottomBtnsViewH + kTabbarExtra)

#define kLYTWatermarkImageMaxSize CGSizeMake(kScreenWidth, kScreenHeight - NAVBAR_HEIGHT - kLYTWatermarkBottomToolBarH)


//按钮点击block
typedef void(^LYButtonClickBlock)(UIButton *sender);

#endif /* LYMacro_h */
