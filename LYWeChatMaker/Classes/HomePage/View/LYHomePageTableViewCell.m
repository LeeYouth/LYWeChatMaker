//
//  LYHomePageTableViewCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageTableViewCell.h"
#import "LYEmoticonListModel.h"

@interface LYHomePageTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *intrtoLabel;
@property (nonatomic, strong) UIImageView *indicatorView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYHomePageTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYHomePageTableViewCell";
    
    LYHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYHomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = LYHomePageColor;
        [self setUpSubViews];
    }
    return self;
}

+ (CGFloat)getCellHeight{
    return (kScreenHeight - NAVBAR_HEIGHT - 50)/6;
}
-(void)setUpSubViews{
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.intrtoLabel];
    [self addSubview:self.indicatorView];
    [self addSubview:self.lineView];

    CGFloat iconW = 52;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    CGFloat leftMargin = 14.f;
    [self.intrtoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.top.mas_equalTo(@16);
        make.height.mas_equalTo(@16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.intrtoLabel.mas_left);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.top.equalTo(self.intrtoLabel.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
}

- (void)setModel:(NSDictionary *)model{
    _model = model;
    
    self.intrtoLabel.text     = model[@"detail"];
    self.titleLabel.text      = model[@"title"];
    self.iconImageView.image  = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(model[@"image"])];
    self.indicatorView.image  = [UIImage imageNamed:@"homePage_cellRightindicator"];
    
//    self.backgroundColor = LYColor(model[@"color"]);

}

#pragma mark - lazy loading
- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UIImageView *)indicatorView{
    return LY_LAZY(_indicatorView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UILabel *)intrtoLabel{
    return LY_LAZY(_intrtoLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"#172F52");
        view.font = LYSystemFont(12.f);
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
//        view.textColor = LYColor(@"#E94447");
        view.textColor = [UIColor blackColor];
        view.font = LYSystemFont(28.f);
        view;
    }));
}
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}

@end
