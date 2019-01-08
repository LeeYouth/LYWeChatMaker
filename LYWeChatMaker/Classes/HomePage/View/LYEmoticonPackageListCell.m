//
//  LYEmoticonPackageListCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/26.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYEmoticonPackageListCell.h"
#import "LYEmoticonModel.h"

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

- (void)setModel:(LYEmoticonModel *)model{
    _model = model;
    
    self.imageView.image = [UIImage imageWithContentsOfFile:model.emoticonUrl];
}

- (void)longPressClick:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state != UIGestureRecognizerStateBegan) return;
    
    if (self.model.unLock) {
        
        WEAKSELF(weakSelf);
        //已解锁,弹出保存框
        LYEnsureOrCancelAlertView *alertView = [LYEnsureOrCancelAlertView sharedInstance];
        [alertView showInViewWithTitle:@"保存到相册" leftTitle:@"取消" rightTitle:@"保存" animated:YES];
        alertView.btnBlock = ^(UIButton *sender) {
            if (sender.tag == 0)
            {
                
            }else if (sender.tag == 1)
            {
                //保存
                [weakSelf saveImageClick];
            }
        };

    }else{
        if (self.block) {
            self.block(nil);
        }
    }
}

- (void)saveImageClick
{
    UIImage *savedImage = [UIImage imageWithContentsOfFile:self.model.emoticonUrl];
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}


// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        
    }else{
        msg = @"保存图片成功" ;
    }
    [LYToastTool bottomShowWithText:msg delay:1.f];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

#pragma mark - lazy loading
- (UIImageView *)imageView{
    return LY_LAZY(_imageView, ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFit;
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
        [view addGestureRecognizer:gesture];
        view;
    }));
}

@end
