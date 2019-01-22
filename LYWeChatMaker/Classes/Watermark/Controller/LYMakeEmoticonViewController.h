//
//  LYMakeEmoticonViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  做表情包页

#import "LYBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYMakeEmoticonViewController : LYBaseTableViewController

/** 展示形象功能按钮 */
@property (nonatomic, assign) BOOL emoticonCtl;
/** 展示表情功能按钮 */
@property (nonatomic, assign) BOOL faceCtl;
/** 展示配文功能按钮(默认为YES) */
@property (nonatomic, assign) BOOL sentenceCtl;
/** 表情功能按钮标题 */
@property (nonatomic, copy) NSString *emoticonCtlTitle;
/** 默认展示图片表情(必传参数) */
@property (nonatomic, strong) UIImage *defultEmojiImage;

@end

NS_ASSUME_NONNULL_END
