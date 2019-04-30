//
//  LYMakeEmoticonBodyesCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/17.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonBodyesCell.h"
#import "LYMakeEmoticonSelectPictureView.h"
#import "LYMakeEmoticonSelectFaceView.h"
#import "LYMakeEmoticonSelectSentenceView.h"
#import "LYEmoticonModel.h"
#import "LYWatermarkEditTextView.h"
#import "LYWatermarkInputConfig.h"

#define LYMakeEmoticonBodyesCellLeftMargin 50

@interface LYMakeEmoticonBodyesCell()

@property (nonatomic, strong) UIView *imageBackView;
//形象
@property (nonatomic, strong) UIImageView *emoticonImageView;
//表情
@property (nonatomic, strong) UIImageView *faceImageView;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
/** 标题背景 */
@property (nonatomic, strong) UIView *rectangleView;
@property (nonatomic, strong) LYStickerView *zoomView;

//功能按钮(形象、表情、配文)
@property (nonatomic, strong) UIButton *addImageButton;
@property (nonatomic, strong) UIButton *addFaceButton;
@property (nonatomic, strong) UIButton *selectSentenceButton;

//确定、返回按钮
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *saveButton;

//数据源
@property (nonatomic, strong) NSMutableArray *emoticonDataSource;
@property (nonatomic, strong) NSMutableArray *XMRDataSource;
@property (nonatomic, strong) NSMutableArray *MGTDataSource;

@property (nonatomic, strong) NSMutableArray *faceDataSource;
@property (nonatomic, strong) NSMutableArray *sentenceDataSource;

@property (nonatomic, assign) BOOL showFunctionCtrls;
@property (nonatomic, strong) LYEmoticonModel *currentEmojiModel;
@property (nonatomic, strong) LYEmoticonModel *currentFaceModel;

@end

@implementation LYMakeEmoticonBodyesCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYMakeEmoticonBodyesCell";
    
    LYMakeEmoticonBodyesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYMakeEmoticonBodyesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = LYColor(@"#F2F1F2");
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    [self addSubview:self.imageBackView];
    [self.imageBackView addSubview:self.emoticonImageView];
    [self.imageBackView addSubview:self.rectangleView];
    [self.imageBackView addSubview:self.titleLabel];
    
    
    LYStickerView *stickerView = [[LYStickerView alloc] initWithContentView:self.faceImageView];
    stickerView.ctrlType = LYStickerViewCtrlTypeOne;
    stickerView.scaleMode = LYStickerViewScaleModeBounds;
    [stickerView showRemoveCtrl:NO];
    [stickerView setTransformCtrlImage:[UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"waterMark_scale")]];
    [self.imageBackView addSubview:stickerView];
    self.zoomView = stickerView;

    [self addSubview:self.addImageButton];
    [self addSubview:self.addFaceButton];
    [self addSubview:self.selectSentenceButton];
    [self addSubview:self.backButton];
    [self addSubview:self.saveButton];
    
    [self showTitleViewBorder:NO];
    
    CGFloat imageW = SCREEN_WIDTH - 2*LYMakeEmoticonBodyesCellLeftMargin;
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imageW, imageW));
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(@30);
    }];
    
    CGFloat labelH = 40;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(labelH));
        make.bottom.equalTo(self.imageBackView.mas_bottom).offset(-14);
        make.left.equalTo(self.imageBackView.mas_left).offset(14);
        make.right.equalTo(self.imageBackView.mas_right).offset(-14);
    }];
    
    [self.rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.top.equalTo(self.titleLabel.mas_top).offset(-8);
        make.left.equalTo(self.titleLabel.mas_left).offset(-8);
        make.right.equalTo(self.titleLabel.mas_right).offset(8);
    }];
    
    [self.emoticonImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.rectangleView.mas_top);
        make.top.equalTo(self.imageBackView.mas_top).offset(12);
        make.left.equalTo(self.imageBackView.mas_left).offset(12);
        make.right.equalTo(self.imageBackView.mas_right).offset(-12);
    }];

    
    
    CGFloat buttonW = 80;
    
    [self.addFaceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonW));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imageBackView.mas_bottom).offset(30);
    }];
    
    [self.addImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonW));
        make.right.equalTo(self.addFaceButton.mas_left).offset(-10);
        make.top.equalTo(self.addFaceButton.mas_top);
    }];

    [self.selectSentenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(buttonW, buttonW));
        make.left.equalTo(self.addFaceButton.mas_right).offset(10);
        make.top.equalTo(self.addFaceButton.mas_top);
    }];
    
    CGFloat saveW = 100;
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(saveW, saveW));
        make.left.equalTo(self.imageBackView.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(saveW, saveW));
        make.right.equalTo(self.imageBackView.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-40);
    }];
    
    // 推荐使用
    [self.addImageButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:8 imagePositionBlock:^(UIButton *button) {
        button.titleLabel.font = LYSystemFont(13.f);
        [button setTitleColor:LYColor(@"#172F52") forState:UIControlStateNormal];
        [button setTitle:@"形象" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"makeEmoticonBodyes_addEmoticonIcon"] forState:UIControlStateNormal];
    }];
    
    [self.addFaceButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:8 imagePositionBlock:^(UIButton *button) {
        button.titleLabel.font = LYSystemFont(13.f);
        [button setTitleColor:LYColor(@"#172F52") forState:UIControlStateNormal];
        [button setTitle:@"表情" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"makeEmoticonBodyes_addFaceIcon"] forState:UIControlStateNormal];
    }];
    
    [self.selectSentenceButton SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:8 imagePositionBlock:^(UIButton *button) {
        button.titleLabel.font = LYSystemFont(13.f);
        [button setTitleColor:LYColor(@"#172F52") forState:UIControlStateNormal];
        [button setTitle:@"配文" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"makeEmoticonBodyes_addSentenceIcon"] forState:UIControlStateNormal];
    }];
    
    //默认展示功能按钮
    [self showeEmoticonCtls:YES];
    [self showeFaceCtls:YES];
    [self showeSentenceCtls:YES];
    
    self.faceImageView.image = [UIImage imageWithContentsOfFile:LYLOADBUDLEIMAGE(@"LYMakeEmoticonFaceImageResources.bundle",@"10041")];


}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.emoticonImageView || touch.view == self.imageBackView || touch.view == self.contentView) {
            //点击了背景
            [self.zoomView showContentViewBorder:NO];
            [self.zoomView showScaleCtrl:NO];
            [self showTitleViewBorder:NO];

        }else if(touch.view == self.zoomView){
            //点击了图片
            [self.zoomView showContentViewBorder:self.showFunctionCtrls];
            [self.zoomView showScaleCtrl:self.showFunctionCtrls];
            [self showTitleViewBorder:YES];

        }else if(touch.view == self.titleLabel){
            //点击了文字
            [self.zoomView showContentViewBorder:self.showFunctionCtrls];
            [self.zoomView showScaleCtrl:self.showFunctionCtrls];
            [self showTitleViewBorder:YES];
        }
    }
}

#pragma mark - 选中的文字
- (void)selectPopularSentence:(NSString *)title{
    self.titleLabel.text = title;
}


#pragma mark - 按钮点击
- (void)buttonClickAction:(UIButton *)sender{
    WEAKSELF(weakSelf);
    if (sender.tag == 0) {
        //形象
        LYMakeEmoticonSelectPictureView *picAlertView = [LYMakeEmoticonSelectPictureView sharedInstance];
        picAlertView.didSelectBlock = ^(NSIndexPath * _Nonnull indexPath, LYEmoticonModel * _Nonnull model) {
            
            weakSelf.currentEmojiModel = model;
            
            weakSelf.emoticonImageView.image = model.emoticonImage;
        };
        
        if (self.emoticonCtlTitle.length) {
            if ([self.emoticonCtlTitle isEqualToString:@"熊猫人"]) {
                picAlertView.dataSourece = self.XMRDataSource;
            }else if ([self.emoticonCtlTitle isEqualToString:@"蘑菇头"]){
                picAlertView.dataSourece = self.MGTDataSource;
            }else{
                picAlertView.dataSourece = self.emoticonDataSource;
            }
        }else{
            picAlertView.dataSourece = self.emoticonDataSource;
        }
        [picAlertView showInViewWithAnimated:YES];
    }else if (sender.tag == 1){
        //表情
        LYMakeEmoticonSelectFaceView *picAlertView = [LYMakeEmoticonSelectFaceView sharedInstance];
        picAlertView.didSelectBlock = ^(NSIndexPath * _Nonnull indexPath, LYEmoticonModel * _Nonnull model) {
            weakSelf.currentFaceModel = model;
            
            [weakSelf.zoomView showContentViewBorder:weakSelf.showFunctionCtrls];
            [weakSelf.zoomView showScaleCtrl:weakSelf.showFunctionCtrls];
            weakSelf.faceImageView.image = model.emoticonImage;
        };
        picAlertView.dataSourece = self.faceDataSource;
        [picAlertView showInViewWithAnimated:YES];
    }else if (sender.tag == 2){
        //文字
        LYMakeEmoticonSelectSentenceView *picAlertView = [LYMakeEmoticonSelectSentenceView sharedInstance];
        picAlertView.block = ^(NSString *title) {
            [weakSelf selectPopularSentence:title];
        };
        picAlertView.dataSourece = self.sentenceDataSource;
        [picAlertView showInViewWithAnimated:YES];
    }else if (sender.tag == 4){
        //保存
        [self saveWatermarkImage];
    }
    
    if (self.block) {
        self.block(sender);
    }
}

- (void)inputLabelTap{
    WEAKSELF(weakSelf);
    
    LYWatermarkInputConfig *inputConfig = [[LYWatermarkInputConfig alloc] init];
    inputConfig.selectShadow = NO;
    inputConfig.selectStroke = NO;
    inputConfig.selectBold   = YES;
    inputConfig.selectBack   = NO;
    inputConfig.fontName     = @"defult";
    inputConfig.inputText    = self.titleLabel.text;
    inputConfig.colorHex     = LYBlackColorHex;

    LYWatermarkEditTextView *textEditView = [[LYWatermarkEditTextView alloc] init];
    textEditView.inputConfig = inputConfig;
    textEditView.block = ^(LYWatermarkInputConfig *config) {
        weakSelf.titleLabel.text = config.inputText;
    };
}

- (void)saveWatermarkImage{
    [self.zoomView showContentViewBorder:NO];
    [self.zoomView showScaleCtrl:NO];
    [self showTitleViewBorder:NO];
    
    UIGraphicsBeginImageContextWithOptions(self.imageBackView.size, NO, 0.0);
    //获取图像
    [self.imageBackView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 保存图片
    [self saveImageToPhotos:image];
}

- (void)saveImageToPhotos:(UIImage*)savedImage{
    
    [LYToastTool showLoadingWithStatus:@""];
    
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    [LYToastTool dismiss];
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
        
    }else{
        msg = @"保存图片成功" ;
        
        //保存到本地（历史记录）
        LYEmoticonHistoryModel *model = [[LYEmoticonHistoryModel alloc] init];
        model.bg_tableName   = kLYEMOJIHISTORYTABLENAME;
        model.historyDate    = [NSDate date];
        model.historyText    = self.titleLabel.text;
        model.compositeImage = image;
        model.bundleName     = self.currentEmojiModel.bundleName.length?self.currentEmojiModel.bundleName:self.defultEmojiModel.bundleName;
        model.bundleImageName = self.currentEmojiModel.bundleImageName.length?self.currentEmojiModel.bundleImageName:self.defultEmojiModel.bundleImageName;
        
        if (!self.addFaceButton.hidden) {
            model.fromType       = 2;
            model.faceBundleName = self.currentFaceModel.bundleName.length?self.currentFaceModel.bundleName:@"LYMakeEmoticonFaceImageResources.bundle";
            model.faceBundleImageName = self.currentFaceModel.bundleImageName.length?self.currentFaceModel.bundleImageName:@"10041";
        }else{
            model.fromType        = 1;
 
        }
        [model bg_save];
        
       
        if (self.success) {
            self.success(image);
        }
    }
}

#pragma mark - 显示输入框边框
- (void)showTitleViewBorder:(BOOL)show{
    self.rectangleView.hidden = !show;
}

- (void)showeEmoticonCtls:(BOOL)show{
    self.addImageButton.hidden = !show;
}
- (void)showeFaceCtls:(BOOL)show{
    self.showFunctionCtrls    = show;
    self.addFaceButton.hidden = !show;
    self.zoomView.hidden      = !show;
}
- (void)showeSentenceCtls:(BOOL)show{
    self.selectSentenceButton.hidden = !show;
}


- (void)setDefultEmojiModel:(LYEmoticonModel *)defultEmojiModel{
    _defultEmojiModel = defultEmojiModel;

    self.emoticonImageView.image = defultEmojiModel.emoticonImage;

}

- (void)setEmoticonCtlTitle:(NSString *)emoticonCtlTitle{
    _emoticonCtlTitle = emoticonCtlTitle;
    if (emoticonCtlTitle.length) {
        [self.addImageButton setTitle:emoticonCtlTitle forState:UIControlStateNormal];
    }
}

#pragma mark - lazy loading
- (UIView *)imageBackView{
    return LY_LAZY(_imageBackView, ({
        UIView *view = [UIView new];
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view.userInteractionEnabled = YES;
//        view.layer.cornerRadius = 12;
//        view.layer.masksToBounds = YES;
        view;
    }));
}
- (UIImageView *)emoticonImageView{
    return LY_LAZY(_emoticonImageView, ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.userInteractionEnabled = YES;
        view;
    }));
}
- (UIImageView *)faceImageView{
    return LY_LAZY(_faceImageView, ({
        CGFloat backW  = SCREEN_WIDTH - 2*LYMakeEmoticonBodyesCellLeftMargin;
        CGFloat imageW = 80;
        UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake((backW - imageW)/2, 45, imageW, imageW)];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}


- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.userInteractionEnabled = YES;
        view.numberOfLines = 0;
        view.font = [UIFont boldSystemFontOfSize:30.f];
        view.textColor = LYColor(LYBlackColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        view.text = LYWatermarkInputViewDefultText;
        view.adjustsFontSizeToFitWidth = YES;
        view.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        view.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputLabelTap)];
        [view addGestureRecognizer:tap];
        view;
    }));
}
- (UIView *)rectangleView{
    return LY_LAZY(_rectangleView, ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 100, 100)];
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderColor = LYThemeColor.CGColor;
        view.layer.borderWidth = 0.5;
        view;
    }));
}

- (UIButton *)addImageButton{
    return LY_LAZY(_addImageButton, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 0;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)addFaceButton{
    return LY_LAZY(_addFaceButton, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 1;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)selectSentenceButton{
    return LY_LAZY(_selectSentenceButton, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 2;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)backButton{
    return LY_LAZY(_backButton, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        [btn setTitleColor:LYColor(@"#172F52") forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"makeEmoticonBodyes_cancelButtonIcon"] forState:UIControlStateNormal];
        btn.tag = 3;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}
- (UIButton *)saveButton{
    return LY_LAZY(_saveButton, ({
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = LYSystemFont(15.f);
        [btn setTitleColor:LYColor(@"#172F52") forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"makeEmoticonBodyes_saveButtonIcon"] forState:UIControlStateNormal];
        btn.tag = 4;
        [btn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    }));
}


- (NSMutableArray *)emoticonDataSource{
    if (!_emoticonDataSource) {
        _emoticonDataSource = [NSMutableArray array];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kMAKEMOJIEMCTICONESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr  = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYMakeEmoticonEmojisImageResources.bundle";

            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            model.unLock           = [[NSUserDefaults standardUserDefaults] boolForKey:model.paddingSourceUrl];

            [imageArray addObject:model];
        }
        _emoticonDataSource = imageArray;
    }
    return _emoticonDataSource;
}
- (NSMutableArray *)faceDataSource{
    if (!_faceDataSource) {
        _faceDataSource = [NSMutableArray array];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kMAKEMOJIFACERESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr  = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYMakeEmoticonFaceImageResources.bundle";
            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            model.unLock           = [[NSUserDefaults standardUserDefaults] boolForKey:model.paddingSourceUrl];
            [imageArray addObject:model];
        }
        _faceDataSource = imageArray;
    }
    return _faceDataSource;
}
- (NSMutableArray *)sentenceDataSource{
    if (!_sentenceDataSource) {        
        NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: @"LYPopularSentenceResources.plist"];
        _sentenceDataSource = [[NSMutableArray alloc] initWithContentsOfFile:bundlePath];
    }
    return _sentenceDataSource;
}

- (NSMutableArray *)MGTDataSource{
    if (!_MGTDataSource) {
        _MGTDataSource = [NSMutableArray array];
        
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kMGTRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr  = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYMGTImageResources.bundle";

            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            model.unLock           = [[NSUserDefaults standardUserDefaults] boolForKey:model.paddingSourceUrl];
            [imageArray addObject:model];
        }
        _MGTDataSource = imageArray;
    }
    return _MGTDataSource;
}
- (NSMutableArray *)XMRDataSource{
    if (!_XMRDataSource) {
        _XMRDataSource = [NSMutableArray array];
        //熊猫人
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 10001; i <= [kXMRRESOURCELASTNAME intValue]; i++) {
            
            NSString *nameStr  = [NSString stringWithFormat:@"%d",i];
            NSString *fileName = @"LYXMRImageResources.bundle";
            
            LYEmoticonModel *model = [[LYEmoticonModel alloc] init];
            model.bundleName       = fileName;
            model.bundleImageName  = nameStr;
            model.unLock           = [[NSUserDefaults standardUserDefaults] boolForKey:model.paddingSourceUrl];
            [imageArray addObject:model];
        }
        _XMRDataSource = imageArray;
    }
    return _XMRDataSource;
}
@end

