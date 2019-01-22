//
//  LYTWatermarkBottomToolBar.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYTWatermarkBottomToolBar.h"


@interface LYTWatermarkBottomToolBar ()

@property (nonatomic, strong) LYWatermarkColorsListView *colorListView;
@property (nonatomic, strong) LYWatermarkStyleListView *styleListView;
@property (nonatomic, strong) LYWatermarkBottomBtnsView *btnsView;
@property (nonatomic, strong) LYWatermarkFontListView *fontListView;


@end

@implementation LYTWatermarkBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYWatermarkStyleColor;

        [self _setupSubViews];
        
    }
    return self;
}

- (void)_setupSubViews
{
    [self.colorListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@(kLYWatermarkColorsListViewH));
    }];
    
    [self.styleListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@(kLYWatermarkColorsListViewH));
    }];
    
    [self.fontListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@(kLYWatermarkColorsListViewH));
    }];
    
    [self.btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.colorListView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@(kLYWatermarkBottomBtnsViewH));
    }];
    
    NSArray *hexArray = [NSArray arrayWithContentsOfFile:LYBUNDLE_PLISTPATH(@"LYWatermarkColorList")];

    NSMutableArray *array = [NSMutableArray array];
    for (NSString *colorHex in hexArray) {
        LYWatermarkColorHexModel *model = [[LYWatermarkColorHexModel alloc] init];
        model.colorHex = colorHex;
        if ([colorHex isEqualToString:LYWhiteColorHex]) {
            model.hasSelect = YES;
        }
        [array addObject:model];
    }
    self.colorListView.colorArray = array;
    
}


#pragma mark - 选取的文字颜色
- (void)didSelectTextColorHex:(NSString *)colorHex
{
    if (self.didSelectItemblock) {
        self.didSelectItemblock(colorHex);
    }
}
#pragma mark - 选取的文字颜色
- (void)didSelectBackColor:(BOOL)hasSelect
{
    if (self.didSelectBackblock) {
        self.didSelectBackblock(hasSelect);
    }
}

#pragma mark - 底部颜色按钮点击
- (void)bottomBtnClick:(NSInteger)index
{
    if (index == 0) {
        //颜色
        self.colorListView.hidden = NO;
        self.styleListView.hidden = YES;
        self.fontListView.hidden  = YES;

    }else if (index == 1){
        //样式
        self.colorListView.hidden = YES;
        self.styleListView.hidden = NO;
        self.fontListView.hidden  = YES;
    }else if (index == 2){
        //字体
        self.colorListView.hidden = YES;
        self.styleListView.hidden = YES;
        self.fontListView.hidden  = NO;
    }
}

#pragma mark - 底部样式按钮点击
- (void)bottomStyleBtnClick:(UIButton *)sender
{
    if (self.styleBlock) {
        self.styleBlock(sender);
    }
}

#pragma mark - 底部字体按钮点击
- (void)bottomFontStyleBtnClick:(UIButton *)sender
{
    if (self.fontBlock) {
        self.fontBlock(sender);
    }
}



#pragma mark - lazy loading
- (LYWatermarkColorsListView *)colorListView{
    return LY_LAZY(_colorListView, ({
        WEAKSELF(weakSelf);
        LYWatermarkColorsListView *listView = [[LYWatermarkColorsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        listView.showSelectButton = YES;
        listView.didSelectItemblock = ^(NSString *colorHex) {
            [weakSelf didSelectTextColorHex:colorHex];
        };
        listView.didBackblock = ^(BOOL hasSelect) {
            [weakSelf didSelectBackColor:hasSelect];
        };
        [self addSubview:listView];
        listView;
    }));
}
- (LYWatermarkStyleListView *)styleListView{
    return LY_LAZY(_styleListView, ({
        WEAKSELF(weakSelf);
        LYWatermarkStyleListView *listView = [[LYWatermarkStyleListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        listView.block = ^(UIButton *sender) {
            [weakSelf bottomStyleBtnClick:sender];
        };
        [self addSubview:listView];
        listView.hidden = YES;
        listView;
    }));
}
- (LYWatermarkFontListView *)fontListView{
    return LY_LAZY(_fontListView, ({
        WEAKSELF(weakSelf);
        LYWatermarkFontListView *listView = [[LYWatermarkFontListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        listView.block = ^(UIButton *sender) {
            [weakSelf bottomFontStyleBtnClick:sender];
        };
        [self addSubview:listView];
        listView.hidden = YES;
        listView;
    }));
}
- (LYWatermarkBottomBtnsView *)btnsView{
    return LY_LAZY(_btnsView, ({
        WEAKSELF(weakSelf);
        LYWatermarkBottomBtnsView *btnsView = [[LYWatermarkBottomBtnsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        btnsView.block = ^(NSInteger index) {
            [weakSelf bottomBtnClick:index];
        };
        [self addSubview:btnsView];
        btnsView;
    }));
}

@end
