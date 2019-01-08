//
//  LYWatermarkStyleListView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/3.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkStyleListView.h"
@interface LYWatermarkStyleListView ()

/** 描边按钮 */
@property (nonatomic, strong) UIButton *strokeBtn;
/** 加粗按钮 */
@property (nonatomic, strong) UIButton *boldBtn;
/** 阴影按钮 */
@property (nonatomic, strong) UIButton *shadowBtn;

@end

@implementation LYWatermarkStyleListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = LYColor(LYWhiteColorHex);
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews {
    [self addSubview:self.strokeBtn];
    [self addSubview:self.shadowBtn];
    [self addSubview:self.boldBtn];
    
    CGFloat btnY = 7;
    CGFloat btnW = 56;
    CGFloat btnH = 56;
    [self.shadowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
    [self.strokeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX).offset(-SCREEN_WIDTH/4);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
    [self.boldBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX).offset(SCREEN_WIDTH/4);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
    self.shadowBtn.hidden = YES;
}

- (void)buttonClickAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.block) {
        self.block(sender);
    }
}

#pragma mark - lazy loading
- (UIButton *)strokeBtn{
    return LY_LAZY(_strokeBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(13.f);
        [btn setTitle:@"描边" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_shhadowSetNormal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_shhadowSetSelect"] forState:UIControlStateSelected];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 0;
        [self initButton:btn];
        btn;
    }));
}
- (UIButton *)shadowBtn{
    return LY_LAZY(_shadowBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(13.f);
        [btn setTitle:@"阴影" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_shhadowSetNormal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_shhadowSetSelect"] forState:UIControlStateSelected];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1;
        [self initButton:btn];
        btn;
    }));
}
- (UIButton *)boldBtn{
    return LY_LAZY(_boldBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(13.f);
        [btn setTitle:@"加粗" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_boldSetNormal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"watermarkText_boldSetSelect"] forState:UIControlStateSelected];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self initButton:btn];
        btn.tag = 2;
        btn;
    }));
}

//将按钮设置为图片在上，文字在下
-(void)initButton:(UIButton*)button{
    // button标题的偏移量
    button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+42, -button.imageView.bounds.size.width - 25, 0,0);
    // button图片的偏移量
    button.imageEdgeInsets = UIEdgeInsetsMake(-15, button.titleLabel.frame.size.width/2, button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
    
}

@end
