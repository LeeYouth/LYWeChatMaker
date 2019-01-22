//
//  LYMakeEmoticonSelectFaceView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  选一张表情图片

#import <UIKit/UIKit.h>
#import "LYCustomEmojiCollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYMakeEmoticonSelectFaceView : UIView

+ (instancetype)sharedInstance;
- (void)showInViewWithAnimated:(BOOL)animated;

/** 选中的数据 */
@property(nonatomic, copy) LYCustomEmojiCollectionViewBlock didSelectBlock;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSourece;


@end

NS_ASSUME_NONNULL_END
