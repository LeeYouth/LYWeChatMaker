//
//  LYWatermarkColorsListView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/11/29.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkColorsListView.h"

#define LYWatermarkColorsListViewItemW 

@interface LYWatermarkColorsListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) UIButton *backColorBtn;

@end

@implementation LYWatermarkColorsListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        [self _setupSubViews];
    }
    return self;
}

- (void)_setupSubViews {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(30, LYWatermarkColorsListViewH);
    layout.minimumLineSpacing = 15;//间距
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);//分别为上、左、下、右
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:layout];
    _collectionview.backgroundColor = [UIColor whiteColor];
    _collectionview.pagingEnabled = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.dataSource = self;
    _collectionview.delegate = self;
    [self addSubview:_collectionview];
    
    _backColorBtn = [UIButton new];
    UIImage *normalImage = [UIImage imageWithColor:LYImageBackColor];
    UIImage *selectImage = [UIImage imageWithColor:LYThemeColor];
//    [_backColorBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [_backColorBtn setBackgroundImage:selectImage forState:UIControlStateSelected];
    [_backColorBtn setImage:[UIImage imageNamed:@"watermarkText_backSetNormal"] forState:UIControlStateNormal];
    [_backColorBtn setImage:[UIImage imageNamed:@"watermarkText_backSetSelect"] forState:UIControlStateSelected];
//    _backColorBtn.layer.borderColor = LYColor(LYWhiteColorHex).CGColor;
//    _backColorBtn.layer.borderWidth = 2;
    _backColorBtn.layer.cornerRadius = 4;
    _backColorBtn.layer.masksToBounds = YES;
    [_backColorBtn addTarget:self action:@selector(backColorButtomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backColorBtn];
    _backColorBtn.hidden = YES;

}

#pragma mark - 背景色按钮点击
- (void)backColorButtomClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.didBackblock) {
        self.didBackblock(sender.selected);
    }
    
}

- (void)setDefultColorHex:(NSString *)defultColorHex{
    _defultColorHex = defultColorHex;
    
    for (LYWatermarkColorHexModel *fModel in _colorArray) {
        if ([fModel.colorHex isEqualToString:defultColorHex]) {
            fModel.hasSelect = YES;
        }else{
            fModel.hasSelect = NO;
        }
    }
    [_collectionview reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat rectHeight = rect.size.height;
    CGFloat rectWidth = rect.size.width;

    
    CGFloat btnW = 40;
    _backColorBtn.frame   = CGRectMake(10, (rectHeight - btnW)/2, btnW, btnW);
    
    CGFloat collectionX = self.showSelectButton?_backColorBtn.right:0;
    CGFloat collectionW = rectWidth - (self.showSelectButton?_backColorBtn.right:0);
    _collectionview.frame = CGRectMake(collectionX, 0, collectionW, rectHeight);
}


- (void)setColorArray:(NSMutableArray *)colorArray{
    _colorArray = colorArray;
    
    [_collectionview reloadData];
}

- (void)setShowSelectButton:(BOOL)showSelectButton{
    _showSelectButton = showSelectButton;
    _backColorBtn.hidden = !showSelectButton;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYWatermarkColorsListViewItem *cell = [LYWatermarkColorsListViewItem cellWithCollectionView:collectionView forItemAtIndexPath:indexPath];
    if (_colorArray.count) {
        cell.hexModel = [_colorArray objectAtIndex:indexPath.item];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _colorArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LYWatermarkColorHexModel *model = [_colorArray objectAtIndex:indexPath.item];
    
    LYLog(@"----currentColor = %@",model.colorHex);

    for (LYWatermarkColorHexModel *fModel in _colorArray) {
        if ([fModel.colorHex isEqualToString:model.colorHex]) {
            fModel.hasSelect = YES;
        }else{
            fModel.hasSelect = NO;
        }
    }
    [_collectionview reloadData];

    if (self.didSelectItemblock) {
        self.didSelectItemblock(model.colorHex);
    }
    
}



@end



@interface LYWatermarkColorsListViewItem ()

@property (nonatomic,strong) UIView *colorView;
@property (nonatomic,strong) UIView *borderView;

@end

@implementation LYWatermarkColorsListViewItem

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView registerClass:[LYWatermarkColorsListViewItem class] forCellWithReuseIdentifier:@"LYWatermarkColorsListViewItem"];
    LYWatermarkColorsListViewItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYWatermarkColorsListViewItem" forIndexPath:indexPath];
    
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    
    CGFloat itemW = 30;
    self.colorView.layer.cornerRadius = itemW/2;
    self.borderView.layer.cornerRadius = itemW/2;

    [self addSubview:self.borderView];
    [self addSubview:self.colorView];
    
    [self.borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(itemW, itemW));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(itemW, itemW));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)setHexModel:(LYWatermarkColorHexModel *)hexModel{
    _hexModel = hexModel ;
    
    self.colorView.backgroundColor = LYColor(hexModel.colorHex);
    if ([hexModel.colorHex isEqualToString:@"#FFFFFF"]) {
        self.borderView.layer.borderColor = LYColor(@"#DCDCDC").CGColor;
    }else{
        self.borderView.layer.borderColor = LYColor(hexModel.colorHex).CGColor;
    }

    if (hexModel.hasSelect) {
        
        self.borderView.hidden = NO;
        
        CGFloat itemW = 16;
        self.colorView.layer.cornerRadius = itemW/2;
        [self.colorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW, itemW));
        }];
    }else{
        self.borderView.hidden = YES;

        CGFloat itemW = 30;
        self.colorView.layer.cornerRadius = itemW/2;
        [self.colorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(itemW, itemW));
        }];
    }
}


#pragma mark - lazy loading
- (UIView *)colorView{
    return LY_LAZY(_colorView, ({
        UIView *imageV = [UIView new];
        imageV.layer.borderColor = LYColor(@"#DCDCDC").CGColor;
        imageV.layer.borderWidth = 0.5;
        [self addSubview:imageV];
        imageV;
    }));
}
- (UIView *)borderView{
    return LY_LAZY(_borderView, ({
        UIView *imageV = [UIView new];
        imageV.backgroundColor =LYColor(@"#FFFFFF");
        imageV.layer.borderWidth = 3;
        [self addSubview:imageV];
        imageV;
    }));
}

@end


@implementation LYWatermarkColorHexModel

@end
