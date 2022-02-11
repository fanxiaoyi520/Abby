//
//  ABOxygenViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/21.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABOxygenViewController.h"
#import "ABOxygenModel.h"

@interface ABOxygenViewController ()

@property (nonatomic , strong)UIImageView *tabImgView;
@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIView *lineView;
@property (nonatomic , strong)NSMutableArray *dataSource;
@end

@implementation ABOxygenViewController

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABHomeOxygenData"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        ABOxygenModel *model = [ABOxygenModel yy_modelWithJSON:obj1];
        if (i==0) model.perData = [NSString stringWithFormat:@"%@%%",deviceManager.dpsModel.humidity_current];
        if (i==1) model.perData = [NSString stringWithFormat:@"%@℉",deviceManager.dpsModel.water_temperature];
        if (i==2) model.perData = [NSString stringWithFormat:@"%@℉",deviceManager.dpsModel.temp_current];
        [self.dataSource addObject:model];
    }];
    
    [self setupUI];
}

- (void)superConfigure {
    self.bg_Height = 514;
    self.isLeft = NO;
}

- (void)setupUI {
    self.contentLab.hidden = YES;
    self.sureBtn.hidden = YES;
    
    self.tabImgView.frame = CGRectMake(25, 25, 22, 22);
    self.tabImgView.image = ImageName(@"icon_h_o2");
    self.titleLab.text = @"Current data";
    self.titleLab.frame = CGRectMake(self.tabImgView.right+9, 27, 200, 19);
    
    self.lineView.frame = CGRectMake(24, 67, kScreenWidth-24*2, 1);
    
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
        [self.bgView addSubview:view];
        view.frame = CGRectMake(24, self.lineView.bottom+26+idx*(90+16), kScreenWidth-24*2, 90);
        [UIView jaf_cutOptionalFillet:view byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
        [self layoutSubviews:view withModel:self.dataSource[idx]];
    }];
}

- (void)layoutSubviews:(UIView *)view withModel:(ABOxygenModel *)model {
    UILabel *lab = [UILabel new];
    [view addSubview:lab];
    lab.font = FONT_REGULAR(13);
    lab.textColor = [UIColor colorWithHexString:@"0x000000"];
    lab.text = model.title;
    CGFloat lab_w = [model.title getWidthWithHeight:16 Font:lab.font];
    lab.frame = CGRectMake(16, 16, lab_w, 16);
    
    UILabel *statusLab = [UILabel new];
    [view addSubview:statusLab];
    statusLab.font = FONT_BOLD(16);
    statusLab.textColor = [UIColor colorWithHexString:@"0x006241"];
    statusLab.text = model.status;
    CGFloat statusLab_w = [model.status getWidthWithHeight:19 Font:statusLab.font];
    statusLab.frame = CGRectMake(16, lab.bottom+2, statusLab_w, 19);
    
    UILabel *tipsLab = [UILabel new];
    [view addSubview:tipsLab];
    tipsLab.font = FONT_REGULAR(13);
    tipsLab.textColor = [UIColor colorWithHexString:@"0x000000"];
    tipsLab.text = model.status;
    CGFloat tipsLab_w = [model.tips getWidthWithHeight:16 Font:tipsLab.font];
    tipsLab.frame = CGRectMake(16, tipsLab.bottom+5, tipsLab_w, 16);
    
    UILabel *perDataLab = [UILabel new];
    [view addSubview:perDataLab];
    perDataLab.font = FONT_BOLD(24);
    perDataLab.textColor = [UIColor colorWithHexString:@"0x00754A"];
    perDataLab.text = model.perData;
    CGFloat perDataLab_w = [model.perData getWidthWithHeight:29 Font:perDataLab.font];
    perDataLab.frame = CGRectMake(view.width-perDataLab_w-24, 20, perDataLab_w, 29);
}

// MARK: Lazy loading
- (UIImageView *)tabImgView {
    if (!_tabImgView) {
        _tabImgView = [UIImageView new];
        [self.bgView addSubview:_tabImgView];
    }
    return _tabImgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_BOLD(16);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self.bgView addSubview:_titleLab];
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = kLineColor;
        [self.bgView addSubview:_lineView];
    }
    return _lineView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
@end
