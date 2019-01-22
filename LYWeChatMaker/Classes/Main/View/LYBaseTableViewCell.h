//
//  LYBaseTableViewCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/17.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
