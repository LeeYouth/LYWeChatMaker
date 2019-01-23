//
//  LYHomePageService.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/23.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageService.h"
#import "LYEmoticonListModel.h"

#define kGETALLEMOJILIST_URL @"https://www.easy-mock.com/mock/5c47ef339f1c8a370307b104/makeemoji/emojiList"

@implementation LYHomePageService

/**
 获取表情包列表
 */
+ (void)getAllEmojiListWithSuccess:(HttpRequestArraySuccess)success
                            failue:(HttpRequestFailed)failue{
    [LYNetworkHelper GET:kGETALLEMOJILIST_URL parameters:[NSDictionary dictionary] showHUD:YES success:^(id  _Nonnull responseObject) {
        NSArray *arr = responseObject[@"data"][@"list"];
        
        NSMutableArray *resArray = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            LYEmoticonListModel *model = [LYEmoticonListModel modelWithJSON:dict];
            model.isLock       = ![[NSUserDefaults standardUserDefaults] boolForKey:model.emoticonId];
            [resArray addObject:model];
        }
        if (success) {
            success(resArray);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
