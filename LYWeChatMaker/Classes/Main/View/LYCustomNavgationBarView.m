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

@end

@implementation LYCustomNavgationBarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYNavBarBackColor;
        
        self.layer.shadowColor = LYColor(@"#AAAAAA").CGColor;
        self.layer.shadowOffset = CGSizeMake(2.0, 2.0);
        self.layer.shadowRadius = 4.0;
        self.layer.shadowOpacity = 1.0;
        
//        //1.设置阴影颜色
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        //2.设置阴影偏移范围
//        self.layer.shadowOffset = CGSizeMake(0, 10);
//        //3.设置阴影颜色的透明度
//        self.layer.shadowOpacity = 0.2;
//        //4.设置阴影半径
//        self.layer.shadowRadius = 16;
//        //5.设置阴影路径
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
 
        
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews{
    
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.titleLabel];

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
        view.textColor = LYColor(LYWhiteColorHex);
        view.font = LYSystemFont(16.f);
        [self addSubview:view];
        view;
    }));
}

@end
