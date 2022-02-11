//
//  ABMessgeConViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/24.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABMessgeConViewController.h"
#import "ABMessageConModel.h"
#import "ABMessageConCell.h"

@interface ABMessgeConViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)NSMutableArray *dataArray;
@end

@implementation ABMessgeConViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = self.n_title;
     
    [self setupUI];
    [ABMineInterface mine_MessageCenterWithParams:@{} success:^(id  _Nonnull responseObject) {
        //ABMessageConModel *model = [ABMessageConModel yy_modelWithDictionary:responseObject[@"data"]];
        [self.tableView reloadData];
    }];
}

- (void)setupUI {
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight - kTopHeight);
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ABMessageConCell class] forCellReuseIdentifier:NSStringFromClass([ABMessageConCell class])];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
}

// MARK: tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.dataArray.count;
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dynamicallyCalculateCellHeight:@""];
}

- (CGFloat)dynamicallyCalculateCellHeight:(NSString *)str {
    CGFloat height = 18+20+20+12*2;
    NSString *str1 = @"In order to improve the efficiency of the consultation, please upload the necessary pictures and write instructions first.";
    CGFloat con_W = [str1 getWidthWithHeight:FONT_REGULAR(13).lineHeight Font:FONT_REGULAR(13)];
    if (con_W < kScreenWidth-51-16-6) {
        return height+FONT_REGULAR(13).lineHeight;
    } else {
        CGRect contentLabRect = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth-51-16-24-6, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(13)} context:nil];
        return height+contentLabRect.size.height;
    }
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABMessageConCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ABMessageConCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    ABMessageConModel *model = ABMessageConModel.new;
    cell.model = model;
    return cell;
}

//
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.array;
    }
    return _dataArray;
}
@end
