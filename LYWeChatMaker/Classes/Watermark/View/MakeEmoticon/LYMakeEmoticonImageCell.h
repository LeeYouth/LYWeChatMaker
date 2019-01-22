//
//  LYMakeEmoticonImageCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEmoticonModel;

NS_ASSUME_NONNULL_BEGIN

@interface LYMakeEmoticonImageCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

+ (CGFloat)item;
+ (NSInteger)row;
+ (NSInteger)line;

@property (nonatomic, strong) LYEmoticonModel *model;

@end

NS_ASSUME_NONNULL_END
