//
//  LYMakeEmoticonSelectSentenceView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/16.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYMakeEmoticonSelectSentenceView.h"
#import "LYCustomEmojiCollectionView.h"
#import "LYMakeEmoticonImageCell.h"
#import "LYEmoticonModel.h"
#import "UIView+LYCorners.h"

#define  LYMakeEmoticonSelectSentenceCellH 48

@interface LYMakeEmoticonSelectSentenceView()<UITableViewDelegate,UITableViewDataSource>
/// 包装选择器
@property (nonatomic, strong) UIView *contentView;
/// 蒙板
@property (nonatomic, strong) UIView *cover;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topLine;
/// 列表视图
@property (nonatomic, strong) UITableView *tableView;
///
@property (nonatomic, strong) UIPageControl *emojiPageControl;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation LYMakeEmoticonSelectSentenceView

/// 快速创建pickerview方法
+ (instancetype)sharedInstance{
    LYMakeEmoticonSelectSentenceView *view = [[LYMakeEmoticonSelectSentenceView alloc] init];
    return view;
}

/// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setupSubViews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = LYClearColor;
        

    }
    return self;
}

#pragma mark - 设置子控件
- (void)_setupSubViews{
#pragma -mark 添加子控件
    [self addSubview:self.cover];
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.topLine];
    [self.contentView addSubview:self.tableView];
    [self addSubview:self.contentView];
    
#pragma -mark 设置子控件约束
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_width);
    }];
    CGFloat labelH = 50;
    CGFloat leftMagin = 14;

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(leftMagin);
        make.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(@(labelH));
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.titleLabel);
        make.width.mas_equalTo(@(labelH));
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
        make.top.equalTo(self.topLine.mas_bottom);
    }];
    
    
}


- (void)setDataSourece:(NSMutableArray *)dataSourece{
    _dataSourece = dataSourece;

    [self.tableView reloadData];
}

#pragma mark - 显示选择指示器
- (void)showInViewWithAnimated:(BOOL)animated{
    
    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat backViewH = SCREEN_HEIGHT - NAVBAR_HEIGHT - 30 - kTabbarExtra;
    CGFloat Y         = SCREEN_HEIGHT - backViewH - kTabbarExtra;
    
    if (animated)
    {
        // 动画显示
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        }];
        [self.contentView addRoundedCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, SCREEN_WIDTH, backViewH + kTabbarExtra)];

        self.cover.alpha = 0.5;
        
    }else
    {
        // 无动画显示
        self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        
        self.cover.alpha = 0.5;
        
    }
}
#pragma mark - 退出
- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.cover removeFromSuperview];
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 关闭操作
- (void)closeAction{
    [self close];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourece.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title   = self.dataSourece[indexPath.row];
    LYMakeEmoticonSelectSentenceCell *cell = [LYMakeEmoticonSelectSentenceCell cellWithTableView:tableView];
    cell.title = title;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LYMakeEmoticonSelectSentenceCellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self closeAction];
    
    NSString *title   = self.dataSourece[indexPath.row];
    if (self.block) {
        self.block(title);
    }
    
}

#pragma mark - 懒加载
- (UIView *)cover{
    return LY_LAZY(_cover, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYBlackColorHex);
        view.alpha = 0;
        view;
    }));
}

- (UIView *)contentView{
    return LY_LAZY(_contentView, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, LYMakeEmoticonSelectSentenceCellH);
        view;
    }));
}
- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.userInteractionEnabled = YES;
        view.textColor = LYColor(@"#3B495C");
        view.text = @"热门配文";
        view.font = [UIFont boldSystemFontOfSize:20.f];
        view.backgroundColor = LYColor(LYWhiteColorHex);
        view;
    }));
}
- (UIView *)topLine{
    return LY_LAZY(_topLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, LYMakeEmoticonSelectSentenceCellH) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = LYColor(LYWhiteColorHex);
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    return _tableView;
}
- (UIButton *)closeButton{
    return LY_LAZY(_closeButton, ({
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"webView_closeItem"] forState:UIControlStateNormal];
        btn;
    }));
}
#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.contentView) {
            
        }else if(touch.view == self.titleLabel){
            [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }else{
            [self close];
        }
    }
}

@end









@interface LYMakeEmoticonSelectSentenceCell ()
@property (nonatomic, strong) UILabel *titleLabe;
/** 顶部线条 */
@property (nonatomic, strong) UIView *topLine;
@end

@implementation LYMakeEmoticonSelectSentenceCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"LYMakeEmoticonSelectSentenceCell";
    LYMakeEmoticonSelectSentenceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[LYMakeEmoticonSelectSentenceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = LYColor(LYWhiteColorHex);
        
        [self _setupSubViews];
        
        
    }
    return self;
}

- (void)_setupSubViews{
    [self addSubview:self.titleLabe];
    [self addSubview:self.topLine];
    
    CGFloat leftMagin = 14;
    
    [self.titleLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(leftMagin);
        make.right.equalTo(self.mas_right).offset(-leftMagin);
        make.height.mas_equalTo(@20);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(@(LYCellLineHeight));
    }];
    
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabe.text = title;
}


#pragma - lazy loading
- (UILabel *)titleLabe{
    if (!_titleLabe) {
        _titleLabe = [UILabel new];
        _titleLabe.textColor = LYColor(@"#333333");
        _titleLabe.font = [UIFont systemFontOfSize:13.f];
    }
    return _titleLabe;
}
- (UIView *)topLine{
    return LY_LAZY(_topLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
@end
