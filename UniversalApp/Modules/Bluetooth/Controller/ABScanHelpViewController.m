//
//  ABScanHelpViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABScanHelpViewController.h"
#import "ABResetDeviceViewController.h"

@interface ABScanHelpViewController ()

@property (nonatomic ,strong) UIImageView *headImg;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UILabel *folLab;
@property (nonatomic ,strong) UITextView *opinionTXT;
@property (nonatomic ,strong) UIButton *tryAgainBtn;
@property (nonatomic ,strong) UIButton *resetDeviceBtn;
@end

@implementation ABScanHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"0xFBFFFD"];
    
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = NO;
    [self addNavigationItemWithTitles
     :@[@"Cancel"] isLeft:YES target:self action:@selector(naviBtnClick:) tags:@[@1000]];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.headImg];
    self.headImg.frame = CGRectMake(26, 39, kScreenWidth-26*2, (kScreenWidth-26*2)*200/323);
    self.headImg.image = ImageName(@"pic_finddevice");
    [UIView jaf_cutOptionalFillet:self.headImg byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    
    [self.view addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(26, self.headImg.bottom+27, kScreenWidth-26*2, 24);
    
    [self.view addSubview:self.folLab];
    self.folLab.frame = CGRectMake(26, self.tipsLab.bottom+34, kScreenWidth-26*2, 36);
    
    CGRect opinionTXTRect = [self.opinionTXT.text boundingRectWithSize:CGSizeMake(kScreenWidth-26*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil];
    [self.view addSubview:self.opinionTXT];
    self.opinionTXT.frame = CGRectMake(26, self.folLab.bottom+12, kScreenWidth-26*2, opinionTXTRect.size.height);
    
    [self.view addSubview:self.tryAgainBtn];
    self.tryAgainBtn.frame = CGRectMake(26, kScreenHeight-CONTACTS_HEIGHT_NAV-154-CONTACTS_SAFE_BOTTOM, kScreenWidth-26*2, 60);
    [UIView jaf_cutOptionalFillet:self.tryAgainBtn byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(30, 30)];

    kWeakSelf(self)
    [self.tryAgainBtn addTapBlock:^(UIButton *btn) {
        [[ABGlobalNotifyServer sharedServer] postResetDevice];
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:self.resetDeviceBtn];
    self.resetDeviceBtn.frame = CGRectMake(26, self.tryAgainBtn.bottom+21, kScreenWidth-26*2, 18);

    [self.resetDeviceBtn addTapBlock:^(UIButton *btn) {
        ABResetDeviceViewController *vc = [ABResetDeviceViewController new];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}

// MARK: actions
- (void)naviBtnClick:(UIButton *)btn {
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"ABAddDeviceViewController")]) [self.navigationController popToViewController:obj animated:YES];
    }];
}

// MARK: Lazy loading
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
    }
    return _headImg;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _tipsLab.font = FONT_MEDIUM(15);
        _tipsLab.text = @"Can't find your device currently";
    }
    return _tipsLab;
}

- (UILabel *)folLab {
    if (!_folLab) {
        _folLab = [UILabel new];
        _folLab.textColor = [UIColor colorWithHexString:@"0x006241"];
        _folLab.font = FONT_MEDIUM(25);
        _folLab.text = @"You can do the following";
    }
    return _folLab;
}

- (UITextView *)opinionTXT {
    if (!_opinionTXT) {
        _opinionTXT = [[UITextView alloc] init];
        _opinionTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        _opinionTXT.font = FONT_REGULAR(15);
        _opinionTXT.text = @"1. Make sure that the phone's Bluetooturned\n2.Place the phone close to the device and pair it again.\n3. Reset and reconnect the device.";
        _opinionTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        _opinionTXT.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _opinionTXT.textContainer.lineFragmentPadding = 0;
        _opinionTXT.showsVerticalScrollIndicator = NO;
        _opinionTXT.scrollEnabled = NO;
        _opinionTXT.editable = NO;
        _opinionTXT.backgroundColor = [UIColor clearColor];
    }
    return _opinionTXT;
}

- (UIButton *)tryAgainBtn {
    if (!_tryAgainBtn) {
        _tryAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tryAgainBtn setTitle:@"Try again" forState:UIControlStateNormal];
        [_tryAgainBtn setTitleColor:[UIColor colorWithHexString:@"0xFFFFFF"] forState:UIControlStateNormal];
        _tryAgainBtn.titleLabel.font = FONT_MEDIUM(18);
        _tryAgainBtn.backgroundColor = [UIColor colorWithHexString:@"0x006241"];
    }
    return _tryAgainBtn;
}

- (UIButton *)resetDeviceBtn {
    if (!_resetDeviceBtn) {
        _resetDeviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetDeviceBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _resetDeviceBtn.titleLabel.font = FONT_MEDIUM(15);
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Reset Device"];
        NSRange strRange = {0,str.length};
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x006241"] range:NSMakeRange(0, 2)];
        [_resetDeviceBtn setAttributedTitle:str forState:UIControlStateNormal];
    }
    return _resetDeviceBtn;
}
@end
