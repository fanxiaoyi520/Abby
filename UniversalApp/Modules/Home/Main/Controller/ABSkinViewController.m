//
//  ABSkinViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/17.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABSkinViewController.h"

@interface ABSkinViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIImageView *logoImgView;
@property (nonatomic ,strong) UILabel *logoLab;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation ABSkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = [NSArray arrayWithObjects:@"hour_tus_dd",@"hour_tus_dd",@"hour_tus_dd",@"hour_tus_dd", nil];
    for (int i=0; i<3; i++) {
        [self.imageArray addObjectsFromArray:array];
    }
    DLog(@"%@",self.imageArray);
    [self setupUI];
}

- (void)setupUI {
    self.bgView.frame = CGRectMake(0, kScreenHeight-297, kScreenWidth, 297);
    [self.bgView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(19, 19)];
    self.closeBtn.frame = CGRectMake(kScreenWidth-24-24, 24, 24, 24);
    self.logoImgView.frame = CGRectMake(25, 0, self.logoImgView.image.size.width, self.logoImgView.image.size.height);
    self.logoImgView.centerY = self.closeBtn.centerY;
    self.logoLab.frame = CGRectMake(self.logoImgView.right+8, 25, kScreenWidth-56-24*2, 21);

    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, ratioH(160))];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0;
    pageFlowView.isCarousel = NO;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    pageFlowView.backgroundColor = KWhiteColor;
    
    [pageFlowView reloadData];
    [self.bgView addSubview:pageFlowView];
    [pageFlowView scrollToPage:2];
}

// MARK: actions
- (void)closeBtnAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ratioW(100), ratioH(120));
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    NSLog(@"ViewController 滚动到了第%ld页",pageNumber);
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.imageArray.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.backgroundColor = KWhiteColor;
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 10;
        bannerView.layer.masksToBounds=NO;
        bannerView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.07].CGColor;
        bannerView.layer.shadowOffset = CGSizeMake(0,0);
        bannerView.layer.shadowOpacity = 1;
        bannerView.layer.shadowRadius = 4;
    }
    //在这里下载网络图片
    //  [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = ImageName(self.imageArray[index]);
    
    return bannerView;
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KWhiteColor;
        [self.view addSubview:_bgView];
    }
    return _bgView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        [_closeBtn setImage:ImageName(@"icon_t_closure") forState:UIControlStateNormal];
        [self.bgView addSubview:_closeBtn];
        [_closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIImageView *)logoImgView {
    if (!_logoImgView) {
        _logoImgView = UIImageView.new;
        [self.bgView addSubview:_logoImgView];
        _logoImgView.image = ImageName(@"icon_h_skin-1");
    }
    return _logoImgView;
}

- (UILabel *)logoLab {
    if (!_logoLab) {
        _logoLab = UILabel.new;
        _logoLab.font = FONT_BOLD(16);
        _logoLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        [self.bgView addSubview:_logoLab];
        _logoLab.text = @"Skin";
    }
    return _logoLab;
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
@end
