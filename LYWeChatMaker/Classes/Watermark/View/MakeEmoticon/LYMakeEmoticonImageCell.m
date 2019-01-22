//
//  LYMakeEmoticonImageCell.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonImageCell.h"
#import "LYEmoticonModel.h"


@implementation LYMakeEmoticonImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = LYColor(LYWhiteColorHex);
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake([LYMakeEmoticonImageCell item] - 16, [LYMakeEmoticonImageCell item] - 16));
        }];
    }
    return self;
}

- (void)setModel:(LYEmoticonModel *)model{
    _model = model;
    self.imageView.image = [UIImage imageWithContentsOfFile:model.emoticonUrl];
}

+ (CGFloat)item
{
    return (SCREEN_WIDTH / [LYMakeEmoticonImageCell row]);
}

+ (NSInteger)row
{
    return 4;
}

+ (NSInteger)line
{
    return 2;
}
@end
