//
//  LYHomepageController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/4/28.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYHomepageController.h"
#import "LYHomepageCollectionViewCell.h"
#import "LYEmoticonModel.h"
#import "LYHomePageViewController.h"

@interface LYHomepageController ()<UICollectionViewDataSource, UICollectionViewDelegate,GADInterstitialDelegate>
{
    NSInteger _currentIndex;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;//数据源

@end

@implementation LYHomepageController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //加载数据
    [self loadLocalData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.rightBarItemImage = [UIImage imageNamed:@"homepage_rightitemicon"];
    self.navBarView.navColor = LYHomePageColor;

    [self _setupSubViews];
    
    _currentIndex = -1;
    
}

#pragma mark - 右侧更多
- (void)rightBarItemClick{

    LYHomePageViewController *settingVC = [[LYHomePageViewController alloc] init];
    LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:settingVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)_setupSubViews{
 
    CGFloat topMargin = NAVBAR_HEIGHT;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topMargin);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)loadLocalData{
    NSArray *resultArray = [LYEmoticonHistoryModel bg_findAll:kLYEMOJIHISTORYTABLENAME];
    if (resultArray.count) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:resultArray];
    }
    [self.collectionView reloadData];
    LYLog(@"resultArray = %@",resultArray);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYEmoticonHistoryModel *localModel = self.dataArray[indexPath.row];
    LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
//    model.emoticonUrl = localModel.imagePath;
    WEAKSELF(weakSelf);
    LYHomepageCollectionViewCell *cell = [LYHomepageCollectionViewCell cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];

    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)saveImageClick:(UIImage *)savedImage{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        
    }else{
        msg = @"保存图片成功" ;
    }
    [LYToastTool bottomShowWithText:msg delay:1.5f];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat cellW = (kScreenWidth - 40)/3;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 10.0f;
        //最小两行之间的间距
        layout.minimumLineSpacing = 10.0f;
        layout.sectionInset = UIEdgeInsetsMake(10, 10.0f, 0, 10.0f);
        layout.itemSize = CGSizeMake(cellW, cellW);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = LYColor(LYWhiteColorHex);
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}

@end
