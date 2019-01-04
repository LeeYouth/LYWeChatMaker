//
//  LYPrivacyAgreementInfoView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/5.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYPrivacyAgreementInfoView.h"

@interface LYPrivacyAgreementInfoView ()

@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation LYPrivacyAgreementInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat infoLeft = 15;
        
        [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(infoLeft);
            make.right.equalTo(self.mas_right).offset(-infoLeft);
            make.top.equalTo(self.mas_top).offset(20);
        }];
        
        NSString *contentStr = @"项目中使用到的开源组件：IQKeyboardManager，AFNetworking，SDWebImage，MBProgressHUD，FMDB，Masonry，TZImagePickerController，MSWeakTimer，YYKit。感谢以上开源组件，该项目才得以顺利实现！";
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing = 4;
        [attString addAttributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:14.f]} range:NSMakeRange(0, contentStr.length)];
        self.infoLabel.attributedText = attString;
        
    }
    return self;
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

@end
