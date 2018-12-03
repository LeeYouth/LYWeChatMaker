//
//  LYWatermarkEditTextView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/1.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYWatermarkEditTextView.h"
#import "IQKeyboardManager.h"
#import "LYDrawRectangleView.h"
#import "LYWatermarkInputView.h"
#import "MSWeakTimer.h"

#define LYWatermarkEditTextViewH 60
#define LYWatermarkEditTextViewTextFiledH 40
#define LYWatermarkEditTextInputW (SCREEN_WIDTH - 80)
#define LYWatermarkEditTextInputH ((SCREEN_WIDTH - 80)/3)

@interface LYWatermarkEditTextView ()<UITextFieldDelegate>

/** 文字显示框 */
@property (nonatomic, strong) LYWatermarkInputView *inputView;
/** 顶部线 */
@property (nonatomic, strong) UIView *topLineView;
/** 透明背景 */
@property (nonatomic, strong) UIView *coverView;
/** 文字视图背景图 */
@property (nonatomic, strong) UIView *textBgView;
/** 文字视图 */
@property (nonatomic, strong) UITextField *textView;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *confirmBtn;
/** 颜色裂变视图 */
@property (nonatomic, strong) UIView *topLine;

@end

@implementation LYWatermarkEditTextView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect framef = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self = [super initWithFrame:framef];
    if (self) {
        self.frame = framef;
        
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        //必须给effcetView的frame赋值,因为UIVisualEffectView是一个加到UIIamgeView上的子视图.
        effectView.frame = self.bounds;
        [self addSubview:effectView];
        
        [self _setupSubView];
        
    }
    return self;
}

- (void)_setupSubView{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    [IQKeyboardManager sharedManager].enable = NO;
    
    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.coverView = [[UIView alloc] init];
    self.coverView.backgroundColor = [UIColor grayColor];
    self.coverView.alpha = 0;
    
    
    CGFloat leftMargin = 12;
    CGFloat topMargin  = 10;
 
    CGFloat textViewX = leftMargin;
    CGFloat textViewY = topMargin;
    CGFloat textViewH = LYWatermarkEditTextViewTextFiledH;
    CGFloat buttonW   = textViewH;
    CGFloat textViewW = SCREEN_WIDTH - 3*leftMargin - buttonW;
    
    CGFloat buttonH   = buttonW;
    CGFloat buttonX   = SCREEN_WIDTH - buttonW - leftMargin;
    CGFloat buttonY   = textViewY;
    
    CGFloat backWidth = SCREEN_WIDTH;
    CGFloat backY     = SCREEN_HEIGHT - LYWatermarkEditTextViewH;
    CGFloat backH     = LYWatermarkEditTextViewH;
    
    
    CGFloat putLeft = 40;
    self.inputView = [[LYWatermarkInputView alloc] initWithFrame:CGRectMake(putLeft, 0, LYWatermarkEditTextInputW, LYWatermarkEditTextInputH)];
    [self addSubview:self.inputView];
    [self.inputView startRectangleViewAnimation];
    
    self.textBgView = [[UIView alloc] initWithFrame:CGRectMake(0, backY, backWidth, backH)];
    self.textBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textBgView];
    
    CGFloat lineH = 0.6;
    UIColor *cellColor = LYColor(@"#eeeeee");
    self.topLineView = [[UIView alloc] initWithFrame: CGRectMake(0, 0 , SCREEN_WIDTH, lineH)];
    self.topLineView.backgroundColor = cellColor;
    [self.textBgView addSubview:self.topLineView];
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LYCellLineHeight)];
    lineView.backgroundColor = LYCellLineColor;
    [self.textBgView addSubview:lineView];

    self.textView = [[UITextField alloc] initWithFrame:CGRectMake(textViewX, textViewY , textViewW, textViewH)];
    self.textView.layer.cornerRadius = 2;
    self.textView.layer.borderColor = cellColor.CGColor;
    self.textView.layer.borderWidth = 0.6;
    self.textView.textColor = LYColor(@"#333333");
    self.textView.font = LYSystemFont(16);
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDone;
    self.textView.inputAccessoryView = [[UIView alloc] initWithFrame:CGRectZero];
    self.textView.backgroundColor  =  LYColor(@"#F9F9F9");
    self.textView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入文字" attributes:@{NSForegroundColorAttributeName:LYColor(@"#808080")}] ;
    self.textView.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textBgView addSubview:self.textView];
    [self.textView addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];


    UILabel * leftView = [[UILabel alloc] initWithFrame:CGRectMake(10,0,10,26)];
    leftView.backgroundColor = [UIColor clearColor];
    self.textView.leftView = leftView;
    self.textView.leftViewMode = UITextFieldViewModeAlways;
    self.textView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.textView.tintColor = LYThemeColor;

    
    self.confirmBtn = [[UIButton alloc] init];
    self.confirmBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    UIImage *normalImage = [UIImage imageWithColor:LYThemeColor];
    [self.confirmBtn setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.confirmBtn setImage:[UIImage imageNamed:@"watermarkEditText_ensure"] forState:UIControlStateNormal];
    self.confirmBtn.layer.cornerRadius = 2;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.confirmBtn addTarget:self action:@selector(confirmBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.textBgView addSubview:self.confirmBtn];

    //键盘变化通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [self.textView becomeFirstResponder];
    
}


- (void)setDefultText:(NSString *)defultText{
    _defultText = defultText;
    
    self.inputView.inputText = defultText;
    if (![defultText isEqualToString:LYWatermarkInputViewDefultText]) {
        self.textView.text = defultText;
    }
}

- (void)changeInputColor:(NSString *)colorhex
{
    self.inputView.colorHex = colorhex;
    if (self.colorBlock) {
        self.colorBlock(colorhex);
    }
}

#pragma mark - 键盘变化通知
- (void)keyboardChangeFrame:(NSNotification *)notifi{
    CGRect keyboardFrame = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    float duration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    WEAKSELF(weakSelf);
    [UIView animateWithDuration:duration animations:^{
        weakSelf.textBgView.transform = CGAffineTransformMakeTranslation(0, keyboardFrame.origin.y - SCREEN_HEIGHT);
        weakSelf.inputView.frame = CGRectMake(40, ( keyboardFrame.origin.y - LYWatermarkEditTextInputH)/2, LYWatermarkEditTextInputW, LYWatermarkEditTextInputH);
    }];
}
#pragma mark - YYTextViewDelegate内容变化
- (void)textFieldTextChange:(UITextField *)textField{
    if (textField.text.length) {
        self.inputView.inputText = textField.text;
    }else{
        self.inputView.inputText = LYWatermarkInputViewDefultText;
    }
}

#pragma mark - 发表按钮点击
- (void)confirmBtnAction{
    if (self.block) {
        self.block(self.textView.text);
    }
    [self dismiss];
}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.textBgView) {
            
        }else{
//            [self dismiss];
        }
    }
}

#pragma mark - 退出
- (void)dismiss{
    [self.textView resignFirstResponder];
    [self.coverView removeFromSuperview];
    [self removeFromSuperview];
}


- (void)dealloc{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enable = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

