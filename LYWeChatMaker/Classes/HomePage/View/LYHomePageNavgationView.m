//
//  LYHomePageNavgationView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageNavgationView.h"


@interface LYHomePageNavgationView()

@property (nonatomic, strong) UIButton *rightBarButton;

@end

@implementation LYHomePageNavgationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubViews];
    }
    return self;
}
- (void)_setupSubViews
{
    [self addSubview:self.rightBarButton];
    
    [self.rightBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.top.equalTo(self.mas_top).offset(STATUSBAR_HEIGHT);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

- (void)rightBarItemClick:(UIButton *)sender
{
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
}


#pragma mark - lazy loading
- (UIButton *)rightBarButton{
    return LY_LAZY(_rightBarButton, ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"homepage_rightBarItem"] forState:UIControlStateNormal];
        button.showsTouchWhenHighlighted = YES;
        [button addTarget:self action:@selector(rightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }));
}

@end
