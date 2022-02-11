//
//  ABReleaseViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/29.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABReleaseViewController.h"
#import "HDragItemListView.h"
#import "ABPostTrendCell.h"

#define kSingleLineHeight 36
#define kMaxLines  6
@interface ABReleaseViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) YYTextView *textView;
@property (nonatomic, strong) HDragItemListView *itemList;
@property (nonatomic, strong) NSArray *dataList;
@end

@implementation ABReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Cancel"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    [[ABGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 57, 32);
    [btn setTitle:@"Post" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = SYSTEMFONT(17);
    [btn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"0x026040"];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [UIView jaf_cutOptionalFillet:btn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(7, 7)];
    btn.tag = 2000;
    UIBarButtonItem * ribtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = ribtn;
    
    self.dataList = @[@{@"imageName":@"Table_icon_sync",@"title":@"Sync to Trend"},
                      @{@"imageName":@"Table_icon_data",@"title":@"Planting Data can be seen"}];
    [self setupUI];
}

- (void)setupUI {
    HDragItem *item = [[HDragItem alloc] init];
    item.backgroundColor = [UIColor colorWithHexString:@"0xE5E5E5"];
    ViewRadius(item, 10);
    item.image = [UIImage imageNamed:@"Group_266_bg"];
    item.isAdd = YES;
    
    HDragItemListView *itemList = [[HDragItemListView alloc] initWithFrame:CGRectMake(0, self.textView.bottom+16, self.view.frame.size.width, 0)];
    self.itemList = itemList;
    itemList.backgroundColor = [UIColor clearColor];
    itemList.scaleItemInSort = 1.3;
    itemList.isSort = YES;
    itemList.isFitItemListH = YES;
    [itemList addItem:item];
    itemList.itemListH = ratioH(123);
    itemList.isFitItemListH = ratioH(123);
    itemList.showDeleteView = NO;
    itemList.isFitItemListH = YES;
    itemList.maxItem = 4;
    itemList.itemListCols = 2;
    __weak typeof(self) weakSelf = self;

    [itemList setClickItemBlock:^(HDragItem *item) {
        if (item.isAdd) {
            NSLog(@"添加");
            [weakSelf showUIImagePickerController];
        }
    }];
    
    itemList.deleteItemBlock = ^(HDragItem *item) {
        HDragItem *lastItem = [weakSelf.itemList.itemArray lastObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!lastItem.isAdd) {
                HDragItem *item = [[HDragItem alloc] init];
                item.image = [UIImage imageNamed:@"Group_266_bg"];
                ViewRadius(item, 10);
                item.isAdd = YES;
                [weakSelf.itemList addItem:item];
            }
            [weakSelf updateHeaderViewHeight];
        });
    };
    
    [self.view addSubview:itemList];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, KScreenHeight-CONTACTS_HEIGHT_NAV);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = nil;
    self.tableView.mj_footer.hidden = YES;
    self.tableView.mj_header.hidden = YES;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.itemList.itemListH + self.itemList.originY+33)];
    
    [headerView addSubview:self.textView];
    [headerView addSubview:itemList];

    itemList.originY = _textView.bottom + 16;
    headerView.height = itemList.height + itemList.originY+33;
    
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:ABPostTrendCell.class forCellReuseIdentifier:NSStringFromClass(ABPostTrendCell.class)];
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navRightAction:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

//更新头部高度
- (void)updateHeaderViewHeight{
    self.itemList.originY = _textView.bottom + 16;
    self.tableView.tableHeaderView.height = self.itemList.itemListH + self.itemList.originY+33;
    [self.tableView beginUpdates]; //加上这对代码，改header的时候，会有动画，不然比较僵硬
    self.tableView.tableHeaderView = self.tableView.tableHeaderView;
    [self.tableView endUpdates];
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ABPostTrendCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ABPostTrendCell.class)];
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.dataList[indexPath.row];
    if (indexPath.row == 0) {
        UIView * lineView = UIView.new;
        lineView.backgroundColor = kLineColor;
        lineView.frame = CGRectMake(20, 0, kScreenWidth-20*2, 1);
        [cell addSubview:lineView];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// MARK: - UIImagePickerController
- (void)showUIImagePickerController{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    controller.modalPresentationStyle = 0;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
        HDragItem *item = [[HDragItem alloc] init];
        item.image = image;
        item.backgroundColor = [UIColor purpleColor];
        [self.itemList addItem:item];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateHeaderViewHeight];
        });
    }];
}

// MARK: Lazy loading
- (YYTextView *)textView {
    if (!_textView) {
        _textView = YYTextView.new;
        _textView.frame = CGRectMake(16, 20, kScreenWidth-16*2, ratioH(160));
        _textView.textContainerInset = UIEdgeInsetsMake(4, 4, 4, 4);
        _textView.font = FONT_REGULAR(15);
        _textView.textColor = [UIColor colorWithHexString:@"0x000000"];
        _textView.placeholderText = @"Record the journey of your plants";
        _textView.placeholderFont = FONT_REGULAR(15);
        _textView.placeholderTextColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        _textView.showsVerticalScrollIndicator = NO;
        _textView.showsHorizontalScrollIndicator = NO;
        ViewRadius(_textView, 5);
    }
    return _textView;
}

@end
