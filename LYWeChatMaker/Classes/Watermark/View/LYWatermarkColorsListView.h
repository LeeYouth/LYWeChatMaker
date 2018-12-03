//
//  LYWatermarkColorsListView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  颜色列表

#import <UIKit/UIKit.h>
@class LYWatermarkColorsListViewItem,LYWatermarkColorHexModel;

typedef void(^LYWatermarkColorsListViewDidSelectColorHexBlock)(NSString *colorHex);
typedef void(^LYWatermarkColorsListViewDidSelectBackBlock)(BOOL hasSelect);

#define LYWatermarkColorsListViewH  70

@interface LYWatermarkColorsListView : UIView

/** 数据源 */
@property(nonatomic, strong) NSMutableArray *colorArray;
/** 点击颜色 */
@property(nonatomic, copy) LYWatermarkColorsListViewDidSelectColorHexBlock didSelectItemblock;
/** 点击背景颜色 */
@property(nonatomic, copy) LYWatermarkColorsListViewDidSelectBackBlock didBackblock;

/** 显示选择背景颜色按钮（默认为NO） */
@property(nonatomic, assign) BOOL showSelectButton;
/** 默认颜色色值 */
@property(nonatomic, copy) NSString *defultColorHex;

@end


@interface LYWatermarkColorsListViewItem : UICollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;
/** 颜色model */
@property (nonatomic, strong) LYWatermarkColorHexModel *hexModel;

@end


@interface LYWatermarkColorHexModel : NSObject
/** 颜色 */
@property (nonatomic, strong) NSString *colorHex;
/** 默认是否选中 */
@property (nonatomic, assign) BOOL hasSelect;
@end
