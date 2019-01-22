//
//  LYTWatermarkSuccessShareCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/15.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSuccessShareCell.h"

@interface LYTWatermarkSuccessShareCell ()

/** 背景图 */
@property (nonatomic, strong) UIImageView *iconImageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

/** 底部线条 */
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation LYTWatermarkSuccessShareCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYTWatermarkSuccessShareCell";
    
    LYTWatermarkSuccessShareCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYTWatermarkSuccessShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        [self _setupSubViews];
    }
    return self;
}


- (void)_setupSubViews
{
    CGFloat cellH = 56;
    CGFloat leftMargin = 14;

    CGSize iconSize = CGSizeMake(35, 35);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(iconSize);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(leftMargin);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(24));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(LYCellLineHeight));
        make.left.right.bottom.equalTo(self);
    }];
    
    self.height = cellH;
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    
    self.titleLabel.text      = model[@"title"];
    self.iconImageView.image  = [UIImage imageNamed:model[@"image"]];
}

- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *imageV = [UIImageView new];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageV];
        imageV;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = LYSystemFont(16.f);
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
