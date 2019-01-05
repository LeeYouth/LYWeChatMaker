//
//  LYAboutUsInfoView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYAboutUsInfoView.h"

#define LYAboutUsInfoViewEmail @"281532697@qq.com"

@interface LYAboutUsInfoView ()

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *contectUsLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *emialBtn;

@end

@implementation LYAboutUsInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat iconW = 80;
        CGFloat infoLeft = 30;

        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(iconW, iconW));
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(infoLeft);
            make.right.equalTo(self.mas_right).offset(-infoLeft);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(5);
            make.height.mas_equalTo(@20);
        }];
        
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(infoLeft);
            make.right.equalTo(self.mas_right).offset(-infoLeft);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        }];
        
        [self.contectUsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(infoLeft);
            make.right.equalTo(self.mas_right).offset(-infoLeft);
            make.top.equalTo(self.infoLabel.mas_bottom).offset(20);
        }];
        
        [self.emialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contectUsLabel);
        }];
        
        NSString *contentStr = @"《简单水印》是一款快速添加文字水印的APP。多种颜色字体供您使用，多种功能供您选择。感谢您的支持与使用！";
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 4;
        [attString addAttributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, contentStr.length)];
        self.infoLabel.attributedText = attString;
        
        NSString *email = LYAboutUsInfoViewEmail;
        NSString *contectUsStr = [NSString stringWithFormat:@"若您在使用中遇到任何问题联系我们:%@",email];

        NSMutableAttributedString *attString11 = [[NSMutableAttributedString alloc] initWithString:contectUsStr];
        [attString11 addAttributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, contectUsStr.length - email.length)];
        [attString11 addAttributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.f],NSForegroundColorAttributeName:LYColor(@"#0000FF")} range:NSMakeRange(contectUsStr.length - email.length, email.length)];

        self.contectUsLabel.attributedText = attString11;
        
        self.titleLabel.text = @"简单水印";
        
        
        
    }
    return self;
}

- (void)emialButtonClick
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = LYAboutUsInfoViewEmail;
    [LYToastTool bottomShowWithText:@"复制成功" delay:1];
}

#pragma mark - lazy
- (UILabel *)infoLabel{
    return LY_LAZY(_infoLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = LYSystemFont(14.f);
        view.numberOfLines = 0;
        view.textColor = LYColor(@"444444");
        [self addSubview:view];
        view;
    }));
}
- (UILabel *)contectUsLabel{
    return LY_LAZY(_contectUsLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = LYSystemFont(14.f);
        view.numberOfLines = 0;
        view.textColor = LYColor(@"444444");
        view.userInteractionEnabled = YES;
        [self addSubview:view];
        view;
    }));
}
- (UIImageView *)iconImageView{
    return LY_LAZY(_iconImageView, ({
        UIImageView *view = [[UIImageView alloc] init];
        view.image = [UIImage imageWithContentsOfFile:LYBUNDLE_IMAGEPATH(@"easyMarkAppIcon")];
        view.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:view];
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [[UILabel alloc] init];
        view.font = LYSystemFont(14.f);
        view.numberOfLines = 0;
        view.textColor = LYColor(LYBlackColorHex);
        view.textAlignment = NSTextAlignmentCenter;
        [self addSubview:view];
        view;
    }));
}
- (UIButton *)emialBtn{
    return LY_LAZY(_emialBtn, ({
        UIButton *view = [[UIButton alloc] init];
        [view addTarget:self action:@selector(emialButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contectUsLabel addSubview:view];
        view;
    }));
}

@end
