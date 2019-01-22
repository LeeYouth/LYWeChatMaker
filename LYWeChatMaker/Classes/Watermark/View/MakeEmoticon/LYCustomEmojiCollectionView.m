//
//  LYCustomEmojiCollectionView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYCustomEmojiCollectionView.h"
#import "LYMakeEmoticonCustomHorizontalFlowLayout.h"
#import "LYMakeEmoticonImageCell.h"
#import "LYEmoticonModel.h"

static NSString *kLYCustomEmojiIdentifier = @"LYCustomEmojiCollectionViewIdentifier";

@interface LYCustomEmojiCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LYMakeEmoticonCustomHorizontalFlowLayout *collectionLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LYCustomEmojiCollectionView

- (instancetype)init
{
    CGFloat height = ceil(([LYMakeEmoticonImageCell item] * [LYMakeEmoticonImageCell line]));
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, height);
    if (self = [super initWithFrame:rect]) {
        
        self.backgroundColor = LYColor(LYWhiteColorHex);
        //表情列表
        
        //使用UICollectionView替代UIScrollView做翻页,collectionView的farme初始化必须有值
        _collectionLayout = [[LYMakeEmoticonCustomHorizontalFlowLayout alloc] initWidthHorizontalConfig];
        
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, height) collectionViewLayout:self.collectionLayout];
        
        _collectionView.dataSource = self;
        _collectionView.delegate   = self;
        
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.alwaysBounceHorizontal = YES;
        
        self.collectionView.pagingEnabled = YES;
        self.collectionView.backgroundColor = LYColor(LYWhiteColorHex);
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[LYMakeEmoticonImageCell class] forCellWithReuseIdentifier:kLYCustomEmojiIdentifier];
    }
    return self;
}


+ (NSInteger)currentPageAtItemByIndexPath:(NSIndexPath *)indexPath
{
    NSInteger page = indexPath.item / ([LYMakeEmoticonImageCell line] * [LYMakeEmoticonImageCell row]);
    return page;
}

- (NSInteger)dataSourceForPage
{
    NSInteger page = (self.dataSource.count / ([LYMakeEmoticonImageCell line] * [LYMakeEmoticonImageCell row]));
    NSInteger module = (self.dataSource.count % ([LYMakeEmoticonImageCell line] * [LYMakeEmoticonImageCell row]));
    if (module > 0) {
        page = ((self.dataSource.count - module) / ([LYMakeEmoticonImageCell line] * [LYMakeEmoticonImageCell row])) + 1;
    }
    return page;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.dataSource.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count > 0) {
        return self.dataSource.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LYMakeEmoticonImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLYCustomEmojiIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[LYMakeEmoticonImageCell alloc] init];
    }
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.didSelectItem) {
        LYEmoticonModel *model = self.dataSource[indexPath.row];
        self.didSelectItem(indexPath, model);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ((NSInteger)self.collectionView.contentOffset.x % (NSInteger)self.width == 0) {
        NSInteger currentPage = self.collectionView.contentOffset.x / self.width;
        if (self.collectionViewDidScroll) {
            self.collectionViewDidScroll(currentPage);
        }
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    
    self.dataSource = dataArray;
    
    [self.collectionView reloadData];
}


@end

@implementation LYCustomEmojiCollectionView (Custom)

+ (LYCustomEmojiCollectionView *)showCustomEmojiCollectionInView:(UIView *)view
                                   didSelectItemAtIndexPathBlock:(LYCustomEmojiCollectionViewBlock)block
                                         collectionViewDidScroll:(LYCustomEmojiCollectionViewCurrentIndexBlock)scroll
{
    LYCustomEmojiCollectionView *emojiView = [[LYCustomEmojiCollectionView alloc] init];
    emojiView.didSelectItem = ^(NSIndexPath * _Nonnull indexPath, LYEmoticonModel * _Nonnull model) {
        if (block) {
            block(indexPath, model);
        }
    };
    emojiView.collectionViewDidScroll = ^(NSInteger currentPage) {
        if (scroll) {
            scroll(currentPage);
        }
    };
    [view addSubview:emojiView];
    return emojiView;
}

@end

