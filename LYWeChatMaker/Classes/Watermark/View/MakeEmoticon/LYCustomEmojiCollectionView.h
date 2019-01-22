//
//  LYCustomEmojiCollectionView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEmoticonModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYCustomEmojiCollectionViewBlock)(NSIndexPath *indexPath, LYEmoticonModel *model);
typedef void(^LYCustomEmojiCollectionViewCurrentIndexBlock)(NSInteger currentPage);

@interface LYCustomEmojiCollectionView : UIView

@property (nonatomic, copy) LYCustomEmojiCollectionViewBlock didSelectItem;
@property (nonatomic, copy) LYCustomEmojiCollectionViewCurrentIndexBlock collectionViewDidScroll;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataArray;

//当前的Item属于哪个页面
+ (NSInteger)currentPageAtItemByIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)dataSourceForPage;

@end

@interface LYCustomEmojiCollectionView (Custom)

+ (LYCustomEmojiCollectionView *)showCustomEmojiCollectionInView:(UIView *)view
                                   didSelectItemAtIndexPathBlock:(LYCustomEmojiCollectionViewBlock)block
                                         collectionViewDidScroll:(LYCustomEmojiCollectionViewCurrentIndexBlock)scroll;

@end



NS_ASSUME_NONNULL_END
