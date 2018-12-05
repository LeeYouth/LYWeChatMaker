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
/** 返回按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *rightBtn;

/** 样式按钮 */
@property (nonatomic, strong) UIButton *styleBtn;
/** 颜色按钮 */
@property (nonatomic, strong) UIButton *colorBtn;
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
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    [self addSubview:self.colorBtn];
    [self addSubview:self.styleBtn];
    [self addSubview:self.bottomLine];

    CGFloat bottomLineH = 2;
    CGFloat bottomLineW = 60;
    CGFloat bottomLineX = LYWatermarkBottomBtnsViewH + (SCREEN_WIDTH/2 - LYWatermarkBottomBtnsViewH - bottomLineW)/2;

    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
    CGSize btnSize = CGSizeMake(LYWatermarkBottomBtnsViewH, LYWatermarkBottomBtnsViewH);
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.colorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.leftBtn.mas_right);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-bottomLineH);
    }];
    [self.styleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.rightBtn.mas_left);
        make.left.equalTo(self.mas_centerX);
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
    CGFloat bottomLineX  = LYWatermarkBottomBtnsViewH + (SCREEN_WIDTH/2 - LYWatermarkBottomBtnsViewH - bottomLineW)/2;
    CGFloat bottomLineX1 = SCREEN_WIDTH/2 + (SCREEN_WIDTH/2 - LYWatermarkBottomBtnsViewH - bottomLineW)/2;

    if (sender.tag == 2) {
        //颜色
        [self.colorBtn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [self.styleBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(bottomLineX);
        }];
        
    }else if (sender.tag == 3){
        [self.colorBtn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [self.styleBtn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [self.bottomLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(bottomLineX1);
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
- (UIButton *)leftBtn{
    return LY_LAZY(_leftBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"bottomToolBar_close"] forState:UIControlStateNormal];
        btn.tag = 0;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)rightBtn{
    return LY_LAZY(_rightBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"bottomToolBar_next"] forState:UIControlStateNormal];
        btn.tag = 1;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}

- (UIButton *)colorBtn{
    return LY_LAZY(_colorBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        [btn setTitle:@"颜色" forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        btn.tag = 2;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)styleBtn{
    return LY_LAZY(_styleBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        [btn setTitle:@"样式" forState:UIControlStateNormal];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        btn.tag = 3;
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
