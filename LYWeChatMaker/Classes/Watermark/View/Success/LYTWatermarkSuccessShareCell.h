//
//  LYTWatermarkSuccessShareCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/15.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYTWatermarkSuccessShareCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) NSDictionary *model;

@end

NS_ASSUME_NONNULL_END
