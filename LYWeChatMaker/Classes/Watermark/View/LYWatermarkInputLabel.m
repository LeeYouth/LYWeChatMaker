//
//  LYWatermarkInputLabel.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/4.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkInputLabel.h"

@implementation LYWatermarkInputLabel

- (void)drawTextInRect:(CGRect)rect
{
    CGSize shadowOffset  = self.shadowOffset;
    UIColor *textColor   = self.textColor;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //描边
    CGContextSetLineWidth(context, [self hasStroke]?self.strokeSize:0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetTextDrawingMode(context, kCGTextStroke);
    
    BOOL compareResult = [self compareRGBAColor1:textColor withColor2:[UIColor blackColor]];
    if (compareResult) {
        self.textColor = LYColor(LYWhiteColorHex);
    } else {
        LYLog(@"颜色不一致");
        self.textColor = LYColor(LYBlackColorHex);
    }
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(context, kCGTextFill);
    self.textColor = textColor;
    self.shadowOffset = CGSizeMake(0, 0);
    [super drawTextInRect:rect];
    
    self.shadowOffset = shadowOffset;
}


- (BOOL)compareRGBAColor1:(UIColor *)color1 withColor2:(UIColor *)color2 {
    
    CGFloat red1,red2,green1,green2,blue1,blue2,alpha1,alpha2;
    //取出color1的背景颜色的RGBA值
    [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    //取出color2的背景颜色的RGBA值
    [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
    
    NSLog(@"1:%f %f %f %f",red1,green1,blue1,alpha1);
    NSLog(@"2:%f %f %f %f",red2,green2,blue2,alpha2);
    
    if ((red1 == red2)&&(green1 == green2)&&(blue1 == blue2)&&(alpha1 == alpha2)) {
        return YES;
    } else {
        return NO;
    }
}


- (BOOL)hasShadow {
    return self.shadowColor && ![self.shadowColor isEqual:[UIColor clearColor]] && (self.shadowBlur > 0.0 || !CGSizeEqualToSize(self.shadowOffset, CGSizeZero));
}

- (BOOL)hasStroke {
    return self.strokeSize > 0.0 && ![self.strokeColor isEqual:[UIColor clearColor]];
}

@end
