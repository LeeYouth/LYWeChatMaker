//
//  LYShareTool.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/13.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYShareTool.h"

@implementation LYShareTool


+ (void)shareImage:(UIImage *)image
    toPlatformType:(UMSocialPlatformType)platformType{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:[LYAppTool getCurrentViewController] completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
