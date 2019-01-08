//
//  LYBaseTableViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseTableViewController.h"


@interface LYBaseTableViewController ()

@end

@implementation LYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    

    CGFloat topMargin = iOS11?NAVBAR_HEIGHT:0;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(topMargin);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = LYTableViewBackColor;

//        _tableView.contentInset = UIEdgeInsetsMake(iOS11?NAVBAR_HEIGHT:0, 0, kTabbarExtra, 0);
//        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }
    return _tableView;
}


@end

