//
//  LYLaunchModel.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/2/12.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  启动页接口数据模型

#import "LYBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LYLaunchModel : LYBaseModel

/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 1.（admob）广告 2.公告 */
@property(nonatomic, copy) NSString *type;
/**  0 不显示 1 显示 */
@property(nonatomic, copy) NSString *showStatus;
/** 图片地址 */
@property(nonatomic, copy) NSString *imageUrl;
/** 跳转详情页地址  */
@property(nonatomic, copy) NSString *detailUrl;

@end

NS_ASSUME_NONNULL_END
