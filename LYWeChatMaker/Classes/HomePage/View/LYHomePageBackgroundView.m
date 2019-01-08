//
//  LYHomePageBackgroundView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageBackgroundView.h"

#define kLYHomePageBackgroundButtonMargin 10
#define kLYHomePageBackgroundButtonH ((SCREEN_WIDTH - 3*kLYHomePageBackgroundButtonMargin)/2)

@interface LYHomePageBackgroundView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *libaryButton;//相册
@property (nonatomic, strong) UIButton *emoticonButton;//表情包
@property (nonatomic, strong) UIButton *settingButton;//设置
@property (nonatomic, strong) UIImageView *hotView;

@end

@implementation LYHomePageBackgroundView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubViews];
        
    }
    return self;
}
- (void)_setupSubViews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.libaryButton];
    [self addSubview:self.emoticonButton];
    [self addSubview:self.settingButton];
    [self addSubview:self.hotView];

    CGSize btnSize = CGSizeMake(kLYHomePageBackgroundButtonH, kLYHomePageBackgroundButtonH);
    CGFloat topMargin  = 50;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kLYHomePageBackgroundButtonMargin);
        make.right.equalTo(self.mas_right).offset(-kLYHomePageBackgroundButtonMargin);
        make.top.equalTo(self.mas_top).offset(topMargin);
        make.height.mas_equalTo(@30);
    }];

    [self.libaryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.equalTo(self.mas_left).offset(kLYHomePageBackgroundButtonMargin);
    }];
    
    [self.emoticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.libaryButton.mas_top);
        make.left.equalTo(self.libaryButton.mas_right).offset(kLYHomePageBackgroundButtonMargin);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.emoticonButton.mas_bottom).offset(14);
        make.left.equalTo(self.mas_left).offset(kLYHomePageBackgroundButtonMargin);
    }];
    
    [self.hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 18));
        make.left.equalTo(self.emoticonButton.mas_right).offset(-8);
        make.bottom.equalTo(self.emoticonButton.mas_top).offset(4);
    }];
    
    
  
}

- (void)addWaterMark:(UIButton *)sender
{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
}

#pragma mark - lazy loading
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.text = @"开始";
        view.textColor = LYColor(LYWhiteColorHex);
        view.font = LYSystemFont(28.f);
        view;
    }));
}
- (UIButton *)libaryButton{
    return LY_LAZY(_libaryButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 6;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(15.f);
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [button setTitle:@"相册" forState:UIControlStateNormal];
        [button setBackgroundColor:LYColor(LYWhiteColorHex)];
        [button addTarget:self action:@selector(addWaterMark:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}



- (UIImageView *)hotView{
    return LY_LAZY(_hotView, ({
        UIImageView *view = [UIImageView new];
        view.image = [UIImage imageNamed:@"addWaterMarkButton_new"];
        view;
    }));
}
- (UIButton *)emoticonButton{
    return LY_LAZY(_emoticonButton, ({
        UIButton *button = [UIButton new];
        button.tag = 1;
        button.layer.cornerRadius = 10;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(15.f);
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [button setTitle:@"表情包" forState:UIControlStateNormal];
        [button setBackgroundColor:LYColor(LYWhiteColorHex)];
        [button addTarget:self action:@selector(addWaterMark:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}
- (UIButton *)settingButton{
    return LY_LAZY(_settingButton, ({
        UIButton *button = [UIButton new];
        button.tag = 1;
        button.layer.cornerRadius = 10;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(15.f);
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [button setTitle:@"设置" forState:UIControlStateNormal];
        [button setBackgroundColor:LYColor(LYWhiteColorHex)];
        [button addTarget:self action:@selector(addWaterMark:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}

@end
