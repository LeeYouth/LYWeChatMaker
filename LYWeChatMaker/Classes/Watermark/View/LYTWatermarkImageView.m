//
//  LYTWatermarkImageView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkImageView.h"
#import <UIKit/UIKit.h>
#import "LYWatermarkInputView.h"

@interface LYTWatermarkImageView()

/** 背景图 */
@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) LYWatermarkInputView *inputView;

@end

@implementation LYTWatermarkImageView

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
 
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(LYWatermarkInputViewTextMinW + 2*LYWatermarkInputViewTextMinWMargin + 15, LYWatermarkInputViewTextMinH + 2*LYWatermarkInputViewTextMinHMargin + 15));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    //双手缩放
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [self addGestureRecognizer:pinchGesture];
    
    //单指拖动
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self addGestureRecognizer:panGesture];
    
    //旋转
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [self addGestureRecognizer:rotationGesture];
}
#pragma mark - 双手缩放
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = self.inputView;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

#pragma mark - 单指拖动
- (void)panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = self.inputView;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}

#pragma mark - 旋转
- (void)rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = self.inputView;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

#pragma mark - 输入框的变化 LYWatermarkInputViewDelegate
#pragma mark 拖动
- (void)LYWatermarkInputView:(id)inputView didViewTransformWithGesture:(YYGestureRecognizer *)gesture{
    
}
#pragma mark - 更新输入框约束
- (void)updateInputViewLayout:(YYGestureRecognizer *)gesture
{
//    [self.inputView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(size);
//        make.centerX.equalTo(self.mas_centerX);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    
    CGSize size = [self getImageViewSizeWithImage:backImage];
    self.backImageView.image = backImage;
    [self.backImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
 
    
}

- (void)setColorHex:(NSString *)colorHex{
    _colorHex = colorHex;
    
    self.inputView.colorHex = colorHex;
}
- (void)setSelectBack:(BOOL)selectBack{
    _selectBack = selectBack;
    self.inputView.selectBack = selectBack;
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
        iconW = SCREEN_WIDTH;
        iconH = iconW*photoScale1;
    }else{
        iconH = self.frame.size.height;
        iconW = iconH*photoScale;
    }
    return CGSizeMake(iconW, iconH);
}

- (void)drawImageAtImageContext{
    CGSize maxSize = [self getImageViewSizeWithImage:self.backImage];
    UIGraphicsBeginImageContextWithOptions(maxSize, NO, 0.0);
    UIImage *image = self.backImage;
    [image drawInRect:CGRectMake(0, 0, maxSize.width, maxSize.height)];
    
    NSString *str = @"中华小当家";
    [str drawInRect:CGRectMake(0, 50, maxSize.width, 50) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:30],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.backImageView.image = newImage;
    [self loadImageFinished:newImage];


}
- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}


//- (void)loadImageFinished:(UIImage *)image
//{
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//
//        //写入图片到相册
//        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
//
//
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//
//        NSLog(@"success = %d, error = %@", success, error);
//
//    }];
//}

#pragma mark - lazy loading
- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *imageV = [UIImageView new];
        [self addSubview:imageV];
        imageV;
    }));
}
#pragma mark - lazy loading
- (LYWatermarkInputView *)inputView{
    return LY_LAZY(_inputView, ({
        WEAKSELF(weakSelf);
        LYWatermarkInputView *putView = [[LYWatermarkInputView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        putView.showRotation = YES;
        putView.showBorder = YES;
        [self addSubview:putView];
        putView;
    }));
}


@end
