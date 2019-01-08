//
//  LYAllEmoticonsTableCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYAllEmoticonsTableCell.h"
#import "LYEmoticonListModel.h"

@interface LYAllEmoticonsTableCell()



@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *lockBackView;
@property (nonatomic, strong) UIImageView *lockImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *intrtoLabel;

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
        self.backgroundColor =LYColor(LYWhiteColorHex);
        [self setUpSubViews];
    }
    return self;
}

+ (CGFloat)getCellHeight{
    return 92;
}
-(void)setUpSubViews{
    
    
    [self addSubview:self.iconImageView];
    [self addSubview:self.lockBackView];
    [self addSubview:self.lockImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.intrtoLabel];
    
    CGFloat cellH = [LYAllEmoticonsTableCell getCellHeight];
    CGFloat iconW = cellH - 10 - 12;

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    
    [self.lockBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconW, iconW));
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(5);
    }];
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.centerY.equalTo(self.lockBackView);
    }];
    
    CGFloat leftMargin = 14.f;
    [self.intrtoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.top.mas_equalTo(@10);
        make.height.mas_equalTo(@16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(leftMargin);
        make.right.equalTo(self.mas_right).offset(-leftMargin);
        make.top.equalTo(self.intrtoLabel.mas_bottom).offset(3);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
}

- (void)setModel:(LYEmoticonListModel *)model{
    _model = model;
    
    self.intrtoLabel.text     = model.emoticonIntro;
    self.titleLabel.text      = model.emoticonName;
    self.lockBackView.hidden  = !model.isLock;
    self.lockImageView.hidden = !model.isLock;
    self.iconImageView.image  = [UIImage imageWithContentsOfFile:model.emoticonUrl];
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 0;
    frame.size.width = frame.size.width;
    
    frame.origin.y = frame.origin.y + 12;
    frame.size.height = frame.size.height - 12;
    
    [super setFrame:frame];
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
