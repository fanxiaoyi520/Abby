//
//  ABShareViewController.m
//  UniversalApp
//
//  Created by Baypac on 2022/2/15.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABShareViewController.h"

@interface ABShareViewController ()
@property (nonatomic ,strong) UIScrollView *scrollow;
@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic ,strong) UIImage *image;
@property (nonatomic ,strong) UIView *bgView;
@end

@implementation ABShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.shareView];
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.scrollow];
    [self.scrollow addSubview:self.imgView];
    
    NSArray *arr = @[@"Cancel",@"Save"];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        btn.tag = 100 + idx;
        [btn setTitle:arr[idx] forState:UIControlStateNormal];
        [self.bgView addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(26+idx*((kScreenWidth-26*2)/2), 40, (kScreenWidth-26*2)/2, 60);
        btn.backgroundColor = [UIColor colorWithHexString:@"0x006D48"];
        [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(18);
        if (idx==0) [btn addRoundedCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft  withRadii:CGSizeMake(30, 30)];
        if (idx==1) [btn addRoundedCorners:UIRectCornerTopRight | UIRectCornerBottomRight  withRadii:CGSizeMake(30, 30)];
        
        UIView *lineView = UIView.new;
        lineView.frame = CGRectMake(26+((kScreenWidth-26*2)/2)-.5, 40+20, 1, 20);
        [self.bgView addSubview:lineView];
        lineView.backgroundColor = KWhiteColor;
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.image = [UIImage getCurrentScrollviewShot:self.shareView];
    [self.shareView removeFromSuperview];

    [MBProgressHUD showActivityMessageInView:@"Generating pictures..."];
    CGImageRef cgref = [self.image CGImage];
    CIImage *cim = [self.image CIImage];
    if (cim == nil && cgref == NULL)
    {
        [MBProgressHUD hideHUD];
        [self dismissViewControllerAnimated:YES completion:^{
            [UIViewController jaf_showHudTip:@"Picture generation failed"];
        }];
    } else {
        [MBProgressHUD hideHUD];
        self.imgView.image = self.image;
        self.imgView.height = self.imgView.width * self.image.size.height / self.image.size.width;
        self.scrollow.contentSize = CGSizeMake(kScreenWidth, 80+self.imgView.height+20);
    }
}

- (void)btnAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    [self dismissViewControllerAnimated:YES completion:^{
        NSString *msg = nil ;
        if(error){
            msg = @"Failed to save picture" ;
            [UIViewController jaf_showHudTip:msg];
        }else{
            msg = @"Picture saved successfully";
            [UIViewController jaf_showHudTip:msg];
        }
    }];
}

- (ABShareView *)shareView {
    if (!_shareView) {
        _shareView = [[ABShareView alloc] initWithFrame:CGRectMake(38, 80, kScreenWidth-38*2, kScreenHeight-158-80)];
        _shareView.showsVerticalScrollIndicator = NO;
        _shareView.showsHorizontalScrollIndicator = NO;
        _shareView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*2);
        [_shareView loadData:nil];
    }
    return _shareView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KWhiteColor;
        _bgView.frame = CGRectMake(0, kScreenHeight-158, kScreenWidth, 158);
        [_bgView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(19, 19)];
    }
    return _bgView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.frame = CGRectMake(38, 80, kScreenWidth-38*2, 0);
        _imgView.userInteractionEnabled = YES;
    }
    return _imgView;
}

- (UIScrollView *)scrollow {
    if (!_scrollow) {
        _scrollow = UIScrollView.new;
        _scrollow.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-158);
    }
    return _scrollow;
}
@end
