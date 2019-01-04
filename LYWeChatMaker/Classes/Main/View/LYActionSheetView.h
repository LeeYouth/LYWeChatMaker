//
//  LYActionSheetView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/10.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LYActionSheetViewBlock)(NSInteger buttonIndex);

@interface LYActionSheetView : UIView

/** 快速构造方法 */
+ (instancetype)sharedInstance;

/** 显示弹框 */
- (void)showInViewWithTitles:(NSMutableArray *)titles animated:(BOOL)animated;

/** 关闭当前pickView */
- (void)close;

@property(nonatomic, copy) LYActionSheetViewBlock btnBlock;

@end



#pragma mark - 自定义的MTActionSheetView的cell
@interface LYActionSheetViewCell : UITableViewCell
/** 初始化类方法 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/** 赋值 */
- (void)configCellWithTitle:(NSString *)title isCancel:(BOOL)isCancel;
@end
