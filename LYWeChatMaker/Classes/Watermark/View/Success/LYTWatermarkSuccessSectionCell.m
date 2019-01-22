//
//  LYTWatermarkSuccessSectionCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/15.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSuccessSectionCell.h"

@interface LYTWatermarkSuccessSectionCell ()

/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 底部线条 */
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation LYTWatermarkSuccessSectionCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYTWatermarkSuccessSectionCell";
    
    LYTWatermarkSuccessSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYTWatermarkSuccessSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews
{
    CGFloat cellH = 56;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(24));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(14);
        make.right.equalTo(self.mas_right).offset(-14);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(LYCellLineHeight));
        make.left.right.bottom.equalTo(self);
    }];
    
    self.height = cellH;
    
    self.titleLabel.text = @"分享";
}

- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"#3B495C");
        view.font = [UIFont boldSystemFontOfSize:26.f];
        [self addSubview:view];
        view;
    }));
}
- (UIView *)bottomLine{
    return LY_LAZY(_bottomLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        [self addSubview:view];
        view;
    }));
}
@end
