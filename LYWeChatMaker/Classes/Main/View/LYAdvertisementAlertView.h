//
//  LYAdvertisementAlertView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  弹框

#import <UIKit/UIKit.h>

typedef void(^LYAdvertisementAlertViewBlock)(NSInteger index);

@interface LYAdvertisementAlertView : UIView

+ (LYAdvertisementAlertView *)showInView:(UIView *)view
                               theADInfo: (NSArray *)dataList;

@property(nonatomic, copy) LYAdvertisementAlertViewBlock block;

@end


@interface LYItemView : UIView
/** 当前item */
@property(nonatomic,assign) NSInteger index;
/** 显示的imageView */
@property(nonatomic,strong) UIImageView*imageView;
@end

@interface LYAdModel : NSObject
@property(nonatomic,copy) NSString *linkUrl;
@property(nonatomic,copy) NSString *imageUrl;
@end
