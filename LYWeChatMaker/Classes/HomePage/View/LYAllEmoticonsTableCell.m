//
//  LYAllEmoticonsTableCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYAllEmoticonsTableCell.h"
#import "LYEmoticonModel.h"

@interface LYAllEmoticonsTableCell()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lockBackView;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation LYAllEmoticonsTableCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYAllEmoticonsTableCell";
    
    LYAllEmoticonsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYAllEmoticonsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self setUpSubViews];
    }
    return self;
}
-(void)setUpSubViews{
    [self addSubview:self.iconImageView];
    [self addSubview:self.lockBackView];
    [self addSubview:self.lockImageView];
    [self addSubview:self.titleLab];
    [self addSubview:self.bottomLine];

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    [self.lockBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerX.centerY.equalTo(self.lockBackView);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@30);
        make.left.equalTo(self.iconImageView.mas_right).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(15);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];

}

- (void)setModel:(LYEmoticonModel *)model{
    _model = model;
    
    self.titleLab.text = model.emoticonName;
    self.lockBackView.hidden  = !model.isLock;
    self.lockImageView.hidden = !model.isLock;
    self.iconImageView.image = [UIImage imageWithContentsOfFile:model.emoticonUrl];
}

#pragma mark - lazy loading
- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UIView *)lockBackView{
    return LY_LAZY(_lockBackView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYColor(LYBlackColorHex);
        view.alpha = 0.5;
        view.hidden = YES;
        view;
    }));
}
- (UIImageView *)lockImageView{
    return LY_LAZY(_lockImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"unlockNewFeatures_lockIcon")];
        view;
    }));
}
- (UILabel *)titleLab{
    return LY_LAZY(_titleLab, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = LYSystemFont(14.f);
        view;
    }));
}
- (UIView *)bottomLine{
    return LY_LAZY(_bottomLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
@end
