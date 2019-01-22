//
//  LYImagesDownloadManager.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/18.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYImagesDownloadManager : NSObject

+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock;

+ (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
