//
//  LYWaterMarkPopularStatementView.h
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/13.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYWatermarkInputConfig,LYWaterMarkPopularCell;

typedef void(^LYWaterMarkPopularStatementViewBlock)(LYWatermarkInputConfig *config);

@interface LYWaterMarkPopularStatementView : UIView

/** 视图消失的方法 */
- (void)dismiss;

/** block 内容传递 */
@property (nonatomic,copy) LYWaterMarkPopularStatementViewBlock block;
/** 文字框配置 */
@property (nonatomic, strong) LYWatermarkInputConfig *inputConfig;

@end



@interface LYWaterMarkPopularCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, copy) NSString *titleStr;

@end
