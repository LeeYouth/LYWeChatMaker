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
/** 对应图片资源文件名 */
@property(nonatomic, copy) NSString *bundleName;
/** 对应图片资源图片名字 */
@property(nonatomic, copy) NSString *bundleImageName;
/** 拼接的地址*/
@property(nonatomic, copy) NSString *paddingSourceUrl;
/** 是否已解锁 */
@property(nonatomic, assign) BOOL unLock;


@end
