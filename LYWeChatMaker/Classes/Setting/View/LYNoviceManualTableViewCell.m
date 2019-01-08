//
//  LYNoviceManualTableViewCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYNoviceManualTableViewCell.h"

@interface LYNoviceManualTableViewCell()

@end

@implementation LYNoviceManualTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYNoviceManualTableViewCell";
    
    LYNoviceManualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYNoviceManualTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.cornerRadius = kLYViewCornerRadius;
        self.layer.borderColor  = kLYViewBorderColor.CGColor;
        self.layer.borderWidth  = kLYViewBorderWidth;
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    
}




@end
