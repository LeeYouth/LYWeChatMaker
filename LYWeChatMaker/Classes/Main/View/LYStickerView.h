//
//  LYStickerView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  可变化的view

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, LYStickerViewHandler) {
    LYStickerViewHandlerClose,
    LYStickerViewHandlerRotate,
    LYStickerViewHandlerFlip
};

typedef NS_ENUM (NSInteger, LYStickerViewPosition) {
    LYStickerViewPositionTopLeft,
    LYStickerViewPositionTopRight,
    LYStickerViewPositionBottomLeft,
    LYStickerViewPositionBottomRight
};

@class LYStickerView;

@protocol LYStickerViewDelegate <NSObject>
@optional
- (void)stickerViewDidBeginMoving:(LYStickerView *)stickerView;
- (void)stickerViewDidChangeMoving:(LYStickerView *)stickerView;
- (void)stickerViewDidEndMoving:(LYStickerView *)stickerView;
- (void)stickerViewDidBeginRotating:(LYStickerView *)stickerView;
- (void)stickerViewDidChangeRotating:(LYStickerView *)stickerView;
- (void)stickerViewDidEndRotating:(LYStickerView *)stickerView;
- (void)stickerViewDidClose:(LYStickerView *)stickerView;
- (void)stickerViewDidTap:(LYStickerView *)stickerView;
@end

@interface LYStickerView : UIView
@property (nonatomic, weak) id <LYStickerViewDelegate> delegate;
/// The contentView inside the sticker view.
@property (nonatomic, strong, readonly) UIView *contentView;
/// Enable the close handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableClose;
/// Enable the rotate/resize handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableRotate;
/// Enable the flip handler or not. Default value is YES.
@property (nonatomic, assign) BOOL enableFlip;
/// Show close and rotate/resize handlers or not. Default value is YES.
@property (nonatomic, assign) BOOL showEditingHandlers;
/// Minimum value for the shorter side while resizing. Default value will be used if not set.
@property (nonatomic, assign) NSInteger minimumSize;
/// Color of the outline border. Default: brown color.
@property (nonatomic, strong) UIColor *outlineBorderColor;
/// A convenient property for you to store extra information.
@property (nonatomic, strong) NSDictionary *userInfo;

/**
 *  Initialize a sticker view. This is the designated initializer.
 *
 *  @param contentView The contentView inside the sticker view.
 *                     You can access it via the `contentView` property.
 *
 *  @return The sticker view.
 */
- (id)initWithContentView:(UIView *)contentView;

/**
 *  Use image to customize each editing handler.
 *  It is your responsibility to set image for every editing handler.
 *
 *  @param image   The image to be used.
 *  @param handler The editing handler.
 */
- (void)setImage:(UIImage *)image forHandler:(LYStickerViewHandler)handler;

/**
 *  Customize each editing handler's position.
 *  If not set, default position will be used.
 *  @note  It is your responsibility not to set duplicated position.
 *
 *  @param position The position for the handler.
 *  @param handler  The editing handler.
 */
- (void)setPosition:(LYStickerViewPosition)position forHandler:(LYStickerViewHandler)handler;

/**
 *  Customize handler's size
 *
 *  @param size Handler's size
 */
- (void)setHandlerSize:(NSInteger)size;
@end
