//
//  LYMakeEmoticonViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  做表情包页

#import "LYBaseTableViewController.h"
#import "LYEmoticonModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    kLYMakeEmoticonView_DIYEmoji,//DIY表情
    kLYMakeEmoticonView_xmrEmoji,//熊猫人
    kLYMakeEmoticonView_mgtEmoji,//蘑菇头
    kLYMakeEmoticonView_txt,//纯文字
} kLYMakeEmoticonViewType;

@interface LYMakeEmoticonViewController : LYBaseTableViewController

- (instancetype)initWithViewType:(kLYMakeEmoticonViewType)viewType;

/** 默认展示图片表情(必传参数) */
@property (nonatomic, strong) LYEmoticonModel *defultEmojiModel;

@end

NS_ASSUME_NONNULL_END
