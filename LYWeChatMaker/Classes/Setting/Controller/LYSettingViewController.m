//
//  LYSettingViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYSettingViewController.h"
#import "LYAboutUsViewController.h"
#import "LYWKWebViewController.h"
#import "LYCustomNavgationBarView.h"
#import "LYSettingTableViewCell.h"
#import "LYNoviceManualViewController.h"

@interface LYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *sloganView;

@end

@implementation LYSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.navBarView.leftBarItemImage = [UIImage imageNamed:@"bottomToolBar_close"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sloganView];

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navBarView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.sloganView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];
    

}

- (void)backBarItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
    view.backgroundColor = LYTableViewBackColor;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYSettingTableViewCell *cell = [LYSettingTableViewCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.introTitle = @"看看新手怎么使用咧";
        cell.title      = @"新手指南";
        cell.showIndicator = YES;
    }else if (indexPath.section == 1) {
        cell.introTitle = @"给我们鼓励鼓励呗";
        cell.title      = @"去评分";
        cell.showIndicator = YES;
    }else if (indexPath.section == 2){
        cell.introTitle = @"我们很注重隐私(咳咳";
        cell.title      = @"隐私协议";
        cell.showIndicator = YES;
    }else if (indexPath.section == 3){
        cell.introTitle = @"您可以了解我们更多哦";
        cell.title      = [NSString stringWithFormat: @"关于%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        cell.showIndicator = YES;
    }else if (indexPath.section == 4){
        cell.introTitle = @"我们现在的版本啦";
        cell.title      = [NSString stringWithFormat: @"版本号v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        cell.showIndicator = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
        LYNoviceManualViewController *xinVC = [[LYNoviceManualViewController  alloc] init];
        [self.navigationController pushViewController:xinVC animated:YES];
    }else if (indexPath.section == 1) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1444723537"]];

    }else if (indexPath.section == 2){
        LYWKWebViewController *viewController = [[LYWKWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:@"privacyAgreement" ofType:@"html"]]];
        viewController.titleStr = @"隐私协议";
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.section == 3){
        LYAboutUsViewController *viewController = [[LYAboutUsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.section == 4){
        NSString *str = [NSString stringWithFormat: @"当前版本号v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }
    
}
#pragma mark - lazy loadig
- (UITableView *)tableView{
    return LY_LAZY(_tableView, ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.delegate = self;
        view.dataSource = self;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view;
    }));
}
- (UIImageView *)sloganView{
    return LY_LAZY(_sloganView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"easyMarkAppIcon")];
        view.layer.cornerRadius = 6;
        view.layer.masksToBounds = YES;
        view.hidden = YES;
        view;
    }));
}


@end
