//
//  LYImagesDownloadManager.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/18.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYImagesDownloadManager.h"
#import "SDWebImageDownloader.h"

@implementation LYImagesDownloadManager

+ (void)downloadImages:(NSArray<NSString *> *)imgsArray completion:(void(^)(NSArray *resultArray))completionBlock {
    SDWebImageDownloader *manager = [SDWebImageDownloader sharedDownloader];
    manager.downloadTimeout = 20;
    __block NSMutableDictionary *resultDict = [NSMutableDictionary new];
    for(int i=0;i<imgsArray.count;i++) {
        NSString *imgUrl = [imgsArray objectAtIndex:i];
        
        [manager downloadImageWithURL:[NSURL URLWithString:imgUrl] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if(finished){
                if(error){
                    //在对应的位置放一个error对象
                    [resultDict setObject:error forKey:@(i)];
                }else{
                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                        
                        //1,保存图片到系统相册
                        [PHAssetChangeRequest creationRequestForAssetFromImage:image];
                        
                    } completionHandler:^(BOOL success, NSError * _Nullable error) {
                        
                        if (!success) return ;
                        NSLog(@"保存成功");
                    }];

                    [resultDict setObject:image forKey:@(i)];
                }
                if(resultDict.count == imgsArray.count) {
                    //全部下载完成
                    NSArray *resultArray = [LYImagesDownloadManager createDownloadResultArray:resultDict count:imgsArray.count];
                    if(completionBlock){
                        completionBlock(resultArray);
                    }
                }
            }
        }];
    }
}

+ (NSArray *)createDownloadResultArray:(NSDictionary *)dict count:(NSInteger)count {
    NSMutableArray *resultArray = [NSMutableArray new];
    for(int i=0;i<count;i++) {
        NSObject *obj = [dict objectForKey:@(i)];
        [resultArray addObject:obj];
    }
    return resultArray;
}

@end
