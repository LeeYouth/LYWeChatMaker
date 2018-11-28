//
//  LYAdvertisementAlertView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/28.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYAdvertisementAlertView.h"
#define LYAdAlertViewHeight    (SCREEN_HEIGHT - NAVBAR_HEIGHT - TABBAR_HEIGHT - 44 - 35)
#define LYAdAlertViewWidth     (SCREEN_WIDTH - 40)
#define LYAdAlertViewBaseTag   100

@interface LYAdvertisementAlertView()<UIScrollViewDelegate>
{
    UIPageControl   *pageControl;
    UIButton        *cancelBtn;
    NSString        *placeHolderImgStr;
}
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)NSInteger    itemsCount;
@property(nonatomic,strong)NSArray      *adDataList;
@property(nonatomic,assign)BOOL         hiddenPageControl;

@end

@implementation LYAdvertisementAlertView

+ (LYAdvertisementAlertView *)showInView:(UIView *)view
                               theADInfo: (NSArray *)dataList
{
    if (!dataList) {
        return nil;
    }
    LYAdvertisementAlertView *sqAlertView = [[LYAdvertisementAlertView alloc] initShowInView:view theADInfo:dataList];
    return sqAlertView;
}
- (instancetype)initShowInView:(UIView *)view
                     theADInfo:(NSArray *)dataList{
    self = [super init];
    if (self) {
        self.frame = view.bounds;
        
        self.backgroundColor    = [UIColor colorWithWhite:0.2 alpha:1.0];
        self.hiddenPageControl  = NO;
        self.adDataList         = dataList;
        
        [[[UIApplication sharedApplication].windows objectAtIndex:0] endEditing:YES];
        [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
        
        [self showAlertAnimation];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromCurrentView:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}
- (void)showAlertAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue         = [NSNumber numberWithFloat:0];
    animation.toValue           = [NSNumber numberWithFloat:1];
    animation.duration          = 0.25;
    animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.layer addAnimation:animation forKey:@"opacity"];
}

- (void)removeFromCurrentView:(UIGestureRecognizer *)gesture{
    UIView * subView    = (UIView *)[self viewWithTag:99];
    UIView * shadowView = self;
    if (CGRectContainsPoint(subView.frame, [gesture locationInView:shadowView]))
    {}else{
        [self removeSelfFromSuperview];
    }
}
- (void)removeSelfFromSuperview{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, SCREEN_WIDTH, LYAdAlertViewHeight)];
        _scrollView.backgroundColor         = [UIColor clearColor];
        _scrollView.userInteractionEnabled  = YES;
        _scrollView.contentSize     = CGSizeMake(self.frame.size.width*_itemsCount, LYAdAlertViewHeight);
        _scrollView.delegate        = self;
        _scrollView.pagingEnabled   = YES;
        _scrollView.bounces         = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}
- (void)setAdDataList:(NSArray *)adDataList{
    
    _adDataList = adDataList;
    _itemsCount = adDataList.count;
    
    [self creatItemView];
}
- (void)creatItemView{
    
    if (_itemsCount == 0) {
        return;
    }
    if (_itemsCount == 1) {
        self.hiddenPageControl = YES;
    }
    [self addSubview:self.scrollView];
    
    
    CGFloat ScrollWidth =  _scrollView.frame.size.width;
    
    for ( int i = 0; i < _itemsCount; i++ ) {
        LYAdModel *adModel = [_adDataList objectAtIndex:i];
        LYItemView*item = [[LYItemView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - LYAdAlertViewWidth/2+i*ScrollWidth,0, LYAdAlertViewWidth, LYAdAlertViewHeight)];
        item.userInteractionEnabled = YES;
        item.index  = i;
        item.tag    = LYAdAlertViewBaseTag + item.index;
        [item.imageView sd_setImageWithURL:[NSURL URLWithString:adModel.imageUrl] placeholderImage:[UIImage createImageWithColor:[UIColor whiteColor]]];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapContentImgView:)];
        [item addGestureRecognizer:singleTap];
        [_scrollView addSubview:item];
    }
    
    CGFloat btnW = 44;
    cancelBtn       = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake((SCREEN_WIDTH - btnW)/2, SCREEN_HEIGHT - TABBAR_HEIGHT - btnW, btnW, btnW);
    [cancelBtn setImage: [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"mtAdAlertView_close")] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(removeSelfFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    //初始化pageControl
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, cancelBtn.frame.origin.y - 20, SCREEN_WIDTH, 20)];
    pageControl.numberOfPages   = _itemsCount;
    pageControl.currentPage     = 0;
    [pageControl addTarget:self action:@selector(pageValueChange:) forControlEvents:UIControlEventValueChanged];
    pageControl.hidden          = self.hiddenPageControl;
    
    [self addSubview:pageControl];
}
- (void)tapContentImgView:(UITapGestureRecognizer *)gesture{
    UIView *imageView = gesture.view;
    NSInteger itemTag = (long)imageView.tag - LYAdAlertViewBaseTag;
    
    if (self.block) {
        self.block(itemTag);
    }
    [self removeSelfFromSuperview];
}

- (void)pageValueChange:(UIPageControl*)page{
    
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:.35 animations:^{
        weakSelf.scrollView.contentOffset = CGPointMake(page.currentPage*SCREEN_WIDTH, 0);
    }];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index         = scrollView.contentOffset.x/SCREEN_WIDTH;
    pageControl.currentPage = index;
}

@end



@implementation LYItemView
- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
        self.layer.masksToBounds    = YES;
        self.layer.cornerRadius     = 5;
        self.layer.shadowOpacity    = .2;
        self.layer.shadowOffset     = CGSizeMake(0, 2.5);
        self.layer.shadowColor      = [UIColor blackColor].CGColor;
        
        [self addSubview:self.imageView];
    }
    return self;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.backgroundColor        = [UIColor whiteColor];
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.masksToBounds    = YES;
    }
    return _imageView;
}
@end

@implementation LYAdModel

@end
