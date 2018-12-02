//
//  LYWatermarkBottomBtnsView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/2.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkBottomBtnsView.h"

@interface LYWatermarkBottomBtnsView()


@property (nonatomic, strong) UIView *topLine;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *rightBtn;


@end

@implementation LYWatermarkBottomBtnsView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect framef = CGRectMake(0, 0, SCREEN_WIDTH, 40);
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
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
    CGSize btnSize = CGSizeMake(40, 40);
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.size.mas_equalTo(btnSize);
    }];
}

- (void)buttonClickAction:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
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


@end
