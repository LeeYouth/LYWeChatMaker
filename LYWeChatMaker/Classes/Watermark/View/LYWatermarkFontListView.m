//
//  LYWatermarkFontListView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/17.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkFontListView.h"

@interface LYWatermarkFontListView ()

/** 默认字体 */
@property (nonatomic, strong) UIButton *systemBtn;
/** 站酷字体 */
@property (nonatomic, strong) UIButton *zhankuBtn;
/** 汉仪新蒂手札体 */
@property (nonatomic, strong) UIButton *hanyiBtn;

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation LYWatermarkFontListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = LYColor(LYWhiteColorHex);
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews {
    [self addSubview:self.systemBtn];
    [self addSubview:self.zhankuBtn];
    [self addSubview:self.hanyiBtn];
    [self.buttonArray addObject:self.systemBtn];
    [self.buttonArray addObject:self.zhankuBtn];
    [self.buttonArray addObject:self.hanyiBtn];

    CGFloat btnY = 7;
    CGFloat btnW = 100;
    CGFloat btnH = 56;
    [self.zhankuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
    [self.systemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX).offset(-SCREEN_WIDTH/4);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
    [self.hanyiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        make.centerX.equalTo(self.mas_centerX).offset(SCREEN_WIDTH/4);
        make.top.equalTo(self.mas_top).offset(btnY);
    }];
    
}

- (void)buttonClickAction:(UIButton *)sender
{
    
    for (int i = 0;  i < self.buttonArray.count; i++) {
        UIButton *btn = self.buttonArray[i];
        if (btn.tag == sender.tag) {
            [sender setTitleColor:LYThemeColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        }
    }
    
    if (self.block) {
        self.block(sender);
    }
}

#pragma mark - lazy loading
- (UIButton *)systemBtn{
    return LY_LAZY(_systemBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        [btn setTitle:@"默认字体" forState:UIControlStateNormal];
        [btn setTitleColor:LYThemeColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 0;
        btn;
    }));
}
- (UIButton *)zhankuBtn{
    return LY_LAZY(_zhankuBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont fontWithName:@"HappyZcool-2016" size:20.f];
        [btn setTitle:@"简单" forState:UIControlStateNormal];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1;
        btn;
    }));
}
- (UIButton *)hanyiBtn{
    return LY_LAZY(_hanyiBtn, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont fontWithName:@"Hanyi Senty Journal" size:20.f];
        [btn setTitle:@"简单" forState:UIControlStateNormal];
        [btn setTitleColor:LYColor(LYBlackColorHex) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2;
        btn;
    }));
}
- (NSMutableArray *)buttonArray{
    return LY_LAZY(_buttonArray, ({
        NSMutableArray *array = [[NSMutableArray alloc] init];
        array;
    }));
}

@end

