//
//  LYTWatermarkTopToolBar.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/10.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkTopToolBar.h"

@interface LYTWatermarkTopToolBar ()
/** 返回按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *rightBtn;
@end


@implementation LYTWatermarkTopToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = LYImageBackColor;
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews
{
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];

    CGSize btnSize = CGSizeMake(44, 44);
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (kiPhoneXLater) {
            make.bottom.equalTo(self.mas_bottom);
        }else{
            make.centerY.equalTo(self.mas_centerY);
        }
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(btnSize);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (kiPhoneXLater) {
            make.bottom.equalTo(self.mas_bottom);
        }else{
            make.centerY.equalTo(self.mas_centerY);
        }
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(btnSize);
    }];
}

- (void)buttonClickAction:(UIButton *)sender
{
    if (self.block) {
        self.block(sender.tag);
    }
}

#pragma mark - 懒加载
- (UIButton *)leftBtn{
    return LY_LAZY(_leftBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"bottomToolBar_close"] forState:UIControlStateNormal];
        btn.tag = 0;
        btn.showsTouchWhenHighlighted = YES;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)rightBtn{
    return LY_LAZY(_rightBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"bottomToolBar_next"] forState:UIControlStateNormal];
        btn.tag = 1;
        btn.showsTouchWhenHighlighted = YES;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}

@end
