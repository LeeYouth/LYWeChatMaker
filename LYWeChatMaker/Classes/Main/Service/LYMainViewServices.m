//
//  LYMainViewServices.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/2/12.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMainViewServices.h"
#import "LYLaunchModel.h"

@implementation LYMainViewServices

/**
 获取启动页数据
 */
+ (void)getLaunchDataWithSuccess:(HttpRequestArraySuccess)success
                          failue:(HttpRequestFailed)failue{
    [LYNetworkHelper GET:LYURL_GET_LAUNCH parameters:[NSDictionary dictionary] showHUD:NO success:^(id  _Nonnull responseObject) {
        NSDictionary *resDict = responseObject[@"data"];
        
        NSMutableArray *resArray = [NSMutableArray array];
        LYLaunchModel *model = [LYLaunchModel modelWithJSON:resDict];
        [resArray addObject:model];
        if (success) {
            success(resArray);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


@end
