//
//  LYWatermarkInputView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/30.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkInputView.h"
#import "LYWatermarkEditTextView.h"
#import "LYDrawRectangleView.h"
#import "MSWeakTimer.h"
#import "LYWatermarkInputConfig.h"
#import "LYWatermarkInputLabel.h"

CG_INLINE CGPoint LYCGRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CG_INLINE CGRect CGRectScale(CGRect rect, CGFloat wScale, CGFloat hScale) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width * wScale, rect.size.height * hScale);
}

CG_INLINE CGFloat CGAffineTransformGetAngle(CGAffineTransform t) {
    return atan2(t.b, t.a);
}

CG_INLINE CGFloat CGPointGetDistance(CGPoint point1, CGPoint point2) {
    CGFloat fx = (point2.x - point1.x);
    CGFloat fy = (point2.y - point1.y);
    return sqrt((fx * fx + fy * fy));
}


@interface LYWatermarkInputView()<UIGestureRecognizerDelegate>
{
    /**
     *  Variables for rotating and resizing view
     */
    CGRect initialBounds;
    CGFloat initialDistance;
    CGFloat deltaAngle;
}


/** 文字水印背景 */
@property (nonatomic, strong) LYDrawRectangleView *rectangleView;
/** 拖动按钮 */
@property (nonatomic, strong) UIImageView *rotationView;
/** 文字水印 */
@property (nonatomic, strong) LYWatermarkInputLabel *markLabel;
/** timer */
@property (nonatomic, strong) MSWeakTimer *timer;

@property (nonatomic) CGPoint prevPoint;

@end

@implementation LYWatermarkInputView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
     
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews
{
    [self addSubview:self.rectangleView];
    [self addSubview:self.markLabel];
    [self addSubview:self.rotationView];
    self.rotationView.hidden = YES;
    
    CGFloat btnW = 30;

    [self.rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(btnW/2);
        make.right.equalTo(self.mas_right).offset(-btnW/2);
        make.top.equalTo(self.mas_top).offset(btnW/2);
        make.bottom.equalTo(self.mas_bottom).offset(-btnW/2);
    }];
    CGFloat markTop = LYWatermarkInputViewTextMinHMargin + btnW/2;
    CGFloat markLeft = LYWatermarkInputViewTextMinWMargin + btnW/2;

    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.rectangleView);
//        make.left.equalTo(self.mas_left).offset(markLeft);
//        make.right.equalTo(self.mas_right).offset(-markLeft);
//        make.top.equalTo(self.mas_top).offset(markTop);
//        make.bottom.equalTo(self.mas_bottom).offset(-markTop);
    }];
    
    [self.rotationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rectangleView.mas_bottom).offset(-btnW/2);
        make.left.equalTo(self.rectangleView.mas_right).offset(-btnW/2);
        make.size.mas_equalTo(CGSizeMake(btnW, btnW));
    }];
    
    //双击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    tapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGesture];
    
//    UIPanGestureRecognizer *gesture5 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onScaleAndRotate:)];
//    [self.rotationView addGestureRecognizer:gesture5];
    
    
}



#pragma mark - 开始矩形闪烁东湖
- (void)startRectangleViewAnimation
{
    self.timer = [MSWeakTimer scheduledTimerWithTimeInterval:1.7
                                                      target:self
                                                    selector:@selector(repeatsViewAnimation)
                                                    userInfo:nil
                                                     repeats:YES
                                               dispatchQueue:dispatch_get_main_queue()];
}
#pragma  闪烁东湖
- (void)repeatsViewAnimation
{
    self.rectangleView.alpha = 0.8;
    [UIView beginAnimations:@"scanLine" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.rectangleView.alpha = 0.05;
    [UIView commitAnimations];
}

#pragma mark - 单指操作
-(void)onScaleAndRotate:(UIPanGestureRecognizer*)gesture
{


    UIView *viewCtrl = gesture.view;
    UIView *viewImg = self;

    CGPoint center = viewImg.center;
    CGPoint prePoint = viewCtrl.center;
    CGPoint translation = [gesture translationInView:gesture.view];
    CGPoint curPoint = CGPointMake(prePoint.x+translation.x, prePoint.y+translation.y);

    // 计算缩放
    CGFloat preDistance = [self getDistance:prePoint withPointB:center];
    CGFloat curDistance = [self getDistance:curPoint withPointB:center];
    CGFloat scale = curDistance / preDistance;

    // 计算弧度
    CGFloat preRadius = [self getRadius:center withPointB:prePoint];
    CGFloat curRadius = [self getRadius:center withPointB:curPoint];
    CGFloat radius = curRadius - preRadius;
    radius = - radius;
    CGAffineTransform transform = CGAffineTransformScale(viewImg.transform, scale, scale);
    viewImg.transform = CGAffineTransformRotate(transform, radius);

    viewCtrl.frame = [viewImg convertRect:self.rotationView.frame toView:self];
    [gesture setTranslation:CGPointZero inView:viewCtrl];
}
-(CGFloat)getDistance:(CGPoint)pointA withPointB:(CGPoint)pointB
{
    CGFloat x = pointA.x - pointB.x;
    CGFloat y = pointA.y - pointB.y;
    return sqrt(x*x + y*y);
}

-(CGFloat)getRadius:(CGPoint)pointA withPointB:(CGPoint)pointB
{
    CGFloat x = pointA.x - pointB.x;
    CGFloat y = pointA.y - pointB.y;
    return atan2(x, y);
}

#pragma mark - 单指点击
- (void)tapView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    
    if (_showBorder)
    {
        WEAKSELF(weakSelf);
        LYWatermarkEditTextView *textEditView = [[LYWatermarkEditTextView alloc] init];
        textEditView.inputConfig = self.inputConfig;
        textEditView.block = ^(LYWatermarkInputConfig *config) {
            weakSelf.inputConfig = config;
        };
    }
}

#pragma mark - 双手缩放
- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    if (_delegate && [_delegate respondsToSelector:@selector(LYWatermarkInputView:didPanView:)]) {
        [_delegate LYWatermarkInputView:self didPinchView:pinchGestureRecognizer];
    }
    UIView *view = self;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}



- (void)setInputConfig:(LYWatermarkInputConfig *)inputConfig{
    _inputConfig = inputConfig;
    
    //是否加粗
    if (inputConfig.selectBold) {
        self.markLabel.font = [UIFont boldSystemFontOfSize:LYWatermarkInputViewFont];
    }else{
        self.markLabel.font = LYSystemFont(LYWatermarkInputViewFont);
    }
    
    if (![inputConfig.fontName isEqualToString:@"defult"]) {
        self.markLabel.font = [UIFont fontWithName:inputConfig.fontName size:LYWatermarkInputViewFont];
    }
   
    //是否阴影
    if (inputConfig.selectShadow) {
        
        //设置阴影的颜色和阴影的偏移位置
        self.markLabel.shadowColor = LYColor(LYBlackColorHex);
        self.markLabel.shadowOffset = CGSizeMake(3.0,3.0);
        self.markLabel.shadowBlur = 4;

    }else{
        self.markLabel.shadowColor = LYColor(@"#A9A9A9");
        self.markLabel.shadowOffset = CGSizeMake(0.0,0.0);
        self.markLabel.shadowBlur = 0;
    }
    //是否描边
    if (inputConfig.selectStroke) {
//        if ([inputConfig.colorHex isEqualToString:LYBlackColorHex]) {
//            self.markLabel.strokeColor = LYColor(LYWhiteColorHex);
//        }else{
//            self.markLabel.strokeColor = LYColor(LYBlackColorHex);
//        }
        self.markLabel.strokeSize = 6;
    }else{
//        self.markLabel.strokeColor = LYColor(LYBlackColorHex);
        self.markLabel.strokeSize = 0;
    }

    
    if (inputConfig.selectBack) {
        //选择了背景
        if ([inputConfig.colorHex isEqualToString:LYWhiteColorHex]) {
            self.markLabel.textColor = LYColor(LYBlackColorHex);
        }else{
            self.markLabel.textColor = LYColor(LYWhiteColorHex);
        }
        self.markLabel.backgroundColor = LYColor(inputConfig.colorHex);
    }else{
        self.markLabel.textColor = LYColor(inputConfig.colorHex);
        self.markLabel.backgroundColor = [UIColor clearColor];
    }
    
    //输入的文字
    if (inputConfig.inputText.length) {
        self.markLabel.text = inputConfig.inputText;
    }else{
        self.markLabel.text = LYWatermarkInputViewDefultText;
    }
    
}

- (void)setShowRotation:(BOOL)showRotation{
    _showRotation = showRotation;
    
    self.rotationView.hidden = !showRotation;
}

- (void)setShowBorder:(BOOL)showBorder{
    _showBorder = showBorder;
    
    if (showBorder) {
        self.rectangleView.borderColor = LYThemeColor;
    }
}

- (void)setHiddenBox:(BOOL)hiddenBox{
    _hiddenBox = hiddenBox;
    self.rectangleView.hidden = hiddenBox;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
}


- (void)dealloc{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 懒加载
- (LYWatermarkInputLabel *)markLabel{
    return LY_LAZY(_markLabel, ({
        LYWatermarkInputLabel *label = [LYWatermarkInputLabel new];
        label.userInteractionEnabled = YES;
        label.numberOfLines = 0;
        label.font = [UIFont fontWithName:@"Hanyi Senty Journal" size:LYWatermarkInputViewFont];

//        label.font = LYSystemFont(LYWatermarkInputViewFont);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = LYWatermarkInputViewDefultText;
        label.adjustsFontSizeToFitWidth = YES;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        label.backgroundColor = [UIColor clearColor];
        label;
    }));
}
- (UIImageView *)rotationView{
    return LY_LAZY(_rotationView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.userInteractionEnabled = YES;
        view.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"waterMark_scale")];
        [self addSubview:view];
        view;
    }));
}
- (LYDrawRectangleView *)rectangleView{
    return LY_LAZY(_rectangleView, ({
        LYDrawRectangleView *view = [[LYDrawRectangleView alloc] initWithFrame:CGRectMake(20, 50, 100, 100)];
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
        view;
    }));
}
@end
