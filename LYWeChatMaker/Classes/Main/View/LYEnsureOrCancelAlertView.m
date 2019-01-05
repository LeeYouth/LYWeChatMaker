//
//  LYEnsureOrCancelAlertView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYEnsureOrCancelAlertView.h"
#define LYUnlockNewFeaturesAlertViewH 140

@interface LYEnsureOrCancelAlertView ()
/// 包装选择器
@property (nonatomic, strong) UIView *contentView;
/// 蒙板
@property (nonatomic, strong) UIView *cover;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation LYEnsureOrCancelAlertView

/// 快速创建pickerview方法
+ (instancetype)sharedInstance{
    LYEnsureOrCancelAlertView *view = [[LYEnsureOrCancelAlertView alloc] init];
    return view;
}

/// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupSubViews{
#pragma -mark 添加子控件
    [self addSubview:self.cover];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.leftButton];
    [self.contentView addSubview:self.rightButton];
    [self addSubview:self.contentView];
    
#pragma -mark 设置子控件约束
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(@20);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    CGFloat bottomM = 20 + kTabbarExtra;
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_centerX).offset(-8);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth - 30 - 16)/2, 40));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-bottomM);
    }];
    
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(8);
        make.size.mas_equalTo(CGSizeMake((kScreenWidth - 30 - 16)/2, 40));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-bottomM);
    }];
    
    
    
}

#pragma mark - 显示选择指示器
- (void)showInViewWithTitle:(NSString *)title
                  leftTitle:(NSString *)leftTitle
                 rightTitle:(NSString *)rightTitle
                   animated:(BOOL)animated{
    self.titleLabel.text = title;
    [self.leftButton setTitle:leftTitle forState:UIControlStateNormal];
    [self.rightButton setTitle:rightTitle forState:UIControlStateNormal];

    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat backViewH = LYUnlockNewFeaturesAlertViewH ;
    CGFloat Y         = SCREEN_HEIGHT - backViewH - kTabbarExtra;
    
    if (animated)
    {
        // 动画显示
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        }];
        self.cover.alpha = 0.5;
        
    }else
    {
        // 无动画显示
        self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        
        self.cover.alpha = 0.5;
        
    }
}
#pragma mark - 退出
- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.cover removeFromSuperview];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}




#pragma mark - 关闭操作
- (void)closeAction{
    [self close];
}

- (void)unlockClick:(UIButton *)sender{
    
    if (self.btnBlock) {
        self.btnBlock(sender);
    }
    
    [self close];
}


#pragma mark - 懒加载
- (UIView *)cover{
    return LY_LAZY(_cover, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYBlackColorHex);
        view.alpha = 0;
        view;
    }));
}
- (UIView *)contentView{
    return LY_LAZY(_contentView, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, LYUnlockNewFeaturesAlertViewH);
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        view.font = LYSystemFont(16.f);
        view;
    }));
}

- (UIButton *)leftButton{
    return LY_LAZY(_leftButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 20;
        button.titleLabel.font = LYSystemFont(14.f);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:LYButtonThemeColor];
        [button addTarget:self action:@selector(unlockClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        button;
    }));
}
- (UIButton *)rightButton{
    return LY_LAZY(_rightButton, ({
        UIButton *button = [UIButton new];
        button.tag = 1;
        button.layer.cornerRadius = 20;
        button.titleLabel.font = LYSystemFont(14.f);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:LYButtonThemeColor];
        [button addTarget:self action:@selector(unlockClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button;
    }));
}
#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.contentView) {
            
        }else{
            [self close];
        }
    }
}

@end


