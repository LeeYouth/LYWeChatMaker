//
//  LYEmoticonPackageListViewController.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYBaseViewController.h"
#import "LYEmoticonModel.h"
@class LYEmoticonPackageListViewController;

@protocol LYEmoticonPackageListViewControllerDelegate <NSObject>


@optional
- (void)emoticonPackageListViewController:(LYEmoticonPackageListViewController *)lister didFinishPickingPhotos:(NSArray<LYEmoticonModel *> *)photos;

@end

@interface LYEmoticonPackageListViewController : LYBaseViewController


/**
 自定义数据源
 
 @param imageArray 图片数组
 @param title 标题
 @param delegate 代理
 */
- (instancetype)initWithIamgeArray:(NSMutableArray *)imageArray title:(NSString *)title showAdd:(BOOL)showAdd delegate:(id<LYEmoticonPackageListViewControllerDelegate>)delegate;

@property (nonatomic, weak) id<LYEmoticonPackageListViewControllerDelegate> delegate;
/** 大数组存放更多数据 */
@property (nonatomic ,strong) NSMutableArray *dataListArray;
/** 展示添加按钮（默认为no） */
@property (nonatomic ,assign) BOOL showAdd;

@end
