//
//  LYWatermarkInputConfig.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/4.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYWatermarkInputConfig : NSObject

/** 文字颜色 */
@property (nonatomic, copy) NSString *colorHex;
/** 输入的文字 */
@property (nonatomic, copy) NSString *inputText;
/** 是否选中了背景颜色(默认为NO) */
@property (nonatomic, assign) BOOL selectBack;
/** 是否选中了加粗(默认为NO) */
@property (nonatomic, assign) BOOL selectBold;
/** 是否选中了阴影(默认为NO) */
@property (nonatomic, assign) BOOL selectShadow;
/** 是否选中了秒表(默认为NO) */
@property (nonatomic, assign) BOOL selectStroke;

@end
