//
//  LYMakeEmoticonViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonViewController.h"
#import "LYMakeEmoticonBodyesCell.h"
#import "LYTWatermarkSaveSuccessController.h"

@interface LYMakeEmoticonViewController ()

@property (nonatomic ,assign) kLYMakeEmoticonViewType viewType;

@end

@implementation LYMakeEmoticonViewController

- (instancetype)initWithViewType:(kLYMakeEmoticonViewType)viewType{
    self = [super init];
    if (self) {
        self.viewType = viewType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navBarView.navColor = LYColor(@"#F2F1F2");
    self.navBarView.leftBarItemImage = nil;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = LYColor(@"#F2F1F2");
    self.tableView.scrollEnabled = NO;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SCREEN_HEIGHT - NAVBAR_HEIGHT - kTabbarExtra;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF(weakSelf);
    LYMakeEmoticonBodyesCell *cell = [LYMakeEmoticonBodyesCell cellWithTableView:tableView];
    cell.viewType = self.viewType;
    cell.defultEmojiModel = self.defultEmojiModel;
    cell.block = ^(UIButton *sender) {
        if (sender.tag == 3) {
            //返回
            [weakSelf showAlertView];
        }
    };
    cell.success = ^(UIImage * _Nonnull image) {
        [weakSelf pushSuccessVCWithImage:image];
    };
    return cell;
}


- (void)showAlertView{
    WEAKSELF(weakSelf);
    LYEnsureOrCancelAlertView *alertView = [LYEnsureOrCancelAlertView sharedInstance];
    [alertView showInViewWithTitle:@"确定丢弃吗？" leftTitle:@"取消" rightTitle:@"丢弃" animated:YES];
    alertView.btnBlock = ^(UIButton *sender) {
        if (sender.tag == 0)
        {
            
        }else if (sender.tag == 1)
        {
            //返回
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
}

- (void)pushSuccessVCWithImage:(UIImage *)image{
    WEAKSELF(weakSelf);
    [LYToastTool bottomShowWithText:@"保存成功" delay:1];
    LYTWatermarkSaveSuccessController *vc = [[LYTWatermarkSaveSuccessController alloc] init];
    vc.backImage = image;
    vc.hiddenCollection = YES;
    vc.dismissSuccess = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [weakSelf.navigationController pushViewController:vc animated:YES];
}




@end
