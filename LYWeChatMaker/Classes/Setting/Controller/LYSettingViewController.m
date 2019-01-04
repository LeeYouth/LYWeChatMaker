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

@interface LYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *sloganView;

@end

@implementation LYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"更多";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sloganView];

    CGFloat topMargin = iOS11?(NAVBAR_HEIGHT - (kiPhoneXLater?0:STATUSBAR_HEIGHT)):0;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topMargin);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.sloganView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(@(SCREEN_WIDTH/2));
    }];
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    view.backgroundColor = LYCellLineColor;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1?2:1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndertifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = LYColor(LYBlackColorHex);
    titleLabel.font = LYSystemFont(14.f);
    [cell.contentView addSubview:titleLabel];

    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = LYCellLineColor;
    [cell.contentView addSubview:lineView];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(cell);
        make.right.equalTo(cell.mas_right).offset(-50);
        make.left.equalTo(cell.mas_left).offset(15);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.mas_bottom);
        make.height.mas_equalTo(@(LYCellLineHeight));
        make.left.right.equalTo(cell);
    }];
    
    NSString *titleStr = @"";
    if (indexPath.section == 0) {
        titleStr = @"去评分";
    }else{
        if (indexPath.row == 0) {
            titleStr = @"隐私协议";
        }else{
            titleStr = @"关于简单水印";
        }
    }
    titleLabel.text = titleStr;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1444723537"]];

        
//        LYWKWebViewController *viewController = [[LYWKWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:@"noviceManual" ofType:@"html"]]];
//        viewController.titleStr = @"新手手册";
//        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            LYWKWebViewController *viewController = [[LYWKWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:@"privacyAgreement" ofType:@"html"]]];
            viewController.titleStr = @"隐私协议";
            [self.navigationController pushViewController:viewController animated:YES];
        }else{
            LYAboutUsViewController *viewController = [[LYAboutUsViewController alloc] init];
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
    
}
#pragma mark - lazy loadig
- (UITableView *)tableView{
    return LY_LAZY(_tableView, ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        view.delegate = self;
        view.dataSource = self;
        view.showsHorizontalScrollIndicator = NO;
        view.showsVerticalScrollIndicator = NO;
        view.separatorStyle = UITableViewCellSeparatorStyleNone;
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view.scrollEnabled = NO;
        view;
    }));
}
- (UIImageView *)sloganView{
    return LY_LAZY(_sloganView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"easyMarksloganIcon")];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}

@end
