//
//  LYWatermarkGuideView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkGuideView.h"

@interface LYWatermarkGuideView ()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) UIView *maskBg;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIImageView *btnMaskView;
@property (nonatomic, strong) UIImageView *arrwoView;
@property (nonatomic, strong) UILabel *tipsLabel;

@property (nonatomic, weak) UIButton *maskBtn;

@property (nonatomic, strong) UIView *topMaskView;
@property (nonatomic, strong) UIView *bottomMaskView;
@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@end

@implementation LYWatermarkGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.leftMaskView];
        [self addSubview:self.rightMaskView];
        [self addSubview:self.okBtn];
        [self addSubview:self.btnMaskView];
        [self addSubview:self.arrwoView];
        [self addSubview:self.tipsLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = _parentView.bounds;
    _maskBg.frame = self.bounds;
    _btnMaskView.center = [_maskBtn.superview convertPoint:_maskBtn.center toView:_maskBtn.superview];
    
    CGRect btnMaskRect = _btnMaskView.frame;
    btnMaskRect.size = CGSizeMake(floor(btnMaskRect.size.width), floor(btnMaskRect.size.height));
    btnMaskRect.origin = CGPointMake(floor(btnMaskRect.origin.x), floor(btnMaskRect.origin.y));
    _btnMaskView.frame = btnMaskRect;
    
    _topMaskView.left = 0;
    _topMaskView.top = 0;
    _topMaskView.height = _btnMaskView.top;
    _topMaskView.width = self.width;
    
    _bottomMaskView.left = 0;
    _bottomMaskView.top = _btnMaskView.bottom;
    _bottomMaskView.width = self.width;
    _bottomMaskView.height = self.height - _bottomMaskView.top;
    
    _leftMaskView.left = 0;
    _leftMaskView.top = _btnMaskView.top;
    _leftMaskView.width = _btnMaskView.left;
    _leftMaskView.height = _btnMaskView.height;
    
    _rightMaskView.left = _btnMaskView.right;
    _rightMaskView.top = _btnMaskView.top;
    _rightMaskView.width = self.width - _rightMaskView.left;
    _rightMaskView.height = _btnMaskView.height;
    
    _arrwoView.right = _btnMaskView.left + 24;
    _arrwoView.bottom = _btnMaskView.top - 8;
    _tipsLabel.right = _arrwoView.left - 6;
    _tipsLabel.bottom = _arrwoView.top + 10;
    
    _okBtn.centerX = self.width/2;
    _okBtn.bottom = _btnMaskView.bottom + 40;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

- (void)showInView:(UIView *)view maskBtn:(UIButton *)btn {
    self.parentView = view;
    self.maskBtn = btn;
    
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
    } completion:nil];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter and setter

- (UIView *)maskBg {
    if (!_maskBg) {
        UIView *view = [[UIView alloc] init];
        _maskBg = view;
    }
    return _maskBg;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"fx_livRm_guide_ok"] forState:UIControlStateNormal];
        [btn sizeToFit];
        [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _okBtn = btn;
    }
    return _okBtn;
}

- (UIImageView *)btnMaskView {
    if (!_btnMaskView) {
        UIImage *image = [UIImage imageNamed:@"whiteMask"];
        image = [self targetImage:image maskImage:[[UIColor blackColor] colorWithAlphaComponent:0.71]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.backgroundColor = [UIColor redColor];
        _btnMaskView = imageView;
        
    }
    return _btnMaskView;
}

- (UIImageView *)arrwoView {
    if (!_arrwoView) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fx_guide_arrow_down"]];
        _arrwoView = imageView;
    }
    return _arrwoView;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        tipsLabel.text = @"点击这里\n选择图片添加文字";
        tipsLabel.numberOfLines = 0;
        tipsLabel.textColor = [UIColor whiteColor];
        tipsLabel.font = [UIFont systemFontOfSize:14];
        [tipsLabel sizeToFit];
        _tipsLabel = tipsLabel;
    }
    return _tipsLabel;
}

- (UIView *)topMaskView {
    if (!_topMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _topMaskView = view;
    }
    return _topMaskView;
}

- (UIView *)bottomMaskView {
    if (!_bottomMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _bottomMaskView = view;
    }
    return _bottomMaskView;
}

- (UIView *)leftMaskView {
    if (!_leftMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _leftMaskView = view;
    }
    return _leftMaskView;
}

- (UIView *)rightMaskView {
    if (!_rightMaskView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.71];
        _rightMaskView = view;
    }
    return _rightMaskView;
}


- (UIImage *)targetImage:(UIImage *)targetImage maskImage:(UIColor *)maskColor
{
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, targetImage.CGImage);
    CGContextSetFillColorWithColor(context, maskColor.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

@end
