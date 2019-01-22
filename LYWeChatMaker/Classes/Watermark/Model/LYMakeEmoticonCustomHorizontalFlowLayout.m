//
//  LYMakeEmoticonCustomHorizontalFlowLayout.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonCustomHorizontalFlowLayout.h"
#import "LYMakeEmoticonImageCell.h"
#import "LYCustomEmojiCollectionView.h"

@implementation LYMakeEmoticonCustomHorizontalFlowLayout

- (instancetype)initWidthHorizontalConfig
{
    if (self = [super init]) {
        CGFloat item = [LYMakeEmoticonImageCell item];
        self.sectionInset = UIEdgeInsetsZero;
        self.itemSize = CGSizeMake(item, item);
        self.minimumLineSpacing = 0.0f;
        self.minimumInteritemSpacing = 0.0f;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    NSInteger page = [LYCustomEmojiCollectionView currentPageAtItemByIndexPath:indexPath];
    CGFloat cellItem = [LYMakeEmoticonImageCell item];
    //当前的所在行
    NSInteger currentLine = (indexPath.item - (page * ([LYMakeEmoticonImageCell row] * [LYMakeEmoticonImageCell line]))) / [LYMakeEmoticonImageCell row];
    //当前的所在列
    NSInteger currentRow = (indexPath.item - (page * ([LYMakeEmoticonImageCell row] * [LYMakeEmoticonImageCell line]))) % [LYMakeEmoticonImageCell row];
    CGFloat cellX = (page * self.collectionView.width) + ((currentRow) * cellItem) + self.sectionInset.left;
    CGFloat cellY = currentLine * (cellItem + self.sectionInset.top) + self.sectionInset.top;
    attributes.frame = CGRectMake(cellX, cellY, cellItem, cellItem);
    return attributes;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *customLayoutAttributs = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < self.collectionView.numberOfSections; j ++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:j];
        for (NSInteger i = 0; i < count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            [customLayoutAttributs addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    return customLayoutAttributs;
}

- (CGSize)collectionViewContentSize
{
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    NSInteger page = itemCount % ([LYMakeEmoticonImageCell row] * [LYMakeEmoticonImageCell line]) == 0 ? itemCount / ([LYMakeEmoticonImageCell row] * [LYMakeEmoticonImageCell line]) : (itemCount / ([LYMakeEmoticonImageCell row] * [LYMakeEmoticonImageCell line]) + 1);
    return CGSizeMake(self.collectionView.width * page, 0);
}


@end

