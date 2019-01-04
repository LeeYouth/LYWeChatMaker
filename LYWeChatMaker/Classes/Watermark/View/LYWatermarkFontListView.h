//
//  LYWatermarkFontListView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/17.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  字体列表

#import <UIKit/UIKit.h>
typedef void(^LYWatermarkFontListViewBlock)(UIButton *sender);

@interface LYWatermarkFontListView : UIView

@property(nonatomic, copy) LYWatermarkFontListViewBlock block;

@end
