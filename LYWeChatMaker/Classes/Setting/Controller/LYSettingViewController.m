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
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation LYSettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.navBarView.leftBarItemImage = [UIImage imageNamed:@"navBar_closeicon"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sloganView];

    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVBAR_HEIGHT);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.sloganView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-TABBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(86, 86));
    }];
    

    [self.tableView reloadData];
}

- (void)backBarItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LYSettingTableViewCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYSettingTableViewCell *cell = [LYSettingTableViewCell cellWithTableView:tableView];
    cell.title = self.titleArray[indexPath.row];
    cell.iconName = self.imageArray[indexPath.row];
    if (indexPath.row == 4) {
        cell.showIndicator = NO;
    }else{
        cell.showIndicator = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        LYNoviceManualViewController *xinVC = [[LYNoviceManualViewController  alloc] init];
        [self.navigationController pushViewController:xinVC animated:YES];
    }else if (indexPath.row == 1) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1444723537"]];

    }else if (indexPath.row == 2){
        LYWKWebViewController *viewController = [[LYWKWebViewController alloc] initWithURL:[NSURL fileURLWithPath:[[NSBundle bundleWithPath:LYBUNDLE_PATH] pathForResource:@"privacyAgreement" ofType:@"html"]]];
        viewController.titleStr = @"隐私协议";
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 3){
        LYAboutUsViewController *viewController = [[LYAboutUsViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else if (indexPath.row == 4){
        NSString *str = [NSString stringWithFormat: @"当前版本号v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        [LYToastTool bottomShowWithText:str delay:1.f];
    }
    
}
#pragma mark - lazy loadig
- (UITableView *)tableView{
    return LY_LAZY(_tableView, ({
        UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"新手指南",@"去评分",@"隐私协议",[NSString stringWithFormat: @"关于%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]],[NSString stringWithFormat: @"版本号v%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]], nil];
    }
    return _titleArray;
}
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"setting_firstRead",@"setting_goStar",@"setting_protocol",@"setting_aboutUs",@"setting_version", nil];
    }
    return _imageArray;
}
@end
