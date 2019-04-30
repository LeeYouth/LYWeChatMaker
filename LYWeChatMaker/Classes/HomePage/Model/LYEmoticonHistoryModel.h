//
//  LYEmoticonHistoryModel.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/4/26.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDB.h" //添加该头文件,本类就具有了存储功能.

NS_ASSUME_NONNULL_BEGIN

@interface LYEmoticonHistoryModel : NSObject

/** 保存的历史日期 */
@property(nonatomic,strong) NSDate *historyDate;
/** 保存的合成图片 */
@property(nonatomic,strong) UIImage *compositeImage;
/** 保存的历史文字 */
@property(nonatomic,copy) NSString *historyText;
/** 来自哪里（0.相册 1.表情包 2.做表情）*/
@property(nonatomic,assign) NSInteger fromType;


/** 保存的原图（从相册） */
@property(nonatomic,strong) UIImage *originalImage;

/** 对应图片资源文件名 */
@property(nonatomic, copy) NSString *bundleName;
/** 对应图片资源图片名字 */
@property(nonatomic, copy) NSString *bundleImageName;

/** 表情图片地址对应图片资源文件名 */
@property(nonatomic, copy) NSString *faceBundleName;
/** 表情图片地址对应图片资源图片名字 */
@property(nonatomic, copy) NSString *faceBundleImageName;

@end

NS_ASSUME_NONNULL_END
