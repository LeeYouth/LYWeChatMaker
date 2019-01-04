//
//  LYBaseTableViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  基类tableView控制器

#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseTableViewController : LYBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView   *tableView;

@end

NS_ASSUME_NONNULL_END
