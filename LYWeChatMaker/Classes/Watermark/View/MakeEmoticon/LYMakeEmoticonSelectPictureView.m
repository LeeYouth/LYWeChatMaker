//
//  LYMakeEmoticonSelectPictureView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonSelectPictureView.h"
#import "LYMakeEmoticonImageCell.h"
#import "LYEmoticonModel.h"

@interface LYMakeEmoticonSelectPictureView()
/// 包装选择器
@property (nonatomic, strong) UIView *contentView;
/// 蒙板
@property (nonatomic, strong) UIView *cover;
/// 表情包列表视图
@property (nonatomic, strong) LYCustomEmojiCollectionView *emojiCollectionView;
///
@property (nonatomic, strong) UIPageControl *emojiPageControl;

@end

@implementation LYMakeEmoticonSelectPictureView

/// 快速创建pickerview方法
+ (instancetype)sharedInstance{
    LYMakeEmoticonSelectPictureView *view = [[LYMakeEmoticonSelectPictureView alloc] init];
    return view;
}

/// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubViews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = LYClearColor;
    }
    return self;
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
#pragma -mark 添加子控件
    [self addSubview:self.cover];
    
    CGFloat height = ceil(([LYMakeEmoticonImageCell item] * [LYMakeEmoticonImageCell line])) + 10;

    self.emojiCollectionView = [LYCustomEmojiCollectionView showCustomEmojiCollectionInView:self.contentView didSelectItemAtIndexPathBlock:^(NSIndexPath *indexPath, LYEmoticonModel *model) {
        
        if (self.didSelectBlock) {
            self.didSelectBlock(indexPath, model);
        }
        
    } collectionViewDidScroll:^(NSInteger currentPage) {
        NSLog(@"currentPage = %ld", currentPage);
        
        self.emojiPageControl.currentPage = currentPage;
    }];
    self.emojiCollectionView.frame = CGRectMake(0, 10, SCREEN_WIDTH, height);


    self.emojiCollectionView.top = 0;
    
    self.emojiPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.emojiCollectionView.frame), SCREEN_WIDTH, 20)];
    [self.emojiPageControl setCurrentPageIndicatorTintColor:LYThemeColor];
    [self.emojiPageControl setPageIndicatorTintColor:LYColor(@"#cccccc")];
    self.emojiPageControl.currentPage = 0;
    self.emojiPageControl.userInteractionEnabled = NO;
    
    
    [self.contentView addSubview:self.emojiPageControl];
    [self addSubview:self.contentView];

    
}


- (void)setDataSourece:(NSMutableArray *)dataSourece{
    _dataSourece = dataSourece;
    self.emojiCollectionView.dataArray = dataSourece;
    self.emojiPageControl.numberOfPages = self.emojiCollectionView.dataSourceForPage;

}

#pragma mark - 显示选择指示器
- (void)showInViewWithAnimated:(BOOL)animated{

    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat topMargin    = 10;
    CGFloat pageControlH = 20;
    CGFloat height = ceil(([LYMakeEmoticonImageCell item] * [LYMakeEmoticonImageCell line])) + pageControlH + topMargin;

    CGFloat backViewH = height + topMargin + pageControlH;
    CGFloat Y         = SCREEN_HEIGHT - backViewH - kTabbarExtra;
    
    if (animated)
    {
        // 动画显示
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        }];
        self.cover.alpha = 0.5;
        
    }else
    {
        // 无动画显示
        self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        
        self.cover.alpha = 0.5;
        
    }
}
#pragma mark - 退出
- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.cover removeFromSuperview];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 关闭操作
- (void)closeAction{
    [self close];
}

- (void)unlockClick:(UIButton *)sender{
    
    
    
    [self close];
}


#pragma mark - 懒加载
- (UIView *)cover{
    return LY_LAZY(_cover, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYBlackColorHex);
        view.alpha = 0;
        view;
    }));
}
- (UIView *)contentView{
    return LY_LAZY(_contentView, ({
        
        CGFloat topMargin    = 10;
        CGFloat pageControlH = 20;
        CGFloat height = ceil(([LYMakeEmoticonImageCell item] * [LYMakeEmoticonImageCell line])) + pageControlH + topMargin;

        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, height);
        view;
    }));
}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.contentView) {
            
        }else{
            [self close];
        }
    }
}

@end
