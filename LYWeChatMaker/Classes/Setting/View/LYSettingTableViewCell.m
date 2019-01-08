//
//  LYSettingTableViewCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYSettingTableViewCell.h"

@interface LYSettingTableViewCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *intrtoLabel;

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
        self.layer.cornerRadius = kLYViewCornerRadius;
        self.layer.borderColor  = kLYViewBorderColor.CGColor;
        self.layer.borderWidth  = kLYViewBorderWidth;
        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    [self addSubview:self.backView];
    [self.backView addSubview:self.intrtoLabel];
    [self.backView addSubview:self.titleLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];

    CGFloat leftMargin = 14.f;
    [self.intrtoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(leftMargin);
        make.right.equalTo(self.backView.mas_right).offset(-leftMargin);
        make.top.mas_equalTo(@6);
        make.height.mas_equalTo(@16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(leftMargin);
        make.right.equalTo(self.backView.mas_right).offset(-leftMargin);
        make.top.equalTo(self.intrtoLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    self.intrtoLabel.text = @"给我们加加油吧";
    self.titleLabel.text  = @"去评分";
    
}

- (void)setIntroTitle:(NSString *)introTitle{
    _introTitle = introTitle;
    self.intrtoLabel.text = introTitle;
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
- (UIView *)backView{
    return LY_LAZY(_backView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYColor(LYWhiteColorHex);

        view;
    }));
}
- (UILabel *)intrtoLabel{
    return LY_LAZY(_intrtoLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"#999999");
        view.font = LYSystemFont(12.f);
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = LYSystemFont(28.f);
        view;
    }));
}
@end
