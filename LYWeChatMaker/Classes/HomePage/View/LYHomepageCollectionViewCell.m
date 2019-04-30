//
//  LYHomepageCollectionViewCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/4/29.
//  Copyright © 2019 LYoung_iOS. All rights reserved.
//

#import "LYHomepageCollectionViewCell.h"

#import "LYEmoticonModel.h"

@interface LYHomepageCollectionViewCell()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *tapButton;

@end

@implementation LYHomepageCollectionViewCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;{
    [collectionView registerClass:[LYHomepageCollectionViewCell class] forCellWithReuseIdentifier:@"LYHomepageCollectionViewCell"];
    LYHomepageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYHomepageCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self addSubview:self.backView];
    [self addSubview:self.tapButton];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
    [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
    
}

- (void)setTagType:(NSString *)tagType{
    _tagType = tagType;
    
    NSString *title = @"";
    NSString *detail = @"";
    NSString *image = @"";

    if ([tagType isEqualToString:@"photo"]) {
        title = @"从相册";
        detail = @"为图片添加文字水印";
        image  = @"homepage_list_photo";
    }else if ([tagType isEqualToString:@"xmrEmoji"]){
        title = @"熊猫人";
        detail = @"熊猫人表情包";
        image  = @"homepage_list_xmrEmoji";
    }else if ([tagType isEqualToString:@"mgtEmoji"]){
        title = @"蘑菇头";
        detail = @"蘑菇头表情包";
        image  = @"homepage_list_mgtEmoji";
    }else if ([tagType isEqualToString:@"diyEmoji"]){
        title = @"DIY表情";
        detail = @"DIY表情";
        image  = @"homepage_list_diyEmoji";
    }else if ([tagType isEqualToString:@"text"]){
        title = @"纯文字";
        detail = @"纯文字图片";
        image  = @"homepage_list_text";
    }else if ([tagType isEqualToString:@"setting"]){
        title = @"设置";
        detail = @"设置界面";
        image  = @"homepage_list_setting";
    }
    
    [self.tapButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:14 imagePositionBlock:^(UIButton *button) {
        [button setTitle:title forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }];
    
}

+ (CGSize)getCollectionCellSize{
    return CGSizeMake(kLYHomepageItemSizeWidth, kLYHomepageItemSizeWidth);
}


- (void)tapButtonClick:(UIButton *)sender{
    if (self.didSelected) {
        self.didSelected(self.tagType);
    }
}

#pragma mark - lazy loading
- (UIButton *)tapButton{
    return LY_LAZY(_tapButton, ({
        UIButton *view = [UIButton new];
        [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        view.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [view addTarget:self action:@selector(tapButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        view;
    }));
}
- (UIView *)backView{
    return LY_LAZY(_backView, ({
        UIView *view = [UIView new];
        view.layer.cornerRadius = 12;
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        view;
    }));
}


@end

