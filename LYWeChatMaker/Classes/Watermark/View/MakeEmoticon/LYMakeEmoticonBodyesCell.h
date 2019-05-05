//
//  LYMakeEmoticonBodyesCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/17.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYMakeEmoticonViewController.h"
@class LYEmoticonModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYMakeEmoticonBodyesCellBlock)(UIImage *image);

@interface LYMakeEmoticonBodyesCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/** 视图类型 */
@property (nonatomic ,assign) kLYMakeEmoticonViewType viewType;
/** 默认展示图片表情 */
@property (nonatomic, strong) LYEmoticonModel *defultEmojiModel;
/** 保存图片成功回调 */
@property(nonatomic, copy) LYMakeEmoticonBodyesCellBlock success;
/** 按钮事件回调 */
@property(nonatomic, copy) LYButtonClickBlock block;

@end

NS_ASSUME_NONNULL_END
