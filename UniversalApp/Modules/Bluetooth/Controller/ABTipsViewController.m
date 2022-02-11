//
//  ABTipsViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/30.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABTipsViewController.h"
#import "ABResetDeviceViewController.h"

@interface ABTipsViewController ()
@property (nonatomic ,strong) UIImageView *headImg;
@property (nonatomic ,strong) UILabel *tipsLab;
@property (nonatomic ,strong) UIButton *resetDeviceBtn;

@end

@implementation ABTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidenNaviBar = NO;
    self.isShowLiftBack = YES;
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.tipsLab];
    self.tipsLab.frame = CGRectMake(26, 39, kScreenWidth-26*2, 24);
    
    [self.view addSubview:self.headImg];
    self.headImg.frame = CGRectMake(26, self.tipsLab.bottom+30, kScreenWidth-26*2, 200);
    
    [self.view addSubview:self.resetDeviceBtn];
    self.resetDeviceBtn.frame = CGRectMake(26, self.headImg.bottom+40, kScreenWidth-26*2, 18);

    kWeakSelf(self)
    [self.resetDeviceBtn addTapBlock:^(UIButton *btn) {
        ABResetDeviceViewController *vc = [ABResetDeviceViewController new];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
}

// MAKR: Lazy loading
- (UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [UIImageView new];
        _headImg.backgroundColor = [UIColor redColor];
    }
    return _headImg;
}

- (UILabel *)tipsLab {
    if (!_tipsLab) {
        _tipsLab = [UILabel new];
        _tipsLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _tipsLab.font = FONT_MEDIUM(15);
        _tipsLab.text = @"The device has been bound to account.";
    }
    return _tipsLab;
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
