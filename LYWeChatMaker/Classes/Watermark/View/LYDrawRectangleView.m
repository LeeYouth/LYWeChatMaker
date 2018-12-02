//
//  LYDrawRectangleView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/1.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYDrawRectangleView.h"

@interface LYDrawRectangleView()

@end

@implementation LYDrawRectangleView

- (void)drawRect:(CGRect)rect
{
    CGFloat lineWidth = 6.f;

    if (self.borderColor) {
        [self.borderColor set];
    }else{
        [[UIColor clearColor] set];
    }
    // 创建矩形路径对象
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:rect];
    path.lineWidth     = lineWidth;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    [path stroke];
    
    /* 初始化一个layer */
    CAShapeLayer *border = [CAShapeLayer layer];
    /* 虚线的颜色 */
    border.strokeColor = [UIColor whiteColor].CGColor;
    /* 填充虚线内的颜色 */
    border.fillColor = nil;
    /* 贝塞尔曲线路径 */
    border.path = [UIBezierPath bezierPathWithRect:CGRectMake(1.5, 1.5, rect.size.width - 3, rect.size.height - 3)].CGPath;
    /* 虚线宽度 */
    border.lineWidth = 0.7;
    //border.frame = view.bounds; /* 这个因为给了路径, 而且用的约束给的控件尺寸, 所以没什么效果 */
    /* 官方API注释:The cap style used when stroking the path. Options are `butt', `round'
     * and `square'. Defaults to `butt'. */
    /* 意思是沿路径画帽时的样式 有三种 屁股 ; 圆; 广场 ,我没感觉有啥区别 可以自己试一下*/
    border.lineCap = @"square";
    /* 虚线的每个点长  和 两个点之间的空隙 */
    border.lineDashPattern = @[@3, @2];
    /* 添加到你的控件上 */
    [self.layer addSublayer:border];
   
    
}


@end
