//
//  LYServerConfig.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  正式、测试配置

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LYServerEnvDevelop,//测试环境
    LYServerEnvProduct,//正式环境
} LYServerEnvType;

@interface LYServerConfig : NSObject

/**
 环境配置
 */
+ (void)setLYConfigEnv:(LYServerEnvType)value;

/**
 获取当前环境配置
 */
+ (LYServerEnvType)LYConfigEnv;

@end
