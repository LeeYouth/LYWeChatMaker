//
//  LYHomepageCollectionViewCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/4/29.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^LYHomepageCollectionViewCellDidSelected)(NSString *selectType);

@interface LYHomepageCollectionViewCell : UICollectionViewCell


@property (nonatomic,copy) NSString *tagType;

@property (nonatomic,copy) LYHomepageCollectionViewCellDidSelected didSelected;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)getCollectionCellSize;

@end

NS_ASSUME_NONNULL_END
