//
//  LYEmoticonPackageListCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYEmoticonPackageListCell.h"

@interface LYEmoticonPackageListCell()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LYEmoticonPackageListCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath;{
    [collectionView registerClass:[LYEmoticonPackageListCell class] forCellWithReuseIdentifier:@"LYEmoticonPackageListCell"];
    LYEmoticonPackageListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYEmoticonPackageListCell" forIndexPath:indexPath];
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
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - lazy loading
- (UIImageView *)imageView{
    return LY_LAZY(_imageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}

@end
