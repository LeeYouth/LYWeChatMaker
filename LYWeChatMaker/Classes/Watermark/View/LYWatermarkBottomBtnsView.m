//
//  LYWatermarkBottomBtnsView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/2.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkBottomBtnsView.h"

@interface LYWatermarkBottomBtnsView()

/** 顶部线条 */
@property (nonatomic, strong) UIView *topLine;
/** 颜色按钮 */
@property (nonatomic, strong) UIButton *colorBtn;
/** 样式按钮 */
@property (nonatomic, strong) UIButton *styleBtn;
/** 字体按钮 */
@property (nonatomic, strong) UIButton *fontBtn;

/** 底部线条 */
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation LYWatermarkBottomBtnsView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect framef = CGRectMake(0, 0, SCREEN_WIDTH, LYWatermarkBottomBtnsViewH);
    self = [super initWithFrame:framef];
    if (self) {
        self.frame = framef;
        
        [self _setupSubView];
        
    }
    return self;
}

- (void)_setupSubView{
    [self addSubview:self.topLine];
    
    [self addSubview:self.colorBtn];
    [self addSubview:self.styleBtn];
    [self addSubview:self.fontBtn];
    [self addSubview:self.bottomLine];

    CGFloat bottomLineH = 2;
    CGFloat bottomLineW = 60;
    CGFloat bottomLineX  = (SCREEN_WIDTH/3 - bottomLineW)/2;

    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
    CGFloat btnW = SCREEN_WIDTH/3;
    
    [self.colorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(@(btnW));
        make.bottom.equalTo(self.mas_bottom).offset(-bottomLineH);
    }];
    [self.styleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(@(btnW));
        make.left.equalTo(self.colorBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-bottomLineH);
    }];
    
    [self.fontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.mas_equalTo(@(btnW));
        make.left.equalTo(self.styleBtn.mas_right);
        make.bottom.equalTo(self.mas_bottom).offset(-bottomLineH);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(bottomLineW, bottomLineH));
        make.left.equalTo(self.mas_left).offset(bottomLineX);
    }];
}

- (void)buttonClickAction:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
    }
    
    CGFloat bottomLineW = 60;
    CGFloat bottomLineX  = (SCREEN_WIDTH/3 - bottomLineW)/2;
    CGFloat bottomLineX1 = SCREEN_WIDTH/3 + bottomLineX;
    CGFloat bottomLineX2 = SCREEN_WIDTH/3 + bottomLineX1;

    if (sender.tag == 0) {
        //颜色
        [self.styleBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [self.fontBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        
        [self.colorBtn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(bottomLineX);
        }];
        
    }else if (sender.tag == 1){
        [self.colorBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [self.fontBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];

        [self.styleBtn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(bottomLineX1);
        }];
    }else if (sender.tag == 2){
        [self.colorBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [self.styleBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        
        [self.fontBtn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(bottomLineX2);
        }];
    }

    
}


#pragma mark - lazy loading
- (UIView *)topLine{
    return LY_LAZY(_topLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
- (UIButton *)colorBtn{
    return LY_LAZY(_colorBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        btn.showsTouchWhenHighlighted = YES;
        [btn setTitle:@"颜色" forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        btn.tag = 0;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)styleBtn{
    return LY_LAZY(_styleBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        btn.showsTouchWhenHighlighted = YES;
        [btn setTitle:@"样式" forState:UIControlStateNormal];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        btn.tag = 1;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)fontBtn{
    return LY_LAZY(_fontBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        btn.showsTouchWhenHighlighted = YES;
        [btn setTitle:@"字体" forState:UIControlStateNormal];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        btn.tag = 2;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIView *)bottomLine{
    return LY_LAZY(_bottomLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYThemeColor;
        view;
    }));
}

@end
