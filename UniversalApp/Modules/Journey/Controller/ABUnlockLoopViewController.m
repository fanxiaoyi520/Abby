//
//  ABUnlockLoopViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/14.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABUnlockLoopViewController.h"
#import "ABUnlockLoopCell.h"
#import "ABUnlockLoopLogic.h"
#import "ABUnlockLoopModel.h"

@interface ABUnlockLoopViewController ()<UITableViewDelegate,UITableViewDataSource,ABGlobalDelegate,ABUnlockLoopCellDelegate>

@property (nonatomic , strong)UIView *backView;
@property (nonatomic ,strong)UIButton *sureBtn;
@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)ABUnlockLoopLogic *logic;
@property (nonatomic ,strong)NSMutableArray *selArray;
@end

@implementation ABUnlockLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    [self addNavigationItemWithImageNames:@[@"icon_28_kf"] isLeft:NO target:self action:@selector(rightBtnClick:) tags:@[@2001]];

    self.navTitle = @"Unlock loop";
    _logic = ABUnlockLoopLogic.new;
    _logic.delegagte = self;
    
    [_logic loadData];
    [self setupUI];
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth , KScreenHeight-CONTACTS_HEIGHT_NAV-CONTACTS_SAFE_BOTTOM-108);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ABUnlockLoopCell class] forCellReuseIdentifier:NSStringFromClass([ABUnlockLoopCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    
    UIView *headerView = UIView.new;
    
    UILabel *lab = UILabel.new;
    lab.font = FONT_MEDIUM(15);
    lab.textColor = [UIColor colorWithHexString:@"0x006241"];
    lab.text = @"In order to ensure better growth of plants, please identify whether the current plant status meets the following characteristics and then switch to the next cycle.";
    lab.numberOfLines = 0;
    CGRect contentLabRect = [lab.text boundingRectWithSize:CGSizeMake(kScreenWidth-24*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_MEDIUM(15)} context:nil];
    lab.frame = CGRectMake(24, 24, kScreenWidth-24*2, contentLabRect.size.height);
    [headerView addSubview:lab];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 24+16+contentLabRect.size.height);
    self.tableView.tableHeaderView = headerView;
    
    self.backView.frame = CGRectMake(0, kScreenHeight-108-CONTACTS_SAFE_BOTTOM-CONTACTS_HEIGHT_NAV, kScreenWidth, 108+CONTACTS_HEIGHT_NAV);
    self.sureBtn.frame = CGRectMake(27, 24, kScreenWidth-27*2, 60);
    [UIView jaf_cutOptionalFillet:self.sureBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
}

// MARK: actions
- (void)rightBtnClick:(UIButton *)btn {
    [[IMManager sharedIMManager] IMGoChatVC:self withServiceNumberType:ServiceNumber_Default];
}

- (void)sureBtnAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(rewardTips)]) {
        [self.delegate rewardTips];
    }
}

// MARK: ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [self.selArray removeAllObjects];
    [_logic.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.selArray addObject:@"0"];
    }];
    
    [UIView performWithoutAnimation:^{
        [self.tableView reloadData];
    }];
}

// MARK: tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABUnlockLoopCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABUnlockLoopCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.delegate = self;
    cell.model = _logic.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABUnlockLoopModel *model = _logic.dataArray[indexPath.row];
    CGRect contentLabRect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth-24*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    return contentLabRect.size.height+16*2+ratioH(180)+50+32;
}

// MARK: ABUnlockLoopCellDelegate
- (void)unlockLoopCell_selFuncAction:(UIButton *)sender {
    ABUnlockLoopCell *cell = (ABUnlockLoopCell *)sender.superview;
    NSIndexPath *indePath = [self.tableView indexPathForCell:cell];
    [self.selArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==indePath.row) [self.selArray replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%d",sender.selected]];
    }];
    if ([self.selArray containsObject:@"0"]) {
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        self.sureBtn.enabled = NO;
    } else {
        self.sureBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        self.sureBtn.enabled = YES;
    }
}

// MARK: Lazy loading
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.view addSubview:_backView];
        _backView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
    }
    return _backView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backView addSubview:_sureBtn];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        [_sureBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.enabled = NO;
    }
    return _sureBtn;
}

- (NSMutableArray *)selArray {
    if (!_selArray) {
        _selArray = NSMutableArray.array;
    }
    return _selArray;
}
@end
