//
//  ABPopRegisterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/5.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABPopRegisterViewController.h"

@interface ABPopRegisterCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *selBtn;

@property (nonatomic ,strong) ABNationModel *model;
@end

@implementation ABPopRegisterCell

// MARK: data
- (void)setModel:(ABNationModel *)model {
    _model = model;
    
    self.titleLab.text = model.value;
    self.lineView.frame = CGRectMake(ratioW(20), ratioH(43), ratioW(281)-ratioW(20)*2, 1);
    
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_MEDIUM(15);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        [self.contentView addSubview:_titleLab];
        _titleLab.frame = CGRectMake(ratioW(20), (ratioH(44)-ratioH(17))/2, ratioW(281)-ratioW(20)*2, ratioH(17));
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

- (UIButton *)selBtn {
    if (!_selBtn) {
        _selBtn = UIButton.new;
        [_selBtn setImage:ImageName(@"Controls Small_Checkboxes_Ok_1") forState:UIControlStateNormal];
        [self.contentView addSubview:_selBtn];
        _selBtn.hidden = YES;
        _selBtn.frame = CGRectMake(ratioW(281)-ratioW(26)-ratioH(24), (ratioH(44)-ratioH(24))/2, ratioH(24), ratioH(24));
    }
    return _selBtn;
}
@end

@interface ABPopRegisterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) NSMutableArray *dataList;
@end

@implementation ABPopRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [ABLoginInterface login_registerSysParamsNationWithParams:nil success:^(id  _Nonnull responseObject) {
        NSArray *array = responseObject[@"data"];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ABNationModel *model = [ABNationModel yy_modelWithDictionary:obj];
            if ([self.model.value isEqualToString:model.value]) {
                [self.dataList insertObject:model atIndex:0];
            } else {
                [self.dataList addObject:model];
            }
        }];
        
        
        [self setupUI];
    }];
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, 0, self.bgView.width, self.bgView.height);
    [self.bgView addSubview:self.tableView];
    [self.tableView registerClass:[ABPopRegisterCell class] forCellReuseIdentifier:NSStringFromClass([ABPopRegisterCell class])];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ABPopRegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABPopRegisterCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.model = _dataList[indexPath.row];
    cell.selBtn.hidden = indexPath.row == 0 ? NO : YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ratioH(44);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ratioH(94);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    
    UILabel *lab = UILabel.new;
    [view addSubview:lab];
    lab.font = FONT_BOLD(16);
    lab.textColor = [UIColor colorWithHexString:@"0x161B19"];
    lab.text = @"Select Country";
    lab.frame = CGRectMake(ratioW(20), ratioH(32), ratioW(281)-ratioW(20), ratioH(21));
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kLineColor;
    [view addSubview:lineView];
    lineView.frame = CGRectMake(0, lab.bottom+ratioH(24), ratioW(281), 1);
    
    kWeakSelf(self);
    UIButton *btn = UIButton.new;
    [view addSubview:btn];
    [btn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
    btn.frame = CGRectMake(ratioW(281)-ratioH(20)-ratioW(16), ratioH(32), ratioH(20), ratioH(20));
    [btn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    return view;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(popRegister:)]) {
            [self.delegate popRegister:_dataList[indexPath.row]];
        }
    }];
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KWhiteColor;
        [self.view addSubview:_bgView];
        _bgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH(325))/2, ratioW(281), ratioH(325));
        [_bgView addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(25, 25)];
    }
    return _bgView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = NSMutableArray.array;
    }
    return _dataList;
}
@end
