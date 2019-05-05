//
//  LYSettingTableViewCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYSettingTableViewCell.h"

@interface LYSettingTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYSettingTableViewCell";
    
    LYSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    CGFloat leftMargin = 15;

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.centerY.equalTo(self.mas_centerY);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@16);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftMargin);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(@0.8);
    }];
    self.titleLabel.text  = @"去评分";
}

+ (CGFloat)getCellHeight{
    return 56;
}

- (void)setIconName:(NSString *)iconName{
    _iconName = iconName;
    self.iconView.image = [UIImage imageNamed:iconName];
}
- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text  = title;
}
- (void)setShowIndicator:(BOOL)showIndicator{
    _showIndicator = showIndicator;
    if (showIndicator) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - lazyloading
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
- (UIImageView *)iconView{
    return LY_LAZY(_iconView, ({
        UIImageView *view = [UIImageView new];
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = LYSystemFont(15.f);
        view;
    }));
}
@end
