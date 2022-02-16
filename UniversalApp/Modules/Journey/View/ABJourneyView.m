//
//  ABJourneyView.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/7.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABJourneyView.h"
#import "ABJourneyCaseViewCell.h"
#import "ABCollectionViewFlowLayout.h"
#import "ABTurntableView.h"

static NSString * const reuseIdentifier = @"HomeCaseCellID";
@interface ABJourneyView()<UICollectionViewDelegate,UICollectionViewDataSource,ABTurntableDelegate>

@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UIButton *bloomBtn;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *caseArray;
@property (assign,nonatomic) NSInteger m_currentIndex;
@property (assign,nonatomic) CGFloat m_dragStartX;
@property (assign,nonatomic) CGFloat m_dragEndX;

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic , strong) ABTurntableView *turntableView;
@property (nonatomic , strong) NSArray *weekArray;
@property (nonatomic , strong) UIView *tipsView;
@property (nonatomic, assign) CGFloat vibrationAngle;
@property (nonatomic, assign) NSInteger angleNum;

@property (nonatomic, strong) UIButton *taskBtn;
@end
@implementation ABJourneyView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self loadData];
    }
    return self;
}

- (void)setupUI {
    self.vibrationAngle = 0;
    self.angleNum = 0;
    self.titleLab.text = @"Journey";
    [self.bloomBtn setTitle:@"Bloom" forState:UIControlStateNormal];
    
    ABCollectionViewFlowLayout *layout = [[ABCollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ratioW(170), ratioH(228));
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = ratioW(16);
    layout.minimumInteritemSpacing = ratioW(16);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundView = nil;
    [self.collectionView registerClass:[ABJourneyCaseViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self addSubview:self.collectionView];

    [self.collectionView setFrame:CGRectMake(0, YTVIEW_STATUSBAR_HEIGHT+ratioH(68), JLXScreenSize.width, ratioH(228))];
    self.collectionView.contentSize = CGSizeMake(self.caseArray.count*JLXScreenSize.width, 0);
    
    
    self.weekArray =  [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",nil];
    self.turntableView.image = ImageName(@"Group_389");
    self.turntableView.top = self.collectionView.bottom+ratioH(42);
    [self.turntableView plantGrowthCycleLayout:self.weekArray];
    
    UIImageView *tipsView = UIImageView.new;
    tipsView.image = ImageName(@"Exclude_tips");
    [self insertSubview:tipsView belowSubview:self.turntableView];
    tipsView.frame = CGRectMake((kScreenWidth-49)/2, self.collectionView.bottom+ratioH(42), 49, 35);
    self.tipsView = tipsView;
    
    [self.lockBtn setImage:ImageName(@"icon_50_bloom") forState:UIControlStateNormal];
    self.lockBtn.center = self.turntableView.center;
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 2.0f ;
    solidLine.strokeColor = [UIColor colorWithHexString:@"0x006241"].CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake((kScreenWidth-ratioH(320))/2, self.collectionView.bottom+ratioH(42), ratioH(320), ratioH(320)));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [self.layer addSublayer:solidLine];
    
    [self.taskBtn setImage:ImageName(@"icon_40_gfit") forState:UIControlStateNormal];
}

-(void)loadData{
    self.caseArray = [NSMutableArray array];
    ///加四次为了循环
    for (int i=0; i<12; i++) {
        [self.caseArray addObject:[NSString stringWithFormat:@"pic_plant_%d_L",i+1]];
    }
    [self.collectionView reloadData];
    [self.collectionView layoutIfNeeded];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.caseArray.count/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    self.m_currentIndex = self.caseArray.count/2;
}

//配置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width/20.0f;
    if (self.m_dragStartX -  self.m_dragEndX >= dragMiniDistance) {
        self.m_currentIndex -= 1;//向右
    }else if(self.m_dragEndX -  self.m_dragStartX >= dragMiniDistance){
        self.m_currentIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;

    self.m_currentIndex = self.m_currentIndex <= 0 ? 0 : self.m_currentIndex;
    self.m_currentIndex = self.m_currentIndex >= maxIndex ? maxIndex : self.m_currentIndex;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.m_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

// MARK: - ABTurntableDelegate
- (void)turntableChangeMove:(CGFloat)rotationAngleInRadians retation:(nonnull ABRotationGestureRecognizer *)retation{

    // 滑动每刻度角度调用震动效果 和 关联功能
    self.vibrationAngle = self.vibrationAngle + fabs(retation.rotation);
    if (self.vibrationAngle >= M_PI*2/self.weekArray.count) {
        UIImpactFeedbackGenerator *impactLight = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
        [impactLight impactOccurred];
        self.vibrationAngle = 0;
        
        self.m_currentIndex = (rotationAngleInRadians <= 0) ? self.m_currentIndex + 1 : self.m_currentIndex - 1;
        NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
        self.m_currentIndex = self.m_currentIndex <= 0 ? 0 : self.m_currentIndex;
        self.m_currentIndex = self.m_currentIndex >= maxIndex ? maxIndex : self.m_currentIndex;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.m_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.angleNum += M_PI*2/self.weekArray.count;
    }
    
    if (retation.state == UIGestureRecognizerStateEnded) {
        NSInteger round_Angle = round(rotationAngleInRadians/(M_PI*2/self.weekArray.count));
        self.turntableView.transform = CGAffineTransformMakeRotation(round_Angle*(M_PI*2/self.weekArray.count));
    }
    
    [self.weekArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineBgView = [self.turntableView viewWithTag:100+idx];
        UILabel *textLab = [lineBgView viewWithTag:1000];
        UIView *lineView = [lineBgView viewWithTag:2000];
        
        CGRect rect = [lineBgView convertRect:textLab.frame toView:self];
        if (CGRectContainsPoint(rect, self.tipsView.center)) {
            lineView.backgroundColor = textLab.textColor = [UIColor whiteColor];
        } else {
            textLab.textColor = lineView.backgroundColor = idx<2 ?[UIColor colorWithHexString:@"0xD5D5D5"]:[UIColor colorWithHexString:@"0x006241"];
        }
    }];
}

// MARK: -
// MARK: - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.caseArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //自定义item的UIEdgeInsets
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ABJourneyCaseViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell.coverImgView setImage:ImageName(@"hour_tus_dd")];
    return cell;
}

// MARK: -
// MARK: - UIScrollViewDelegate

//手指拖动开始
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.m_dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.m_dragEndX = scrollView.contentOffset.x;
    DLog(@"%f %f",self.m_dragStartX,self.m_dragEndX);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.m_currentIndex == [self.caseArray count]/4*3) {
        NSIndexPath *path  = [NSIndexPath indexPathForItem:[self.caseArray count]/2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.m_currentIndex = [self.caseArray count]/2;
    }
    else if(self.m_currentIndex == [self.caseArray count]/4){
        NSIndexPath *path = [NSIndexPath indexPathForItem:[self.caseArray count]/2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.m_currentIndex = [self.caseArray count]/2;
    }
}

// MARK: actions
- (void)lockBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(journey_unlockFuncAction:)]) {
        [self.delegate journey_unlockFuncAction:sender];
    }
}

- (void)taskBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(journey_taskFuncAction:)]) {
        [self.delegate journey_taskFuncAction:sender];
    }
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_BOLD(26);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self addSubview:_titleLab];
        _titleLab.frame = CGRectMake(16, kScreenHeight*68.f/812.f, kScreenWidth-16*2, 28);
    }
    return _titleLab;
}

- (UIButton *)bloomBtn {
    if (!_bloomBtn) {
        _bloomBtn = UIButton.new;
        [self addSubview:_bloomBtn];
        _bloomBtn.frame = CGRectMake(kScreenWidth-85-28, kScreenHeight*68.f/812.f, 85, 33);
        [_bloomBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _bloomBtn.backgroundColor = [UIColor colorWithHexString:@"0x8FEFB2"];
        _bloomBtn.titleLabel.font = FONT_BOLD(14);
        ViewRadius(_bloomBtn, 5);
    }
    return _bloomBtn;
}

- (ABTurntableView *)turntableView {
    if (!_turntableView) {
        _turntableView = [[ABTurntableView alloc] initWithFrame:CGRectMake((kScreenWidth-ratioH(320))/2, 0, ratioH(320), ratioH(320))];
        [self addSubview:_turntableView];
        _turntableView.center = self.center;
        _turntableView.delegate = self;
    }
    return _turntableView;
}

- (UIButton *)lockBtn {
    if (!_lockBtn) {
        _lockBtn = UIButton.new;
        [self addSubview:_lockBtn];
        [_lockBtn addTarget:self action:@selector(lockBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _lockBtn.frame = CGRectMake(0, 0, ratioH(50), ratioH(50));
    }
    return _lockBtn;
}

- (UIButton *)taskBtn {
    if (!_taskBtn) {
        _taskBtn = UIButton.new;
        [self addSubview:_taskBtn];
        [_taskBtn addTarget:self action:@selector(taskBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _taskBtn.frame = CGRectMake(27, self.collectionView.bottom+ratioH(32), ratioH(40), ratioH(40));
    }
    return _taskBtn;
}
@end
