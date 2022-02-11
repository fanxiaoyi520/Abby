//
//  ABReportViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/31.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABReportViewController.h"

@interface ABReportViewController ()

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) YYTextView *inputTXT;
@property (nonatomic ,strong) UIView *w_lineView;
@property (nonatomic ,strong) UIView *h_lineView;

@end

@implementation ABReportViewController
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.inputTXT];
    [self.bgView addSubview:self.w_lineView];
    [self.bgView addSubview:self.h_lineView];
    
    NSArray *array = @[@"Cancel",@"OK"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = UIButton.new;
        [self.bgView addSubview:btn];
        btn.frame = CGRectMake(idx*(self.bgView.width/2-ratioW(.5)+1), self.w_lineView.bottom, self.bgView.width/2-ratioW(.5), ratioH(60));
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_REGULAR(18);
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        btn.tag = 100+idx;
        [btn addTarget:self action:@selector(btnFuncAction:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

// MARK: actions
- (void)btnFuncAction:(UIButton *)sender {
    if (sender.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        DLog(@"举报");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)keyboardChangeFrame:(NSNotification*)noti;
{
    CGRect rect= [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardheight = rect.origin.y;
    CGFloat duration=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat curve=[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]doubleValue];
    self.bgView.bottom = keyboardheight-20;
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    
}


-(void)keyboardHide:(NSNotification *)noti
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = KWhiteColor;
        _bgView.frame = CGRectMake(ratioW(47), (kScreenHeight-ratioH(288))/2, kScreenWidth-ratioW(47)*2, ratioH(288));
        [_bgView addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(15, 15)];
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.font = FONT_BOLD(16);
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.frame = CGRectMake(ratioW(16), ratioH(33), self.bgView.width-ratioW(16)*2, ratioH(24));
        _titleLab.text = @"Report";
    }
    return _titleLab;
}

- (YYTextView *)inputTXT {
    if (!_inputTXT) {
        _inputTXT = YYTextView.new;
        _inputTXT.frame = CGRectMake(ratioW(16), self.titleLab.bottom+ratioH(23), self.bgView.width-ratioW(16)*2, ratioH(124));
        [_inputTXT addRoundedCorners:UIRectCornerAllCorners withRadii:CGSizeMake(5, 5)];
        _inputTXT.placeholderText = @"Please enter your feedback";
        _inputTXT.placeholderFont = FONT_REGULAR(13);
        _inputTXT.placeholderTextColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        _inputTXT.backgroundColor = [UIColor colorWithHexString:@"0xF7F7F7"];
    }
    return _inputTXT;
}

- (UIView *)w_lineView {
    if (!_w_lineView) {
        _w_lineView = UIView.new;
        _w_lineView.backgroundColor = kLineColor;
        _w_lineView.frame = CGRectMake(0, self.inputTXT.bottom+ratioH(24), self.bgView.width, 1);
    }
    return _w_lineView;
}

- (UIView *)h_lineView {
    if (!_h_lineView) {
        _h_lineView = UIView.new;
        _h_lineView.backgroundColor = kLineColor;
        _h_lineView.frame = CGRectMake(self.bgView.width/2-ratioW(.5), self.w_lineView.bottom, 1, ratioH(59));
    }
    return _h_lineView;
}
@end
