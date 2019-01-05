//
//  LYTWatermarkSuccessView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSuccessView.h"

@interface LYTWatermarkSuccessView()

/** 背景图 */
@property (nonatomic, strong) UIImageView *backImageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 确定 */
@property (nonatomic, strong) UIButton *ensureButton;

@end

@implementation LYTWatermarkSuccessView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYColor(LYWhiteColorHex);
        
        [self _setupSubViews];
        
    }
    return self;
}

- (void)_setupSubViews
{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 100, SCREEN_WIDTH - 40));
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(@(30+NAVBAR_HEIGHT));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_bottom).offset(18);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@20);
    }];
    
    CGFloat bottomM = 60 ;
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(bottomM);
    }];
}

- (void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    
    self.backImageView.image = backImage;
    
}

- (void)ensureButtonClick:(UIButton *)sender{
    
    if (self.btnBlock) {
        self.btnBlock(sender);
    }    
}

#pragma mark - lazy loading
- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *imageV = [UIImageView new];
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageV];
        imageV;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"图片已保存到相册";
        view.font = LYSystemFont(14.f);
        [self addSubview:view];
        view;
    }));
}
- (UIButton *)ensureButton{
    return LY_LAZY(_ensureButton, ({
        UIButton *button = [UIButton new];
        button.tag = 0;
        button.layer.cornerRadius = 20;
        button.showsTouchWhenHighlighted = YES;
        button.titleLabel.font = LYSystemFont(14.f);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setBackgroundColor:LYButtonThemeColor];
        [button addTarget:self action:@selector(ensureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        button;
    }));
}

#pragma mark - private method
- (CGSize)getImageViewSizeWithImage:(UIImage *)targetImage
{
    CGFloat photoW = targetImage.size.width;
    CGFloat photoH = targetImage.size.height;
    
    CGFloat photoScale = photoW/photoH;
    CGFloat photoScale1 = photoH/photoW;
    
    CGFloat iconH = 0;
    CGFloat iconW = 0;
    
    //宽度>高度
    if (photoW > photoH) {
        iconW = photoW > SCREEN_WIDTH ?SCREEN_WIDTH:photoW;
        iconH = iconW*photoScale1;
    }else{
        iconH = photoH > self.height ?self.height:photoH;
        iconW = iconH*photoScale;
    }
    return CGSizeMake(iconW, iconH);
}

@end
