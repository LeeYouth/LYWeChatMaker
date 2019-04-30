//
//  LYEmoticonPackageListCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEmoticonModel;

@interface LYEmoticonPackageListCell : UICollectionViewCell

@property (nonatomic,strong) LYEmoticonModel *model;

@property (nonatomic,strong) LYEmoticonHistoryModel *historyModel;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;

@property(nonatomic, copy) LYButtonClickBlock block;

@end
