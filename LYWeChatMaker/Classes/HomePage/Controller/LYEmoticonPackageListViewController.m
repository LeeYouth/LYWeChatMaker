//
//  LYEmoticonPackageListViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYEmoticonPackageListViewController.h"
#import "LYEmoticonPackageListCell.h"

@interface LYEmoticonPackageListViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation LYEmoticonPackageListViewController

- (instancetype)initWithIamgeArray:(NSMutableArray *)imageArray title:(NSString *)title showAdd:(BOOL)showAdd delegate:(id<LYEmoticonPackageListViewControllerDelegate>)delegate{
    self = [super init];
    if (self) {
        self.dataListArray = imageArray;
        self.delegate = delegate;
        self.showAdd  = showAdd;
        if (title.length) {
            self.title = title;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _setupSubViews];
}

- (void)_setupSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 10.0f;
    //最小两行之间的间距
    layout.minimumLineSpacing = 10.0f;
    layout.sectionInset = UIEdgeInsetsMake(10, 10.0f, 0, 10.0f);
    
    CGFloat cellW = (kScreenWidth - 30)/2;
    layout.itemSize = CGSizeMake(cellW, cellW);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView = collectionView;
    collectionView.backgroundColor = LYCellLineColor;
    collectionView.contentInset = UIEdgeInsetsMake(kiPhoneXLater?NAVBAR_HEIGHT:0, 0, kTabbarExtra, 0);
    collectionView.scrollIndicatorInsets = collectionView.contentInset;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
}

- (void)setDataListArray:(NSMutableArray *)dataListArray{
    _dataListArray = dataListArray;
    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataListArray.count + (self.showAdd?1:0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYEmoticonPackageListCell *cell = [LYEmoticonPackageListCell cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];
    cell.image = self.dataListArray[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
    UIImage *image = self.dataListArray[indexPath.row];
    NSArray *arr = [NSArray arrayWithObject:image];
    if (self.delegate && [self.delegate respondsToSelector:@selector(emoticonPackageListViewController:didFinishPickingPhotos:)]) {
        [self.delegate emoticonPackageListViewController:self didFinishPickingPhotos:arr];
    }
}

@end


