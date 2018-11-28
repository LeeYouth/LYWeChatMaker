//
//  LYWKWebViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYBaseViewController.h"
#import <WebKit/WebKit.h>

@interface LYWKWebViewController : LYBaseViewController

/**
 nav的title（选填）
 */
@property (nonatomic, copy) NSString *titleStr;


/**
 初始化网页加载控制器
 
 @param urlString URL地址字符串
 @return 控制器
 */
- (instancetype)initWithURLString:(NSString*)urlString;


/**
 初始化网页加载控制器
 
 @param url URL地址
 @return 控制器
 */
- (instancetype)initWithURL:(NSURL*)url;


@end
