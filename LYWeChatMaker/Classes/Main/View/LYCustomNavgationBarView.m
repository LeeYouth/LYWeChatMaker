//
//  LYCustomNavgationBarView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/7.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYCustomNavgationBarView.h"

@interface LYCustomNavgationBarView()

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *titleView;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYCustomNavgationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYNavBarBackColor;
        
        
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews{
    
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];

    CGSize btnSize = CGSizeMake(44, 44);
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-5);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(10);
        make.right.equalTo(self.rightButton.mas_left).offset(-10);
        make.height.mas_equalTo(@44);
        make.centerY.equalTo(self.leftButton.mas_centerY);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftButton.mas_right).offset(10);
        make.right.equalTo(self.rightButton.mas_left).offset(-10);
        make.height.mas_equalTo(@44);
        make.centerY.equalTo(self.leftButton.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(LYCellLineHeight));
        make.bottom.left.right.equalTo(self);
    }];
}


- (void)leftButtonClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
}
- (void)rightButtonClick:(UIButton *)sender{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
}

#pragma mark - setting
- (void)setNavColor:(UIColor *)navColor{
    _navColor = navColor;
    self.backgroundColor = navColor;
}
- (void)setNavTitleColor:(UIColor *)navTitleColor{
    _navTitleColor = navTitleColor;
    self.titleLabel.textColor = navTitleColor;
}
- (void)setNavTitleFont:(UIFont *)navTitleFont{
    _navTitleFont = navTitleFont;
    self.titleLabel.font = navTitleFont;
}
- (void)setLeftBarItemImage:(UIImage *)leftBarItemImage{
    _leftBarItemImage = leftBarItemImage;
    if (leftBarItemImage == nil) {
        self.leftButton.hidden = YES;
    }else{
        self.leftButton.hidden = NO;
        [self.leftButton setImage:leftBarItemImage forState:UIControlStateNormal];
    }
}
- (void)setRightBarItemImage:(UIImage *)rightBarItemImage{
    _rightBarItemImage = rightBarItemImage;
    [self.rightButton setImage:rightBarItemImage forState:UIControlStateNormal];
    self.rightButton.hidden = NO;
}
- (void)setNavBarTitle:(NSString *)navBarTitle{
    _navBarTitle = navBarTitle;
    self.titleLabel.text = navBarTitle;
}
- (void)setTitleImage:(UIImage *)titleImage{
    _titleImage = titleImage;
    if (titleImage) {
        self.titleLabel.hidden = YES;
        self.titleView.image = titleImage;
    }
}

- (void)setShowShadow:(BOOL)showShadow{
    _showShadow = showShadow;
    if (showShadow) {
        self.layer.shadowColor = LYColor(@"#AAAAAA").CGColor;
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.layer.shadowRadius = 4.0;
        self.layer.shadowOpacity = 1.0;
        
        self.lineView.hidden = YES;
    } else {
    
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 1.0;
    }
}

- (void)setHiddenLineView:(BOOL)hiddenLineView{
    _hiddenLineView = hiddenLineView;
    
    if (hiddenLineView) {
        self.lineView.hidden = YES;
    }else{
        self.lineView.hidden = NO;
    }
}

- (BOOL)compareRGBAColor1:(UIColor *)color1 withColor2:(UIColor *)color2 {
    
    CGFloat red1,red2,green1,green2,blue1,blue2,alpha1,alpha2;
    //取出color1的背景颜色的RGBA值
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    //取出color2的背景颜色的RGBA值
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    if ((red1 == red2)&&(green1 == green2)&&(blue1 == blue2)&&(alpha1 == alpha2)) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - lazy loading
- (UIButton *)leftButton{
    return LY_LAZY(_leftButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        [button setImage:[UIImage imageNamed:@"navBarBackItemIcon"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    }));
}
- (UIButton *)rightButton{
    return LY_LAZY(_rightButton, ({
        UIButton *button = [UIButton new];
        button.tag = 1;
        [button setImage:[UIImage imageNamed:@"bottomToolBar_next"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button.hidden = YES;
        button;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = LYColor(@"#515151");
        view.font = LYSystemFont(16.f);
        [self addSubview:view];
        view;
    }));
}
- (UIImageView *)titleView{
    return LY_LAZY(_titleView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:view];
        view;
    }));
}
- (UIView *)lineView{
    return LY_LAZY(_lineView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYCellLineColor;
        [self addSubview:view];
        view;
    }));
}
@end
