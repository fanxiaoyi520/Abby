//
//  ABSecConfirmViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABSecConfirmViewController.h"
#import "ABGuideTwoViewController.h"
#import "ABGuideSecondCell.h"
#import "ABGuideSecondLogic.h"
#import "ABGuideSecondModel.h"

@interface ABSecConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,ABGlobalDelegate,ABGuideSecondCellDelegate>

@property (nonatomic , strong)UIView *backView;
@property (nonatomic ,strong)UIButton *sureBtn1;
@property (nonatomic ,strong)ABGuideSecondLogic *logic;
@property (nonatomic ,strong)NSMutableArray *selArray;
@end

@implementation ABSecConfirmViewController

- (void)superConfigure {
    self.bg_Height = kScreenHeight-CONTACTS_HEIGHT_NAV-CONTACTS_HEIGHT_TOP;
    self.btn_bg_Color = @"0x006241";
    self.btn_Title = @"Next";
    self.isLeft = YES;
    self.content_color_Str = @"0x006241";
    self.btn_bg_Color = @"0xC8C8C8";
}

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _logic = ABGuideSecondLogic.new;
    _logic.delegagte = self;
    
    [_logic loadData];
    [self setupUI];
}

- (void)setupUI {
    self.sureBtn.hidden = YES;
    self.contentLab.hidden  = YES;
    
    self.tableView.frame = CGRectMake(0, 64, KScreenWidth , self.bg_Height-129-CONTACTS_SAFE_BOTTOM-64);
    [self.bgView addSubview:self.tableView];
    [self.tableView registerClass:[ABGuideSecondCell class] forCellReuseIdentifier:NSStringFromClass([ABGuideSecondCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.backgroundColor = KWhiteColor;
    
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
    
    self.backView.frame = CGRectMake(0, self.bg_Height-129-CONTACTS_SAFE_BOTTOM, kScreenWidth, 129+CONTACTS_SAFE_BOTTOM);
    self.sureBtn1.frame = CGRectMake(27, 24, kScreenWidth-27*2, 60);
    [UIView jaf_cutOptionalFillet:self.sureBtn1 byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
}

// MARK: actions
- (void)rightBtnClick:(UIButton *)btn {
    [UIViewController jaf_showHudTip:@"h5"];
}

- (void)sureBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(guide_guideSecondAction:)]) {
            [self.delegate guide_guideSecondAction:sender];
        }
    }];
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
    ABGuideSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABGuideSecondCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.delegate = self;
    cell.model = _logic.dataArray[indexPath.row];
    [cell updateSelStatus:[self.selArray[indexPath.row] boolValue]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABGuideSecondModel *model = _logic.dataArray[indexPath.row];
    CGRect contentLabRect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth-24*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    return contentLabRect.size.height+16*2+ratioH(180)+50+32;
}

// MARK: ABUnlockLoopCellDelegate
- (void)guideSecondCell_selFuncAction:(UIButton *)sender {
    ABGuideSecondCell *cell = (ABGuideSecondCell *)sender.superview;
    NSIndexPath *indePath = [self.tableView indexPathForCell:cell];
    [self.selArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx==indePath.row) [self.selArray replaceObjectAtIndex:idx withObject:[NSString stringWithFormat:@"%d",sender.selected]];
    }];
    if ([self.selArray containsObject:@"0"]) {
        self.sureBtn1.backgroundColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        self.sureBtn1.enabled = NO;
    } else {
        self.sureBtn1.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        self.sureBtn1.enabled = YES;
    }
}

// MARK: Lazy loading
- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.bgView addSubview:_backView];
        _backView.backgroundColor = KWhiteColor;
    }
    return _backView;
}

- (UIButton *)sureBtn1 {
    if (!_sureBtn1) {
        _sureBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backView addSubview:_sureBtn1];
        _sureBtn1.backgroundColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        [_sureBtn1 setTitle:@"Next" forState:UIControlStateNormal];
        [_sureBtn1 setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        [_sureBtn1 addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn1.enabled = NO;
    }
    return _sureBtn1;
}

- (NSMutableArray *)selArray {
    if (!_selArray) {
        _selArray = NSMutableArray.array;
    }
    return _selArray;
}

@end
