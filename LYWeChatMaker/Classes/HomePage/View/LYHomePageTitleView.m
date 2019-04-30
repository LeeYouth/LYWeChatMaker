//
//  LYHomePageTitleView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/8.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYHomePageTitleView.h"


@interface LYHomePageTitleView()

@property (nonatomic, strong) UILabel *titleLabel;//标题

@end

@implementation LYHomePageTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = LYHomePageColor;
        [self _setupSubViews];
        
    }
    return self;
}
- (void)_setupSubViews
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(@([LYHomePageTitleView getViewHeight]));
    }];
    
    self.titleLabel.text = @"开始";
}

+ (CGFloat)getViewHeight{
    return 50;
}


- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(@"#3B495C");
        view.font = [UIFont boldSystemFontOfSize:32.f];
        view;
    }));
}
@end
