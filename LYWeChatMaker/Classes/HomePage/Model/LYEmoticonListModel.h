//
//  LYEmoticonListModel.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/6.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseModel.h"

@interface LYEmoticonListModel : LYBaseModel

/** 0,熊猫人，1.蘑菇头 ，2.其他 */
@property(nonatomic, copy) NSString *emoticonType;
/** 表情包介绍 */
@property(nonatomic, copy) NSString *emoticonIntro;
/** 0,熊猫人，1.蘑菇头 ，2.其他 */
@property(nonatomic, copy) NSString *emoticonName;
/** 对应图片 */
@property(nonatomic, copy) NSString *emoticonUrl;
/** 是否锁 */
@property(nonatomic, assign) BOOL isLock;
/** 能否长按复制 */
@property(nonatomic, assign) BOOL canCopy;

@end
