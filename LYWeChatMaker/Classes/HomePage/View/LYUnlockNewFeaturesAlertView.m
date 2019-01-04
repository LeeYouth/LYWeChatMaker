//
//  LYUnlockNewFeaturesAlertView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYUnlockNewFeaturesAlertView.h"

#define LYUnlockNewFeaturesAlertViewH 310

@interface LYUnlockNewFeaturesAlertView ()
/// 包装选择器
@property (nonatomic, strong) UIView *contentView;
/// 蒙板
@property (nonatomic, strong) UIView *cover;
/// 背景
@property (nonatomic, strong) UIImageView *iconImageView;
/// title数组
@property (nonatomic, strong) UILabel *titleLabel;
/// title数组
@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *watchButton;

@end

@implementation LYUnlockNewFeaturesAlertView

/// 快速创建pickerview方法
+ (instancetype)sharedInstance{
    LYUnlockNewFeaturesAlertView *view = [[LYUnlockNewFeaturesAlertView alloc] init];
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
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.watchButton];
    [self addSubview:self.contentView];
    
#pragma -mark 设置子控件约束
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@25);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.left.right.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    CGFloat bottomM = 15 + kTabbarExtra;
    [self.watchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 30, 48));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-bottomM);
    }];
    
    self.iconImageView.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"unlockNewFeaturesAlerticon")];
    
    self.titleLabel.text  = @"这是未解锁的道具!";
    self.detailLabel.text = @"观看广告后可立即解锁。\n点击下面的按钮很快就能使用这个表情包哦！";
    
    
}

#pragma mark - 显示选择指示器
- (void)showInViewAnimated:(BOOL)animated{
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
- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
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
        view.font = LYSystemFont(18.f);
        view;
    }));
}
- (UILabel *)detailLabel{
    return LY_LAZY(_detailLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"#999999");
        view.textAlignment = NSTextAlignmentCenter;
        view.numberOfLines = 0;
        view.font = LYSystemFont(14.f);
        view;
    }));
}
- (UIButton *)watchButton{
    return LY_LAZY(_watchButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 20;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(16.f);
        button.titleLabel.numberOfLines = 0;
        [button setImage:[UIImage imageNamed:@"unlockNewFeaturesAlerad"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"   观看广告解锁" forState:UIControlStateNormal];
        [button setBackgroundColor:LYColor(@"#428BCA")];
        [button addTarget:self action:@selector(unlockClick:) forControlEvents:UIControlEventTouchUpInside];
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

