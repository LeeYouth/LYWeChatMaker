//
//  LYWatermarkInputView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/30.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  水印文本输入视图

#import <UIKit/UIKit.h>
@class LYWatermarkInputView,LYWatermarkInputConfig;
#define LYWatermarkInputViewTextMinW 160
#define LYWatermarkInputViewTextMinH 40
#define LYWatermarkInputViewTextMinWMargin 40
#define LYWatermarkInputViewTextMinHMargin 20
#define LYWatermarkInputViewFont 30.f

@protocol LYWatermarkInputViewDelegate <NSObject>
@required
/** 单指拖动 */
- (void)LYWatermarkInputView:(LYWatermarkInputView *)inputView didPanView:(UIPanGestureRecognizer *)panGestureRecognizer;
/** 双指缩放 */
- (void)LYWatermarkInputView:(LYWatermarkInputView *)inputView didPinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer;
/** 旋转 */
- (void)LYWatermarkInputView:(LYWatermarkInputView *)inputView didRrotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer;

@end

@interface LYWatermarkInputView : UIView

/** 文字框配置 */
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;



/** 是否显示旋转按钮（默认为NO） */
@property (nonatomic, assign) BOOL showRotation;
/** 是否显示边框（默认为NO） */
@property (nonatomic, assign) BOOL showBorder;
/** 隐藏边框（默认为NO） */
@property (nonatomic, assign) BOOL hiddenBox;

/** 代理 */
@property(nonatomic, assign) id<LYWatermarkInputViewDelegate>delegate;

/** 开始动画 */
- (void)startRectangleViewAnimation;

@end



