//
//  LYMakeEmoticonBodyesCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/17.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYMakeEmoticonBodyesCellBlock)(UIImage *image);

@interface LYMakeEmoticonBodyesCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 展示形象功能按钮(默认为YES) */
- (void)showeEmoticonCtls:(BOOL)show;
/** 展示表情功能按钮(默认为NO) */
- (void)showeFaceCtls:(BOOL)show;
/** 展示配文功能按钮(默认为YES) */
- (void)showeSentenceCtls:(BOOL)show;
/** 表情功能按钮标题 */
@property (nonatomic, copy) NSString *emoticonCtlTitle;
/** 默认展示图片表情 */
@property (nonatomic, strong) UIImage *defultEmojiImage;
/** 保存图片成功回调 */
@property(nonatomic, copy) LYMakeEmoticonBodyesCellBlock success;
/** 按钮事件回调 */
@property(nonatomic, copy) LYButtonClickBlock block;

@end

NS_ASSUME_NONNULL_END
