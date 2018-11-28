//
//  UIColor+MTColorTool.h
//  Mita
//
//  Created by CNFOL_iOS on 2017/3/9.
//  Copyright © 2017年 mita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MTColorTool)

/**
 *  字符串转换称颜色
 *
 *  @param stringToConvert 需要填充的颜色
 *
 *  @return RGB值
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
