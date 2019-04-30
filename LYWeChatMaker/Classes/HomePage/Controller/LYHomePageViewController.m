//
//  LYHomePageViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageViewController.h"
#import "LYTWatermarkViewController.h"
#import "LYSettingViewController.h"
#import "LYEmoticonPackageListViewController.h"
#import "LYAllEmoticonsViewController.h"
#import "LYMakeEmoticonViewController.h"
#import "LYHomepageCollectionViewCell.h"

@interface LYHomePageViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate,LYEmoticonPackageListViewControllerDelegate>
{
    NSInteger _selectIndex;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *xmrDataArray;//熊猫人
@property (nonatomic, strong) NSMutableArray *mgtDataArray;//蘑菇头

@end

@implementation LYHomePageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    bg_setDebug(YES);//打开调试模式,打印输出调试信息.
    NSArray *resultArray = [LYEmoticonHistoryModel bg_findAll:kLYEMOJIHISTORYTABLENAME];
    LYLog(@"resultArray = %@",resultArray);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
    
    [self loadNewData];
    
}

- (void)setupSubViews{
    
    UIImageView *imageView = [UIImageView new];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYResources.bundle", @"homepage_backimage")];
    [self.view addSubview:imageView];
    [self.view addSubview:self.collectionView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    CGFloat collectionH = ((self.dataArray.count/2) + 1)*kLYHomepageItemSizeLeft + (self.dataArray.count/2)*kLYHomepageItemSizeWidth;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(collectionH));
        make.centerX.centerY.equalTo(self.view);
    }];
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.navColor = [UIColor clearColor];
    self.navBarView.titleImage = [UIImage imageNamed:@"homepage_logo"];
    self.navBarView.hiddenLineView = YES;

}

- (void)loadNewData{
    
    [self.collectionView reloadData];
}

#pragma mark - 添加水印
- (void)addWaterMark{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    // 不让选择视频和原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.allowPreview = NO;
    imagePickerVc.naviBgColor = LYNavBarBackColor;
    imagePickerVc.naviTitleColor = LYColor(LYWhiteColorHex);
    imagePickerVc.barItemTextColor = LYColor(LYWhiteColorHex);
    imagePickerVc.preferredLanguage = @"zh-Hans";
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    UIImage *cropImage = photos[0];
    
    if (cropImage != nil) {
        LYTWatermarkViewController *waterMarkVC = [[LYTWatermarkViewController alloc] init];
        waterMarkVC.targetImage = cropImage;
        [self.navigationController pushViewController:waterMarkVC animated:YES];
    }
    
}



#pragma mark <UICollectionViewDataSource>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [LYHomepageCollectionViewCell getCollectionCellSize];
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.0000001;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    //每个item间距
    return kLYHomepageItemSizeLeft;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //左右距边距的距离20
    CGFloat leftMargin = kLYHomepageItemSizeLeft;
    return  UIEdgeInsetsMake(leftMargin, leftMargin, 0, leftMargin);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF(weakSelf);
    LYHomepageCollectionViewCell *cell = [LYHomepageCollectionViewCell cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];
    cell.tagType = self.dataArray[indexPath.row];
    cell.didSelected = ^(NSString * _Nonnull selectType) {
        [weakSelf didSelectTagType:selectType];
    };
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - LYEmoticonPackageListViewControllerDelegate
- (void)emoticonPackageListViewController:(LYEmoticonPackageListViewController *)lister didFinishPickingPhotos:(NSArray<LYEmoticonModel *> *)photos{
    LYEmoticonModel *model = photos[0];
    if (model != nil) {
        
        LYMakeEmoticonViewController *makeVC = [[LYMakeEmoticonViewController alloc] init];
        makeVC.emoticonCtl = YES;
        makeVC.faceCtl     = NO;
        makeVC.sentenceCtl = YES;
        makeVC.emoticonCtlTitle = _selectIndex == 0?@"熊猫人":@"蘑菇头";
        makeVC.defultEmojiModel  = model;
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:makeVC];
        [self presentViewController:nav animated:YES completion:nil];
        
    }
}

- (void)didSelectTagType:(NSString *)tagType{
    if ([tagType isEqualToString:@"photo"]) {
        //从相册
        [self addWaterMark];
    }else if ([tagType isEqualToString:@"xmrEmoji"]){
        //熊猫人
        _selectIndex = 0;
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:self.xmrDataArray title:@"熊猫人" showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];
    }else if ([tagType isEqualToString:@"mgtEmoji"]){
        //蘑菇头
        _selectIndex = 1;
        LYEmoticonPackageListViewController *imagePickerVc = [[LYEmoticonPackageListViewController alloc] initWithIamgeArray:self.mgtDataArray title:@"蘑菇头" showAdd:NO delegate:self];
        [self.navigationController pushViewController:imagePickerVc animated:YES];
    }else if ([tagType isEqualToString:@"diyEmoji"]){
        //做表情
        LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
        model.bundleName = @"LYMakeEmoticonEmojisImageResources.bundle";
        model.bundleImageName = @"10009";
        
        LYMakeEmoticonViewController *makeVC = [[LYMakeEmoticonViewController alloc] init];
        makeVC.emoticonCtl = YES;
        makeVC.faceCtl     = YES;
        makeVC.sentenceCtl = YES;
        makeVC.defultEmojiModel = model;
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:makeVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else if ([tagType isEqualToString:@"text"]){
        //做表情
        LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
        model.bundleName = @"LYMakeEmoticonEmojisImageResources.bundle";
        model.bundleImageName = @"10009";
        
        LYMakeEmoticonViewController *makeVC = [[LYMakeEmoticonViewController alloc] init];
        makeVC.emoticonCtl = YES;
        makeVC.faceCtl     = YES;
        makeVC.sentenceCtl = YES;
        makeVC.defultEmojiModel = model;
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:makeVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else if ([tagType isEqualToString:@"setting"]){
        //设置
        LYSettingViewController *settingVC = [[LYSettingViewController alloc] init];
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:settingVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}



#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@"photo",@"xmrEmoji",@"mgtEmoji",@"diyEmoji",@"text",@"setting"]];
    }
    return _dataArray;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kLYHomepageItemSizeWidth, kLYHomepageItemSizeWidth);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}
- (NSMutableArray *)xmrDataArray{
    if (!_xmrDataArray) {
        _xmrDataArray = [NSMutableArray array];
        //熊猫人
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kXMRRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYXMRImageResources.bundle";
            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.unLock        = [[NSUserDefaults standardUserDefaults] boolForKey:fileName];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            [imageArray addObject:model];
        }
        _xmrDataArray = imageArray;
    }
    return _xmrDataArray;
}
- (NSMutableArray *)mgtDataArray{
    if (!_mgtDataArray) {
        _mgtDataArray = [NSMutableArray array];
        //蘑菇头
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kMGTRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr  = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYMGTImageResources.bundle";
            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.unLock        = [[NSUserDefaults standardUserDefaults] boolForKey:fileName];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            [imageArray addObject:model];
        }
        _mgtDataArray = imageArray;
    }
    return _mgtDataArray;
}


@end
