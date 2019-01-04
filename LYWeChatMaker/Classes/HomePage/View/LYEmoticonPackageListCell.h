//
//  LYEmoticonPackageListCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYEmoticonPackageListCell : UICollectionViewCell

/** 财视学院模型 */
@property (nonatomic,strong) UIImage *image;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;

@end
