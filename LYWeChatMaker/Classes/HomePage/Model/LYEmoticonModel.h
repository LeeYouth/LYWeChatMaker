//
//  LYEmoticonModel.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/4.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYBaseModel.h"

@interface LYEmoticonModel : LYBaseModel

/** 表情包图片 */
@property(nonatomic, strong) UIImage *emoticonImage;
/** 表情包名字 */
@property(nonatomic, copy) NSString *emoticonName;
/** 对应图片 */
@property(nonatomic, copy) NSString *emoticonUrl;
/** 是否已解锁 */
@property(nonatomic, assign) BOOL unLock;

@end
