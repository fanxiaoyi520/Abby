//
//  ABPlantDataViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPlantDataViewController.h"
#import "ABPlantDataCell.h"

@interface ABPlantDataViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UIView *bgView;
@property (nonatomic , strong) NSArray *dataList;
@end

@implementation ABPlantDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = @[@{@"imageName":@"icon_16_s_y_1",@"title":@"2 week",@"detail":@"3/7 day"},
                      @{@"imageName":@"icon_16_c_y",@"title":@"Height",@"detail":@"66 mm"},
                      @{@"imageName":@"icon_16_w_y",@"title":@"Temperture Air",@"detail":@"120℉"},
                      @{@"imageName":@"icon_16_s_y",@"title":@"Temperture Water",@"detail":@"10℉"},
                      @{@"imageName":@"icon_16_x_y",@"title":@"Humidity",@"detail":@"66%"}];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.bgView];
    
    
    self.tableView.frame = CGRectMake(0, 0, self.bgView.width, self.bgView.height);
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    [self.bgView addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = KWhiteColor;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ABPlantDataCell class] forCellReuseIdentifier:NSStringFromClass([ABPlantDataCell class])];
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ABPlantDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABPlantDataCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.dataList[indexPath.row];
    if (indexPath.row == self.dataList.count-1) cell.lineView.hidden = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return ratioH(68);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    UILabel *lab = UILabel.new;
    lab.font = FONT_BOLD(16);
    lab.textColor = [UIColor colorWithHexString:@"0x161B19"];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, ratioH(32), self.bgView.width, ratioH(21));
    lab.text = @"Plant data";
    [view addSubview:lab];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ratioH(42);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return ratioH(84);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = UIView.new;
    UIView *lineView = UIView.new;
    lineView.backgroundColor = kLineColor;
    [view addSubview:lineView];
    lineView.frame =  CGRectMake(0, ratioH(24), self.bgView.width, 1);
    UIButton *btn = UIButton.new;
    [btn setTitle:@"OK" forState:UIControlStateNormal];
    [view addSubview:btn];
    btn.titleLabel.font = FONT_MEDIUM(18);
    btn.frame = CGRectMake(0, ratioH(24), self.bgView.width, ratioH(60));
    [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
    kWeakSelf(self);
    [btn addTapBlock:^(UIButton *btn) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    return view;
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (KScreenHeight-ratioH(362))/2, ratioW(281), ratioH(362));
        _bgView.backgroundColor = KWhiteColor;
        [_bgView addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(15, 15)];
    }
    return _bgView;
}
@end
