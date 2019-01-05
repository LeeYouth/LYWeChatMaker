//
//  LYTWatermarkTopToolBar.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/10.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  顶部按钮工具栏

#import <UIKit/UIKit.h>


typedef void(^LYTWatermarkTopToolBarBlock)(NSInteger index);

@interface LYTWatermarkTopToolBar : UIView

@property(nonatomic, copy) LYTWatermarkTopToolBarBlock block;

@end
