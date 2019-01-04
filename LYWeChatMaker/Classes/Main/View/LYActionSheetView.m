//
//  LYActionSheetView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2018/12/10.
//  Copyright © 2018年 LYoung_iOS. All rights reserved.
//

#import "LYActionSheetView.h"

#define LYActionSheetViewOneCellHeight 50

@interface LYActionSheetView ()<UITableViewDelegate,UITableViewDataSource>
/// 包装选择器
@property (nonatomic, strong) UIView *contentView;
/// 蒙板
@property (nonatomic, strong) UIView *cover;
/// 背景
@property (nonatomic, strong) UITableView *tableView;
/// title数组
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation LYActionSheetView

/// 快速创建pickerview方法
+ (instancetype)sharedInstance{
    LYActionSheetView *weight = [[LYActionSheetView alloc] init];
    return weight;
}

/// 重写初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 设置子控件
- (void)setupSubViews{
#pragma -mark 添加子控件
    [self addSubview:self.cover];
    [self.contentView addSubview:self.tableView];
    [self addSubview:self.contentView];
    
#pragma -mark 设置子控件约束
    CGFloat tableH = LYActionSheetViewOneCellHeight;
    
    [self.cover mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_width);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(@(tableH));
    }];
    
}

#pragma mark - 显示选择指示器
- (void)showInViewWithTitles:(NSMutableArray *)titles animated:(BOOL)animated{
    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat oneCellH  = LYActionSheetViewOneCellHeight;
    CGFloat contentH  = (titles.count == 0)?oneCellH:titles.count*oneCellH;
    CGFloat backViewH = contentH ;
    CGFloat Y         = SCREEN_HEIGHT - backViewH - kTabbarExtra;
    
    if (animated)
    {
        // 动画显示
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(contentH));
                make.top.equalTo(self.contentView.mas_top);
            }];
            
            NSMutableArray *titleArr = [NSMutableArray arrayWithArray:titles];
            if (titles.count == 0) {
                [titleArr addObject:@"取消"];
            }
            self.titleArray  = titleArr;
            [self.tableView reloadData];
        }];
        self.cover.alpha = 0.5;
        
    }else
    {
        // 无动画显示
        self.contentView.frame = CGRectMake(0, Y, SCREEN_WIDTH, backViewH + kTabbarExtra);
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(contentH));
            make.top.equalTo(self.contentView.mas_top);
        }];
        
        NSMutableArray *titleArr = [NSMutableArray arrayWithArray:titles];
        if (titles.count == 0) {
            [titleArr addObject:@"取消"];
        }
        self.titleArray  = titleArr;
        [self.tableView reloadData];
        
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

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title   = self.titleArray[indexPath.row];
    BOOL isCancel = (indexPath.row == (self.titleArray.count - 1));
    LYActionSheetViewCell *cell = [LYActionSheetViewCell cellWithTableView:tableView];
    [cell configCellWithTitle:title isCancel:isCancel];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return LYActionSheetViewOneCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self closeAction];
    
    if (self.btnBlock) {
        self.btnBlock(indexPath.row);
    }
    
}


#pragma mark - 关闭操作
- (void)closeAction{
    [self close];
}



#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, LYActionSheetViewOneCellHeight) style:UITableViewStylePlain];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = LYColor(LYWhiteColorHex);
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (UIView *)cover{
    if (!_cover) {
        _cover = [[UIView alloc] init];
        _cover.backgroundColor = LYColor(LYBlackColorHex);
        _cover.alpha = 0;
    }
    return _cover;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = LYColor(LYWhiteColorHex);
        _contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, LYActionSheetViewOneCellHeight);
    }
    return _contentView;
}
- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}


#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.contentView) {
            
        }else{
//            [self close];
        }
    }
}

@end


@interface LYActionSheetViewCell ()
@property (nonatomic, strong) UILabel *titleVew;
/** 顶部线条 */
@property (nonatomic, strong) UIView *topLine;
@end

@implementation LYActionSheetViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellIndertifer = @"LYActionSheetViewCell";
    LYActionSheetViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[LYActionSheetViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
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
    [self addSubview:self.titleVew];
    [self addSubview:self.topLine];

    CGFloat leftMagin = 24;
    
    [self.titleVew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(leftMagin);
        make.right.equalTo(self.mas_right).offset(-leftMagin);
        make.height.mas_equalTo(@20);
    }];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(@0.7);
    }];
    
}

- (void)configCellWithTitle:(NSString *)title isCancel:(BOOL)isCancel{
    if (isCancel) {
        self.titleVew.textColor = LYColor(@"#999999");
        self.titleVew.text = @"取消";
    }else{
        self.titleVew.textColor = LYColor(@"#444444");
        self.titleVew.text = title;
    }
}


#pragma - lazy loading
- (UILabel *)titleVew{
    if (!_titleVew) {
        _titleVew = [UILabel new];
        _titleVew.textColor = LYColor(@"#999999");
        _titleVew.font = [UIFont systemFontOfSize:16];
    }
    return _titleVew;
}
- (UIView *)topLine{
    return LY_LAZY(_topLine, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = LYCellLineColor;
        view;
    }));
}
@end
