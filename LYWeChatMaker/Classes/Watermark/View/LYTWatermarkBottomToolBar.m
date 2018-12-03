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
@property (nonatomic, strong) LYWatermarkBottomBtnsView *btnsView;

@end

@implementation LYTWatermarkBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _setupSubViews];
        
    }
    return self;
}

- (void)_setupSubViews
{
    [self.colorListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@60);
    }];
    
    [self.btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.colorListView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@40);
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

#pragma mark - 底部按钮点击
- (void)bottomBtnClick:(NSInteger)index
{
    if (self.bottomBtnblock) {
        self.bottomBtnblock(index);
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
