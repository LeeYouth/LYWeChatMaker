//
//  LYWatermarkBottomBtnsView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/2.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  底部功能按钮

#import <UIKit/UIKit.h>

#define LYWatermarkBottomBtnsViewH 44.f

typedef void(^LYWatermarkBottomBtnsViewBlock)(NSInteger index);

@interface LYWatermarkBottomBtnsView : UIView

@property(nonatomic, copy) LYWatermarkBottomBtnsViewBlock block;

@end
