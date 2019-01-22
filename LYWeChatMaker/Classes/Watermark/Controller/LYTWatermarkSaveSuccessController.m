//
//  LYTWatermarkSaveSuccessController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSaveSuccessController.h"
#import "LYTWatermarkSuccessHeadCell.h"
#import "LYTWatermarkSuccessShareCell.h"
#import "LYTWatermarkSuccessSectionCell.h"
#import "LYShareTool.h"

@interface LYTWatermarkSaveSuccessController ()<GADBannerViewDelegate>

@property (nonatomic, strong) GADBannerView *bannerView;//底部广告
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation LYTWatermarkSaveSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    if (!self.hiddenCollection) {
//        self.title = self.hiddenCollection?@"我的收藏":@"保存/分享";
//        self.navBarView.rightBarItemImage = [UIImage imageNamed:@"saveSuccess_rightItemIcon"];
//    }
    
    self.title = @"保存/分享";
    self.navBarView.rightBarItemImage = [UIImage imageNamed:@"saveSuccess_rightItemIcon"];

    self.tableView.backgroundColor =LYColor(LYWhiteColorHex);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addGoogleAdmob];
    
    [self loadDataRequest];
}

- (void)rightBarItemClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadDataRequest{
//    int maxCount = self.hiddenCollection?2:3;
    int maxCount = 2;
    for (int i = 0; i < maxCount; i++) {
        NSString *title = @"";
        NSString *image = @"";
        NSString *type = [NSString stringWithFormat:@"%d",i];
        if (i == 0) {
            title = @"发送给朋友";
            image  = @"saveSuccess_shareWechat";
        }else if (i == 1){
            title = @"分享到朋友圈";
            image  = @"saveSuccess_shareWechatFriend";
        }else if (i == 2){
            title = @"收藏";
            image  = @"saveSuccess_shareWechatFriend";
        }
        
        NSDictionary *dict = @{@"title":title,
                               @"image":image,
                               @"type":type,
                               };
        [self.dataArray addObject:dict];
    }
    [self.tableView reloadData];
}

- (void)addGoogleAdmob{
    int maxCount = self.hiddenCollection?3:4;

    CGFloat backH = SCREEN_HEIGHT - [LYTWatermarkSuccessHeadCell getCellHeight] - maxCount*56 - NAVBAR_HEIGHT;

    CGFloat adHeight = kGADAdSizeLargeBanner.size.height;
    LYLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    self.bannerView = [[GADBannerView alloc] initWithFrame:CGRectMake(0, backH - adHeight - kTabbarExtra, SCREEN_WIDTH, adHeight)];
    self.bannerView.delegate = self;
    
    
    UIView *backView = [UIView new];
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, backH);
    [backView addSubview:self.bannerView];
    self.tableView.tableFooterView = backView;
    
    self.bannerView.adUnitID = [LYServerConfig LYConfigEnv] == LYServerEnvProduct?GOOGLEAD_UNITID:GOOGLEAD_TEST_UNITID;
    self.bannerView.rootViewController = self;
    GADRequest *request = [GADRequest request];
    if ([LYServerConfig LYConfigEnv] != LYServerEnvProduct) {
        request.testDevices = @[ kGADSimulatorID ];
    }
    [self.bannerView loadRequest:request];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2 + self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self tableView:tableView cellForRowAtIndexPath:indexPath].height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LYTWatermarkSuccessHeadCell *cell = [LYTWatermarkSuccessHeadCell cellWithTableView:tableView];
        cell.backImage = self.backImage;
        return cell;
    }else if (indexPath.row == 1){
        LYTWatermarkSuccessSectionCell *cell = [LYTWatermarkSuccessSectionCell cellWithTableView:tableView];
        return cell;
    }
    LYTWatermarkSuccessShareCell *cell = [LYTWatermarkSuccessShareCell cellWithTableView:tableView];
    cell.model = self.dataArray[indexPath.row - 2];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
 
    
    if (indexPath.row == 2) {
        //微信聊天
        [LYShareTool shareImage:self.backImage toPlatformType:UMSocialPlatformType_WechatSession];
    }else if(indexPath.row == 3){
        //微信朋友圈
        [LYShareTool shareImage:self.backImage toPlatformType:UMSocialPlatformType_WechatTimeLine];
    }else if(indexPath.row == 4){
        //收藏
//        [LYShareTool shareImage:self.backImage toPlatformType:UMSocialPlatformType_WechatTimeLine];
    }
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
