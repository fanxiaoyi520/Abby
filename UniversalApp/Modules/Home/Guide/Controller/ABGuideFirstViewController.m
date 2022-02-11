//
//  ABGuideFirstViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/15.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABGuideFirstViewController.h"
#import "ABGuideFirstCell.h"
#import "ABGuideModel.h"

@interface ABGuideFirstViewController ()<UITableViewDelegate,UITableViewDataSource,ABGuideFirstDelegate>

@property (nonatomic , strong)UIView *backView;
@property (nonatomic ,strong)NSMutableArray *dataArray;
@property (nonatomic ,strong)NSMutableArray *selArray;
@end

@implementation ABGuideFirstViewController

- (void)viewDidLoad {
    [self  superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupUI];
    
    NSArray *array = @[@{@"content":@"1.Do you need to prepare a female clone?"},@{@"content":@"2. Do you need to prepare at least 3 gallons of purified water and nutrients?"},@{@"content":@"2. Do you need to prepare at least 3 gallons of purified water and nutrients?"}];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ABGuideFirstModel *model = [ABGuideFirstModel yy_modelWithDictionary:(NSDictionary *)obj];
        [self.dataArray addObject:model];
    }];
    [self.selArray removeAllObjects];
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.selArray addObject:@"0"];
    }];
    
    [self.tableView reloadData];
}

- (void)superConfigure {
    self.bg_Height = 581;
    self.content_Str = @"​You need to complete these two things at once before you can start planting journey.";
    self.btn_bg_Color = @"0xC8C8C8";
    self.btn_Title = @"Next";
    self.isLeft = YES;
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, self.contentLab.bottom+24, KScreenWidth , self.sureBtn.top-self.contentLab.bottom-24-24);
    [self.bgView addSubview:self.tableView];
    [self.tableView registerClass:[ABGuideFirstCell class] forCellReuseIdentifier:NSStringFromClass([ABGuideFirstCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = KWhiteColor;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
}

// MARK: actions
- (void)sureBtnFuncAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(guide_setpOneNextAction:)]) {
            [self.delegate guide_setpOneNextAction:sender];
        }
    }];
}

// MARK: tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABGuideFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABGuideFirstCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.delegate = self;
    cell.model = self.dataArray[indexPath.row];
    [cell updateSelStatus:[self.selArray[indexPath.row] boolValue]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABGuideFirstModel *model = self.dataArray[indexPath.row];
    CGRect contentLabRect = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth-26*2-16-60, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_BOLD(16)} context:nil];
    return contentLabRect.size.height+16*2+22;
}

// MARK: ABGuideFirstDelegate
- (void)guideFirstAction:(UIButton *)sender {
    ABGuideFirstCell *cell = (ABGuideFirstCell *)sender.superview.superview;
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

- (NSMutableArray *)selArray {
    if (!_selArray) {
        _selArray = NSMutableArray.array;
    }
    return _selArray;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.array;
    }
    return _dataArray;
}
@end
