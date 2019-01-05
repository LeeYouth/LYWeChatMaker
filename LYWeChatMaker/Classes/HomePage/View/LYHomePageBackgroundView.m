//
//  LYHomePageBackgroundView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageBackgroundView.h"
#import "LYWatermarkGuideView.h"

@interface LYHomePageBackgroundView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *addMarkButton;
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
    [self addSubview:self.addMarkButton];
    [self addSubview:self.selectPhotoButton];
    [self addSubview:self.hotView];

    CGSize btnSize = CGSizeMake(LYHomePageAddMarkButtonW, LYHomePageAddMarkButtonH);
    CGFloat topMargin  = 70;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(topMargin);
        make.height.mas_equalTo(@30);
    }];

    [self.addMarkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.selectPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(btnSize);
        make.top.equalTo(self.addMarkButton.mas_bottom).offset(35);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 18));
        make.left.equalTo(self.selectPhotoButton.mas_right).offset(-8);
        make.bottom.equalTo(self.selectPhotoButton.mas_top).offset(4);
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
        view.text = @"选取一张图片开始吧~";
        view.textColor = LYColor(LYWhiteColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        view.font = LYSystemFont(15.f);
        view;
    }));
}
- (UIButton *)addMarkButton{
    return LY_LAZY(_addMarkButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 10;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(15.f);
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"相册" forState:UIControlStateNormal];
        [button setBackgroundColor:LYColor(@"#428BCA")];
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
- (UIButton *)selectPhotoButton{
    return LY_LAZY(_selectPhotoButton, ({
        UIButton *button = [UIButton new];
        button.tag = 1;
        button.layer.cornerRadius = 10;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(15.f);
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"表情包" forState:UIControlStateNormal];
        [button setBackgroundColor:LYThemeColor];
        [button addTarget:self action:@selector(addWaterMark:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}


@end
