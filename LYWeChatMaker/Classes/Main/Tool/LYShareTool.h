//
//  LYShareTool.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/13.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>

@interface LYShareTool : NSObject

/** 分享一张图片到三方平台 */
+ (void)shareImage:(UIImage *)image
    toPlatformType:(UMSocialPlatformType)platformType;

@end
