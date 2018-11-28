
//  UIImage+Extention.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//  UIImage 分类

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name;
+ (UIImage *)resizableImagemiddle:(NSString *)name;
+ (UIImage *)createImageWithColor:(UIColor *)color rect:(CGRect)rect;
+ (UIImage *) createImageWithColor: (UIColor*) color;
- (UIImage *)imageFromSzie:(CGSize)size;

/**
 * 圆形图片
 */
- (UIImage *)circleImage;
/**
 *  压缩图片
 *
 *  @param image 图片
 *
 *  @return 返回一张小于1M的图片
 */
+ (UIImage *)compressPicturesWithImage:(UIImage *)image;

/**
 *  等比例压缩图片到最大宽度
 *
 *  @param image    原图
 *  @param maxWidth 最大宽度
 *
 *  @return 返回等比例压缩的最大宽度
 */
+ (UIImage *)imageWithImageSimple:(UIImage *)image scaledToMaxWidth:(CGFloat)maxWidth;

/**
 *  返回一张指定尺寸的图片
 *
 *  @param image image对象
 *  @param size  指定尺寸
 *
 *  @return 返回一张指定尺寸的图片
 */
+ (UIImage*)imageWithImageSimple:(UIImage *)image scaleToSize:(CGSize)size;

/**
 *  @img :要模糊对象
 *   @alpha : 模糊度
 ＊    @frame ：返回图片大小
 **/
+ (UIImage *)blurImg:(UIImage *)img withAlpha:(CGFloat)alpha andrect:(CGRect)frame;
/**
 *  @img :毛玻璃
 *   @blur : 模糊度
 **/
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;


/**
 设置图片的透明度

 @param alpha 图片透明度值
 @param image 需要透明的图片
 @return 处理后的图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

@end
