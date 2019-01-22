//
//  LYTWatermarkSuccessHeadCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/15.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkSuccessHeadCell.h"

@interface LYTWatermarkSuccessHeadCell()

/** 背景图 */
@property (nonatomic, strong) UIImageView *backImageView;
/** 标题 */
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYTWatermarkSuccessHeadCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYTWatermarkSuccessHeadCell";
    
    LYTWatermarkSuccessHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYTWatermarkSuccessHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _setupSubViews];
    }
    return self;
}


- (void)_setupSubViews
{
    CGFloat imageW = 200;
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, imageW));
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(@(40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImageView.mas_bottom).offset(18);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@20);
    }];
    

    self.height = imageW + 40 + 18 + 20 + 30;

}

+ (CGFloat)getCellHeight{
    CGFloat imageW = 200;
    return imageW + 40 + 18 + 20 + 30;
}

- (void)setBackImage:(UIImage *)backImage{
    _backImage = backImage;
    
    self.backImageView.image = backImage;
    
}


#pragma mark - lazy loading
- (UIImageView *)backImageView{
    return LY_LAZY(_backImageView, ({
        UIImageView *imageV = [UIImageView new];
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.layer.cornerRadius = 6;
        imageV.layer.masksToBounds = YES;
        imageV.layer.borderColor = LYCellLineColor.CGColor;
        imageV.layer.borderWidth = LYCellLineHeight;
        [self addSubview:imageV];
        imageV;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"图片已保存到相册";
        view.font = [UIFont boldSystemFontOfSize:14.f];
        [self addSubview:view];
        view;
    }));
}

@end

