//
//  ABResetDeviceViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABResetDeviceViewController.h"

@interface ABResetDeviceViewController ()

@property (nonatomic ,strong) UILabel * titleLab;
@property (nonatomic ,strong) UITextView * contentTXT;
@property (nonatomic ,strong) LOTAnimationView * tipsLogo;
@property (nonatomic ,strong) UIButton * sureBtn;
@property (nonatomic ,strong) UILabel * tipsLab;
@property (nonatomic ,strong) UIImageView * selImg;
@property (nonatomic ,strong) UIButton * nextBtn;
@end

@implementation ABResetDeviceViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tipsLogo play];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tipsLogo pause];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self addNavigationItemWithImageNames:@[@"back_icon"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@2000,@2001]];
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    self.navTitle = @"Reset Device";
    [self setupUI];
}

- (void)setupUI {
    
    [self.view addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(26, 40, kScreenWidth-26*2, 36);
    
    CGRect opinionTXTRect = [self.contentTXT.text boundingRectWithSize:CGSizeMake(kScreenWidth-26*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    [self.view addSubview:self.contentTXT];
    self.contentTXT.frame = CGRectMake(26, self.titleLab.bottom+8, kScreenWidth-26*2, opinionTXTRect.size.height);
    
    [self.view addSubview:self.tipsLogo];
    self.tipsLogo.frame = CGRectMake(26, self.contentTXT.bottom+8, kScreenWidth-26*2, 200);
    [UIView jaf_cutOptionalFillet:self.tipsLogo byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    
    [self.view addSubview:self.sureBtn];
    self.sureBtn.frame = CGRectMake(20, self.tipsLogo.bottom, kScreenWidth-20*2, 58);
    
    [self.sureBtn addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(6, 20, 200, 19);
    
    [self.sureBtn addSubview:self.selImg];
    self.selImg.frame = CGRectMake(self.sureBtn.width-24-8, 16, 24, 24);
    [self.sureBtn addTarget:self action:@selector(selAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextBtn];
    self.nextBtn.frame = CGRectMake(26, kScreenHeight-154-CONTACTS_HEIGHT_NAV-CONTACTS_SAFE_BOTTOM, kScreenWidth-26*2, 60);
    [UIView jaf_cutOptionalFillet:self.nextBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];
    [self.nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selAction:(UIButton *)sender {
    sender.selected = self.nextBtn.selected = !self.nextBtn.selected;
    if (self.nextBtn.selected) {
        self.selImg.image = ImageName(@"Controls Small_Checkboxes_Ok_1");
        self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    } else {
        self.selImg.image = ImageName(@"Controls Small_Checkboxes_Ok");
        self.nextBtn.backgroundColor = [UIColor colorWithHexString:@"0xC8C8C8"];
    }
}

- (void)nextAction {
    if (!self.nextBtn.selected) {
        [UIViewController jaf_showHudTip:@"You need to confirm before you can click"];
        return;
    }

    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"ABBluetoothSearchViewController")]) {
            [[ABGlobalNotifyServer sharedServer] postResetDevice];
            [self.navigationController popToViewController:obj animated:YES];
        }
    }];
}

// MARK: Lazy loading
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.font = FONT_MEDIUM(24);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _titleLab.text = @"Reset instructions";
    }
    return _titleLab;
}

- (UITextView *)contentTXT {
    if (!_contentTXT) {
        _contentTXT = [[UITextView alloc] init];
        _contentTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentTXT.font = FONT_REGULAR(15);
        _contentTXT.text = @"Lorem ipsum dolor sit amet, consectetuipiscing elit. Aenean euismod bibendumreet. Proiravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar sic tempor.";
        _contentTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentTXT.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _contentTXT.textContainer.lineFragmentPadding = 0;
        _contentTXT.showsVerticalScrollIndicator = NO;
        _contentTXT.scrollEnabled = NO;
        _contentTXT.editable = NO;
        _contentTXT.backgroundColor = [UIColor clearColor];
    }
    return _contentTXT;
}

- (LOTAnimationView *)tipsLogo {
    if (!_tipsLogo) {
        _tipsLogo = [LOTAnimationView animationNamed:@"ab_reset_device_datachongzhi"];
        _tipsLogo.contentMode = UIViewContentModeScaleAspectFill;
        _tipsLogo.loopAnimation = YES;
    }
    return _tipsLogo;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor clearColor];
        _sureBtn.selected = NO;
    }
    return _sureBtn;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.font = FONT_MEDIUM(16);
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _tipsLab.text = @"Operation confirmed";
    }
    return _tipsLab;
}

- (UIImageView *)selImg {
    if (!_selImg) {
        _selImg = [UIImageView new];
        _selImg.image = ImageName(@"Controls Small_Checkboxes_Ok");
    }
    return _selImg;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = [UIColor colorWithHexString:@"0xC8C8C8"];
        [_nextBtn setTitle:@"Next" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        _nextBtn.selected = NO;
    }
    return _nextBtn;
}
@end
