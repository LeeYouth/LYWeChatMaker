//
//  LYWatermarkStyleListView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/3.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  样式列表

#import <UIKit/UIKit.h>

typedef void(^LYWatermarkStyleListViewBlock)(UIButton *sender);

@interface LYWatermarkStyleListView : UIView

@property(nonatomic, copy) LYWatermarkStyleListViewBlock block;

@end
