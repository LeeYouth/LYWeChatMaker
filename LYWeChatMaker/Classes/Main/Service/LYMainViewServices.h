//
//  LYMainViewServices.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/2/12.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMainViewServices : NSObject
/**
 获取启动页数据
 */
+ (void)getLaunchDataWithSuccess:(HttpRequestArraySuccess)success
                          failue:(HttpRequestFailed)failue;

@end

NS_ASSUME_NONNULL_END
