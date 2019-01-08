//
//  LYNoviceManualViewController.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYNoviceManualViewController.h"

@interface LYNoviceManualViewController ()

@property (nonatomic, strong) YYTextView *textView;

@end

@implementation LYNoviceManualViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"新手手册";
    
    self.textView = [[YYTextView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT, 0, 0)];
    self.textView.font = LYSystemFont(15.f);
    self.textView.userInteractionEnabled = YES;
    self.textView.editable = NO;
    self.textView.textVerticalAlignment = YYTextVerticalAlignmentTop;
    self.textView.size = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - kTabbarExtra - NAVBAR_HEIGHT);
    [self.view addSubview:self.textView];

    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"1、如何修改、缩放表情文字？\n在制作表情页面，点击文字输入框，会弹出修改文字的键盘，就可以编辑修改里面的文字了！如果你想缩放、旋转文字，摁住绿色按钮就可以单指拖动、双指进行缩放、旋转操作。同时，用一个手指还可以移动文字位置。\n"];
    UIFont *font = LYSystemFont(15.f);
    NSMutableAttributedString *attachment = nil;
    
    // 嵌入 UIImage
    UIImage *image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"setting_howtouser_one")];
    attachment = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(self.textView.width - 20, 300) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment];
    
    [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"2、如何上传自己的照片或表情包制作表情包？\n在首页点击从相册选取或从表情包选取图片，选择图片后，使用上面的操作，您就可以添加相应的问题，你就可以开始极速斗图啦！\n"]];
    
    NSMutableAttributedString *attachment1 = nil;
    
    // 嵌入 UIImage
    UIImage *image1 = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"setting_howtouser_two")];
    attachment1 = [NSMutableAttributedString attachmentStringWithContent:image1 contentMode:UIViewContentModeScaleAspectFit attachmentSize:CGSizeMake(self.textView.width, 300) alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [text appendAttributedString: attachment1];

    self.textView.attributedText = text;


}


@end
