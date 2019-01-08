//
//  LYHomePageTableViewCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYHomePageTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) NSDictionary *model;

+ (CGFloat)getCellHeight;

@end
