//
//  LYEmoticonModel.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseModel.h"

@interface LYEmoticonModel : LYBaseModel

/** 0,熊猫人，1.蘑菇头 ，2.其他 */
@property(nonatomic, copy) NSString *emoticonType;
/** 0,熊猫人，1.蘑菇头 ，2.其他 */
@property(nonatomic, copy) NSString *emoticonName;
/** 对应图片 */
@property(nonatomic, copy) NSString *emoticonUrl;
/** 是否锁 */
@property(nonatomic, assign) BOOL isLock;
/** 能否长按复制 */
@property(nonatomic, assign) BOOL canCopy;

@end
