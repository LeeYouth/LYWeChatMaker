//
//  LYHomePageService.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/23.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYHomePageService : NSObject


/**
 获取表情包列表
 */
+ (void)getAllEmojiListWithSuccess:(HttpRequestArraySuccess)success
                            failue:(HttpRequestFailed)failue;

@end

NS_ASSUME_NONNULL_END
