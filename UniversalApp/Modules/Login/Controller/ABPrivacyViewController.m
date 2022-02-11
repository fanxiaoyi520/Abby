//
//  ABPrivacyViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/11/25.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABPrivacyViewController.h"
#import "XLWebViewController.h"

static NSString *conStr = @"Privacy is very important. We have updated our privacy policy to let you fully understand the situation. Before you agree to use our services, please read carefully and understand the content we provide to you. Please check 《Terms of Use and Privacy》 and 《Privacy Policy》";
@interface ABPrivacyViewController ()<UITextViewDelegate>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UITextView *contentTXT;
@end

@implementation ABPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KWhiteColor;
    [self setupUI];
}

- (void)setupUI {
    CGRect statusMattStrRect = [conStr boundingRectWithSize:CGSizeMake(kScreenWidth-ratioW(48)*2-ratioW(16)*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(13)} context:nil];
    
    [self.view addSubview:self.bgView];
    
    self.bgView.frame = CGRectMake((kScreenWidth-ratioW(281))/2, (kScreenHeight-ratioH((55+136+33+60))-((statusMattStrRect.size.height / FONT_REGULAR(13).lineHeight) * 5))/2, ratioW(281),ratioH((55+136+33+60))+(statusMattStrRect.size.height / FONT_REGULAR(13).lineHeight) * 5);
    ViewRadius(self.bgView, 25);
    
    [self.bgView addSubview:self.titleLab];
    self.titleLab.frame = CGRectMake(0, ratioH(20), self.bgView.width, ratioH(24));
    
    NSArray *btnTitleArray = @[@"Disagree",@"Agree"];
    [btnTitleArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgView addSubview:btn];
        btn.frame = CGRectMake(0+idx*(self.bgView.width/2-.5+1), self.bgView.height-ratioH(60), self.bgView.width/2-.5, ratioH(60));
        [btn setTitle:btnTitleArray[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        btn.tag = 10+idx;
        
        kWeakSelf(self)
        [btn addTapBlock:^(UIButton *btn) {
            if (btn.tag == 10) {
                [weakself dismissViewControllerAnimated:YES completion:nil];
            } else {
                [weakself dismissViewControllerAnimated:NO completion:^{
                    if ([self.delegate respondsToSelector:@selector(sureLogin)]) {
                        [self.delegate sureLogin];
                    }
                }];
            }
        }];
    }];
    
    [self.bgView addSubview:self.contentTXT];
    self.contentTXT.frame = CGRectMake((self.bgView.width-statusMattStrRect.size.width)/2, self.titleLab.bottom+ratioH(12), statusMattStrRect.size.width, statusMattStrRect.size.height+(statusMattStrRect.size.height / FONT_REGULAR(13).lineHeight) * 5);
    
    UIView *w_lineView = UIView.new;
    w_lineView.backgroundColor = kLineColor;
    [self.bgView addSubview:w_lineView];
    w_lineView.frame = CGRectMake(0, self.bgView.height-ratioH(60), self.bgView.width, 1);
    
    UIView *h_lineView = UIView.new;
    [self.bgView addSubview:h_lineView];
    h_lineView.backgroundColor = kLineColor;
    h_lineView.frame = CGRectMake(self.bgView.width/2-.5, w_lineView.bottom, 1, ratioH(60));
    
    [self agreementSetupHanle];
}

- (void)agreementSetupHanle {
    NSString *agreementMessage = self.contentTXT.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:agreementMessage];
    
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"2"
                             range:[[attributedString string] rangeOfString:@"《Terms of Use and Privacy》"]];
    [attributedString addAttribute:NSLinkAttributeName
                             value:@"3"
                             range:[[attributedString string] rangeOfString:@"《Privacy Policy》"]];
    [attributedString addAttribute:NSFontAttributeName value:FONT_REGULAR(13) range:[[attributedString string] rangeOfString:agreementMessage]];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x000000"] range:[[attributedString string] rangeOfString:agreementMessage]];
    self.contentTXT.linkTextAttributes = @{ NSForegroundColorAttributeName: [UIColor colorWithHexString:@"0x00BAFF"],
                                                  NSUnderlineColorAttributeName: [UIColor clearColor],
                                                  NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};

    // 设置间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[[attributedString string] rangeOfString:agreementMessage]];
    paragraphStyle.lineSpacing = 5;
    self.contentTXT.attributedText = attributedString;
}

// MARK: UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    [self dismissViewControllerAnimated:NO completion:^{
        if ([URL.absoluteString  isEqualToString:@"2"]) {
            if ([self.delegate respondsToSelector:@selector(openUrlWithTypeStr:)]) {
                [self.delegate openUrlWithTypeStr:@"Privacy policy"];
            }
        }
        if ([URL.absoluteString  isEqualToString:@"3"]) {
            if ([self.delegate respondsToSelector:@selector(openUrlWithTypeStr:)]) {
                [self.delegate openUrlWithTypeStr:@"User agreement"];
            }
        }
    }];
    return YES;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

// MARK: Lazy loading
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor colorWithHexString:@"0x000000"];
        _titleLab.font = FONT_BOLD(16);
        _titleLab.text = @"Term of Use & Privacy Policy";
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UITextView *)contentTXT {
    if (!_contentTXT) {
        _contentTXT = [[UITextView alloc] init];
        _contentTXT.text = conStr;
        _contentTXT.textColor = [UIColor colorWithHexString:@"0x000000"];
        _contentTXT.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _contentTXT.textContainer.lineFragmentPadding = 0;
        _contentTXT.showsVerticalScrollIndicator = NO;
        _contentTXT.scrollEnabled = NO;
        _contentTXT.editable = NO;
        _contentTXT.font = FONT_REGULAR(13);
        _contentTXT.backgroundColor = KWhiteColor;
        _contentTXT.delegate = self;
    }
    return _contentTXT;
}
@end
