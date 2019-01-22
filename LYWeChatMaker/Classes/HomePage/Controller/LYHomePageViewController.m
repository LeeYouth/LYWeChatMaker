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
#import "LYHomePageTableViewCell.h"
#import "LYHomePageTitleView.h"
#import "LYMakeEmoticonViewController.h"

#import "LYImagesDownloadManager.h"

@interface LYHomePageViewController ()<TZImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LYHomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupSubViews];
   
    [self loadNewData];
    
}
- (void)setupSubViews{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navBarView.leftBarItemImage = nil;
    self.navBarView.rightBarItemImage = [UIImage imageNamed:@"homepage_rightBarItem"];
    self.navBarView.navColor = LYHomePageColor;
    self.navBarView.hiddenShadow = YES;
    
    self.tableView.backgroundColor = LYHomePageColor;
    LYHomePageTitleView *titleView = [[LYHomePageTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    self.tableView.tableHeaderView = titleView;
}

- (void)loadNewData{
    int maxCount = 3;
    for (int i = 0; i < maxCount; i++) {
        NSString *title = @"";
        NSString *detail = @"";
        NSString *image = @"";
        NSString *type = [NSString stringWithFormat:@"%d",i];
        if (i == 0) {
            title = @"从相册";
            detail = @"为图片添加文字水印";
            image  = @"homePage_fromEmocation";
        }else if (i == 1){
            title = @"表情包";
            detail = @"这里有最逗比的表情包";
            image  = @"homePage_fromPhotoLibary";
        }else if (i == 2){
            title = @"做表情";
            detail = @"自己做一个表情";
            image  = @"homePage_makeEmocation";
        }else if (i == 3){
            title = @"收藏";
            detail = @"我的收藏全在这里哦";
            image  = @"homePage_myCollctions";
        }

        NSDictionary *dict = @{@"title":title,
                               @"detail":detail,
                               @"image":image,
                               @"type":type,
                               };
        [self.dataArray addObject:dict];
    }
    [self.tableView reloadData];
}

#pragma mark - 添加水印
- (void)addWaterMark
{
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

#pragma mark - 选取表情包
- (void)selectPhotoAddMark
{
    LYAllEmoticonsViewController *emoticonsVC = [[LYAllEmoticonsViewController alloc] init];
    [self.navigationController pushViewController:emoticonsVC animated:YES];
}

#pragma mark - 右侧更多
- (void)rightBarItemClick
{
    LYSettingViewController *settingVC = [[LYSettingViewController alloc] init];
    LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:settingVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    UIImage *cropImage = photos[0];
    
    if (cropImage != nil) {
        LYTWatermarkViewController *waterMarkVC = [[LYTWatermarkViewController alloc] init];
        waterMarkVC.targetImage = cropImage;
        [self.navigationController pushViewController:waterMarkVC animated:YES];
    }

}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LYHomePageTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYHomePageTableViewCell *cell = [LYHomePageTableViewCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        //从相册
        [self addWaterMark];
    }else if (indexPath.row == 1){
        //从表情包
        [self selectPhotoAddMark];

    }else if (indexPath.row == 2){
        //做表情
        NSString *imagePath =LYLOADBUDLEIMAGE(@"LYMakeEmoticonEmojisImageResources.bundle", @"10009");
        
        LYMakeEmoticonViewController *makeVC = [[LYMakeEmoticonViewController alloc] init];
        makeVC.emoticonCtl = YES;
        makeVC.faceCtl     = YES;
        makeVC.sentenceCtl = YES;
        makeVC.defultEmojiImage = [UIImage imageWithContentsOfFile:imagePath];
        LYBaseNavigationController *nav = [[LYBaseNavigationController alloc] initWithRootViewController:makeVC];
        [self presentViewController:nav animated:YES completion:nil];
    }else if (indexPath.row == 3){
        //收藏
    }
}



#pragma mark - lazy loading
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
