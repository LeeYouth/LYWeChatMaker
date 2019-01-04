//
//  LYAllEmoticonsTableCell.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYEmoticonModel;

@interface LYAllEmoticonsTableCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) LYEmoticonModel *model;

@end
