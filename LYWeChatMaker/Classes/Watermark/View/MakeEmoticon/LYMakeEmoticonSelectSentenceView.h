//
//  LYMakeEmoticonSelectSentenceView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//  选一句流行句子

#import <UIKit/UIKit.h>
@class LYMakeEmoticonSelectSentenceCell;

typedef void(^LYMakeEmoticonSelectSentenceViewBlock)(NSString *title);

NS_ASSUME_NONNULL_BEGIN

@interface LYMakeEmoticonSelectSentenceView : UIView

+ (instancetype)sharedInstance;
- (void)showInViewWithAnimated:(BOOL)animated;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSourece;
/** 选中回调 */
@property (nonatomic, copy) LYMakeEmoticonSelectSentenceViewBlock block;

@end



@interface LYMakeEmoticonSelectSentenceCell : UITableViewCell
/** 初始化类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 赋值 */
@property(nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
