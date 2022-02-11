//
//  ABHelpAndFBViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/13.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABHelpAndFBViewController.h"
#import "WaterFlowLayout.h"
#import "WaterFallCollectionViewCell.h"
#import "ABHelpAndFBLogic.h"

@interface ABHelpAndFBViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFlowLayoutDelegate,ABGlobalDelegate>

@property (nonatomic , strong)UILabel *titleLab;
@property (nonatomic , strong)UIButton *feedbackBtn;
@property (nonatomic , strong)UIView *backView;
@property (nonatomic,strong) ABHelpAndFBLogic * logic;
@end

@implementation ABHelpAndFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _logic = [ABHelpAndFBLogic new];
    _logic.delegagte = self;
    [_logic loadData];
    
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Help & Feedback";
    [self setupUI];
}

- (void)setupUI {
    
    self.titleLab.text = @"Common instructions";
    CGFloat titleLabW = [_titleLab.text getWidthWithHeight:28 Font:_titleLab.font];
    self.titleLab.frame = CGRectMake(40, 24, titleLabW, 28);
    
    //设置瀑布流布局
    WaterFlowLayout *layout = [WaterFlowLayout new];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(-24, 40, 0, 51);
    layout.rowMargin = 24;
    layout.columnMargin = 24;
    layout.delegate = self;
    
    [self.collectionView setCollectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([WaterFallCollectionViewCell class])];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foo"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.mj_header.hidden = YES;
    self.collectionView.mj_footer.hidden = YES;
    self.collectionView.frame = CGRectMake(0, self.titleLab.bottom+16, KScreenWidth , KScreenHeight-68-CONTACTS_HEIGHT_NAV-CONTACTS_SAFE_BOTTOM-108);
    [self.view addSubview:self.collectionView];
    
    self.backView.frame = CGRectMake(0, kScreenHeight-108-CONTACTS_SAFE_BOTTOM-CONTACTS_HEIGHT_NAV, kScreenWidth, 108+CONTACTS_HEIGHT_NAV);
    self.feedbackBtn.frame = CGRectMake(27, 24, kScreenWidth-27*2, 60);
    [UIView jaf_cutOptionalFillet:self.feedbackBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
}

// MARK: ————— 数据拉取完成 渲染页面 —————
-(void)requestDataCompleted{
    [UIView performWithoutAnimation:^{
        [self.collectionView reloadData];
    }];
}

// MARK:  ————— collection代理方法 —————
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _logic.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WaterFallCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    cell.model = _logic.dataArray[indexPath.row];
    [UIView jaf_cutOptionalFillet:cell byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 60);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionReusableView *foo = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
    foo.backgroundColor = KRedColor;
    return foo;
}

#define itemWidthHeight ((kScreenWidth-40-51)/2)
// MARK:  ————— layout 代理 —————
-(CGFloat)waterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForWidth:(CGFloat)width andIndexPath:(NSIndexPath *)indexPath{
    return 160 * itemWidthHeight / 130;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    [UIViewController jaf_showHudTip:@"h5"];
    if (indexPath.row == 0) {
        XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_guide withNavTitle:@"Guide"];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        XLWebViewController *vc = [[XLWebViewController alloc] initWithUrl:web_url_installationNotes withNavTitle:@"Installation Notes"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


// MARK: actions
- (void)feedbackAction {
    [[IMManager sharedIMManager] IMGoChatVC:self withServiceNumberType:ServiceNumber_Expert];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        [self.view addSubview:_titleLab];
        _titleLab.font = FONT_MEDIUM(18);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
    }
    return _titleLab;
}

- (UIButton *)feedbackBtn {
    if (!_feedbackBtn) {
        _feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backView addSubview:_feedbackBtn];
        _feedbackBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
        [_feedbackBtn setTitle:@"Feedback" forState:UIControlStateNormal];
        [_feedbackBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        [_feedbackBtn addTarget:self action:@selector(feedbackAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feedbackBtn;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        [self.view addSubview:_backView];
        _backView.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
    }
    return _backView;
}
@end
