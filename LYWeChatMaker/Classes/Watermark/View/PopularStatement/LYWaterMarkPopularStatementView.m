//
//  LYWaterMarkPopularStatementView.m
//  LYWeChatMaker
//
//  Created by CNFOL_iOS on 2019/1/13.
//  Copyright © 2019年 LYoung_iOS. All rights reserved.
//

#import "LYWaterMarkPopularStatementView.h"
#import "LYDrawRectangleView.h"
#import "LYWatermarkInputView.h"
#import "MSWeakTimer.h"
#import "LYWatermarkInputConfig.h"

#define LYWatermarkEditTextViewH 60
#define LYWatermarkEditTextViewTextFiledH 40
#define LYWatermarkEditTextInputW (SCREEN_WIDTH - 80)
#define LYWatermarkEditTextInputH ((SCREEN_WIDTH - 80)/3)

@interface LYWaterMarkPopularStatementView ()<UITableViewDelegate,UITableViewDataSource>

/** 顶部线 */
@property (nonatomic, strong) UIView *topLineView;
/** 内容视图 */
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation LYWaterMarkPopularStatementView

- (instancetype)initWithFrame:(CGRect)frame{
    
    CGRect framef = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self = [super initWithFrame:framef];
    if (self) {
        self.frame = framef;
        
        [self _setupSubView];
        
    }
    return self;
}

- (void)_setupSubView{
    
    //我加在了keyWindow上
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGFloat backY     = NAVBAR_HEIGHT + 100;
    CGFloat backH     = SCREEN_HEIGHT - NAVBAR_HEIGHT - 100;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, backY, SCREEN_WIDTH, backH) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYWaterMarkPopularCell *cell = [LYWaterMarkPopularCell cellWithTableView:tableView];
    cell.titleStr = self.dataArray[indexPath.row];
    return cell;
}

- (void)setInputConfig:(LYWatermarkInputConfig *)inputConfig{
    _inputConfig = inputConfig;
}


#pragma mark - 发表按钮点击
- (void)confirmBtnAction{
    if (self.block) {
        self.block(self.inputConfig);
    }
    [self dismiss];
}

#pragma mark - 触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch *touch in event.allTouches) {
        if (touch.view == self.tableView) {
            
        }else{
            [self dismiss];
        }
    }
}


#pragma mark - 退出
- (void)dismiss{
    [self removeFromSuperview];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        [_dataArray addObjectsFromArray:@[@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算",@"aasd按时打算打算asd按时打算打算asd按时打算打算",@"asd按时打算打算asd按时打算打算"]];
    }
    return _dataArray;
}

- (void)dealloc{
}


@end



@interface LYWaterMarkPopularCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYWaterMarkPopularCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"LYWaterMarkPopularCell";
    
    LYWaterMarkPopularCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LYWaterMarkPopularCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
  
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    CGFloat leftM = 14.f;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(leftM);
        make.right.equalTo(self.mas_right).offset(-leftM);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

- (UILabel *)titleLabel{
    return LY_LAZY(_titleLabel, ({
        UILabel *view = [UILabel new];
        view.textColor = LYColor(LYBlackColorHex);
        view.font = LYSystemFont(14.f);
        [self addSubview:view];
        view;
    }));
}

@end

