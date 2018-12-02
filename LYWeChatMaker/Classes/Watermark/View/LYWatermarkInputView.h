//
//  LYWatermarkInputView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/30.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  水印文本输入视图

#import <UIKit/UIKit.h>
@class LYWatermarkInputView;
#define LYWatermarkInputViewTextMinW 160
#define LYWatermarkInputViewTextMinH 40
#define LYWatermarkInputViewTextMinWMargin 40
#define LYWatermarkInputViewTextMinHMargin 20


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

/** 文字颜色 */
@property (nonatomic, copy) NSString *colorHex;
/** 是否选中了背景颜色 */
@property (nonatomic, assign) BOOL selectBack;
/** 输入的文字 */
@property (nonatomic, copy) NSString *inputText;



/** 是否显示旋转按钮（默认为NO） */
@property (nonatomic, assign) BOOL showRotation;
/** 是否显示边框（默认为NO） */
@property (nonatomic, assign) BOOL showBorder;
/** 代理 */
@property(nonatomic, assign) id<LYWatermarkInputViewDelegate>delegate;

/** 开始动画 */
- (void)startRectangleViewAnimation;

@end
