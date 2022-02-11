//
//  ABMyJournalCell.m
//  UniversalApp
//
//  Created by Baypac on 2022/1/4.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABMyJournalCell.h"
#import "KFTScratchableLatexView.h"

@interface ABMyJournalCell()
@property (nonatomic ,strong)UIImageView *headImgView;
@property (nonatomic ,strong)UILabel *nameLab;
@property (nonatomic ,strong)UILabel *timeLab;
@property (nonatomic ,strong)UILabel *contentLab;
@property (nonatomic ,strong)UIButton *showMoreBtn;
@property (nonatomic ,strong)KFTScratchableLatexView *scratchableLatexView;

@property (nonatomic ,strong)UIView *photoBgView;
@property (nonatomic ,strong)UILabel *weekDayLab;
@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UIView *bottomBgView;
@property (nonatomic ,strong)UIButton *likeBtn;
@property (nonatomic ,strong)UIButton *giftBtn;
@property (nonatomic ,strong)UIButton *downloadBtn;
@property (nonatomic ,strong)UIButton *moreBtn;
@property (nonatomic ,strong)UIView *cellLineView;
@property (nonatomic ,strong)UIView *logoView;
@property (nonatomic ,strong)UIView *logoLineView;
@end

@implementation ABMyJournalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

// MARK: 初始化UI
-(void)initUI{
    ViewRadius(self.logoView, 15/2);
    self.logoLineView.backgroundColor = [UIColor colorWithHexString:@"0x026040"];
}

// MARK: Data
- (void)setModel:(ABTrentModel *)model {
    _model = model;
    
    //设置数据
    self.headImgView.backgroundColor = KRedColor;
    ViewRadius(self.headImgView, 20);
    self.nameLab.text = @"14:24   11/17/2021";
    self.timeLab.text = @"14:24   11/17/2021";
    self.contentLab.text = model.content;
    [self.showMoreBtn setTitle:@"Show more" forState:UIControlStateNormal];
    
    //后续布局需执行layoutIfNeeded获取masony布局的数据
    [self layoutIfNeeded];
    //伪四宫格布局
    [self quadGridLayout];

    //九宫格下面设备数据模块
    [self deviceDataLayout];
    
    //底部功能按钮布局
    [self bottomFunctionalAreaLayout];
    
    //内容行展示更多逻辑
    [self theContentLineShowsMoreLogic];
}

// 布局更新
- (void)updateLayoutLogic {
    if (ValidStr(_model.content)) {
        
    } else {
        
    }
}

// MARK: 业务逻辑拆解
//内容行展示更多逻辑
- (void)theContentLineShowsMoreLogic {
    [self.contentLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(10);
        make.left.equalTo(self.headImgView.mas_right).offset(9);
        make.right.mas_equalTo(-17);
    }];
    [self layoutIfNeeded];
    
    if (!ValidStr(_model.content)) {
        self.showMoreBtn.hidden = YES;
        if (_model.images.count == 0) {
            self.photoBgView.top = 46;
            self.bottomBgView.top = self.photoBgView.bottom;
        } else {
            self.scratchableLatexView.top = 46;
            self.photoBgView.top = self.scratchableLatexView.bottom;
            self.bottomBgView.top = self.photoBgView.bottom;
        }
    }
    
    if (ValidStr(_model.content)) {
        CGSize contentLabSize = [self.contentLab.text boundingRectWithSize:CGSizeMake(self.contentLab.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.contentLab.font} context:nil].size;
        if (contentLabSize.height <= FONT_REGULAR(15).lineHeight*3) {
            self.showMoreBtn.hidden = YES;
            if (_model.images.count == 0) {
                self.photoBgView.top = self.contentLab.bottom+8;
                self.bottomBgView.top = self.photoBgView.bottom;
            } else {
                self.scratchableLatexView.top = self.contentLab.bottom+8;
                self.photoBgView.top = self.scratchableLatexView.bottom;
                self.bottomBgView.top = self.photoBgView.bottom;
            }
        }
        
        if (contentLabSize.height > FONT_REGULAR(15).lineHeight*3) {

            NSInteger  conLabNum = [@(self.contentLab.height / self.contentLab.font.lineHeight) integerValue];
            NSInteger  contentNum = [@(contentLabSize.height / self.contentLab.font.lineHeight) integerValue];
            self.showMoreBtn.hidden = (contentNum > conLabNum) ? NO : YES;
            if (!self.showMoreBtn.hidden) {
                if (_model.images.count == 0) {
                    self.photoBgView.top = self.contentLab.bottom+34;
                    self.bottomBgView.top = self.photoBgView.bottom;
                } else {
                    self.scratchableLatexView.top = self.contentLab.bottom+34;
                    self.photoBgView.top = self.scratchableLatexView.bottom;
                    self.bottomBgView.top = self.photoBgView.bottom;
                }
            }
            
            if (self.showMoreBtn.hidden) {
                if (_model.images.count == 0) {
                    self.photoBgView.top = self.contentLab.bottom+8;
                    self.bottomBgView.top = self.photoBgView.bottom;
                } else {
                    self.scratchableLatexView.top = self.contentLab.bottom+8;
                    self.photoBgView.top = self.scratchableLatexView.bottom;
                    self.bottomBgView.top = self.photoBgView.bottom;
                }
            }
        }
    }
}

// 伪四宫格布局
- (void)quadGridLayout {
    [self.scratchableLatexView removeAllSubviews];
    NSInteger cols = 0;
    CGFloat itemH = 0;
    CGFloat rowMargin = 0;
    if (_model.images.count == 0) {
        cols = 0;
        itemH = 0;
        rowMargin = 0;
    } else if (_model.images.count == 1){
        cols = 1;
        itemH = 220;
        rowMargin = 0;
        _scratchableLatexView.cols = cols;
        _scratchableLatexView.colMargin = 0;
        _scratchableLatexView.rowMargin = 0;
        _scratchableLatexView.itemWidth = kScreenWidth - 65 - 16;
        _scratchableLatexView.itemHeight = 220;
    } else if (_model.images.count == 2){
        cols = 2;
        itemH = 107;
        rowMargin = 6;
    } else if (_model.images.count == 3){
        cols = 2;
        itemH = 107;
        rowMargin = 6;
        _scratchableLatexView.cols = 2;
        _scratchableLatexView.colMargin = 6;
        _scratchableLatexView.rowMargin = 6;
        _scratchableLatexView.itemWidth = ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols;
        _scratchableLatexView.itemHeight = (107*2) / 2.0;
    } else {
        cols = 2;
        itemH = 107;
        rowMargin = 6;
    }
    NSMutableArray *images = NSMutableArray.array;
    [_model.images enumerateObjectsUsingBlock:^(ABTrentImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ABTrentImageModel *model = _model.images[idx];
        [images addObject:model.imageUrl];
    }];
    
    CGFloat height = [KFTScratchableLatexView exeCalculationHeightWithCount:_model.images.count cols:cols itemH:itemH rowMargin:rowMargin];
    self.scratchableLatexView.frame= CGRectMake(65, 0, kScreenWidth-65-16, height);
    [_model.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *imgView = [UIImageView new];
        imgView.userInteractionEnabled = YES;
        imgView.tag = idx;
        [imgView sd_setImageWithURL:[NSURL URLWithString:images[idx]] placeholderImage:ImageName(@"bgt")];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [HUPhotoBrowser showFromImageView:imgView withURLStrings:images placeholderImage:ImageName(@"bgt") atIndex:imgView.tag dismiss:nil];
        }];
        [imgView addGestureRecognizer:tap];
        
        // -------------特殊情况的边界处理1-----------
        if (_model.images.count == 3 && idx==0) {
           _scratchableLatexView.itemHeight = 107*2+6;
           if (idx==0) [imgView addRoundedCorners:UIRectCornerTopLeft withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols, (107*2)+6)];
       }
        if (_model.images.count == 1) [imgView addRoundedCorners:UIRectCornerTopLeft | UIRectCornerTopRight withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, kScreenWidth - 65-16, (107*2)+6)];
        if (_model.images.count!=1 && !(_model.images.count == 3 && idx==0)) {
            if (idx==0) [imgView addRoundedCorners:UIRectCornerTopLeft withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols, (107*2) / 2.0)];
            if (idx==1) [imgView addRoundedCorners:UIRectCornerTopRight withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols, (107*2) / 2.0)];
            _scratchableLatexView.cols = 2;
            _scratchableLatexView.colMargin = 6;
            _scratchableLatexView.rowMargin = 6;
            _scratchableLatexView.itemWidth = ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols;
            _scratchableLatexView.itemHeight = (107*2) / 2.0;
        }
        // -------------特殊情况的边界处理1-----------
        
        [self.scratchableLatexView prepare];
        [self.scratchableLatexView addCustomSubview:imgView];
        // -------------特殊情况的边界处理2-----------
        if (_model.images.count == 3 && idx==2) imgView.left = ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols+6;
        // -------------特殊情况的边界处理2-----------
    }];
}

// 九宫格下面设备数据模块
- (void)deviceDataLayout {
    [self.photoBgView removeAllSubviews];
    [self.photoBgView addSubview:self.weekDayLab];
    [self.weekDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.left.equalTo(12);
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(-12);
    }];
    
    self.photoBgView.backgroundColor = KWhiteColor;
    [self.photoBgView addRoundedCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight withRadii:CGSizeMake(10, 10) viewRect:CGRectMake(0, 0, kScreenWidth-64-16, 83)];
    self.weekDayLab.text = @"2 Week  7/12 day ";
    self.lineView.backgroundColor = kLineColor;
    
    NSArray *array = @[@"66mm",@"120F",@"110F",@"73%"];
    NSArray *imageArray = @[@"icon_16_c_n",@"icon_16_w_n",@"icon_16_s_n",@"icon_16_x_n"];
    NSMutableArray *mArray = [NSMutableArray array];
    [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:ImageName(imageArray[idx]) forState:UIControlStateNormal];
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"0x161B19"] forState:UIControlStateNormal];
        btn.titleLabel.font = FONT_MEDIUM(11);
        [self.photoBgView addSubview:btn];
        [mArray addObject:btn];
        
    }];
    [mArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:12 tailSpacing:12];
    [mArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@43);
        make.height.equalTo(40);
    }];
}

// 底部功能按钮布局
- (void)bottomFunctionalAreaLayout {
    self.bottomBgView.backgroundColor = [UIColor clearColor];
    [self.likeBtn setTitle:@"7213" forState:UIControlStateNormal];
    [self.giftBtn setTitle:@"4236" forState:UIControlStateNormal];
    [self.downloadBtn setImage:ImageName(@"icon_28_gift_share") forState:UIControlStateNormal];
    [self.moreBtn setImage:ImageName(@"icon_28_more") forState:UIControlStateNormal];
    self.cellLineView.backgroundColor = kLineColor;
}

// MARK: actions
- (void)showMoreBtnAction:(UIButton *)sender {
    self.showMoreBtn.hidden = YES;
    self.contentLab.numberOfLines = 0;
    [self theContentLineShowsMoreLogic];
    if ([self.delegate respondsToSelector:@selector(myJournal_updeteCellHeight:)]) {
        [self.delegate myJournal_updeteCellHeight:sender];
    }
}

- (void)bottomFuncAreaAction:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            if ([self.delegate respondsToSelector:@selector(myJournal_LikeAction:)]) {
                [self.delegate myJournal_LikeAction:sender];
            }
            break;
        case 101:
            if ([self.delegate respondsToSelector:@selector(myJournal_giftAction:)]) {
                [self.delegate myJournal_giftAction:sender];
            }
            break;
        case 102:
            if ([self.delegate respondsToSelector:@selector(myJournal_downloadAction:)]) {
                [self.delegate myJournal_downloadAction:sender];
            }
            break;
        case 103:
            if ([self.delegate respondsToSelector:@selector(myJournal_moreAction:)]) {
                [self.delegate myJournal_moreAction:sender];
            }
            break;
    }
}

- (void)deviceDataPopAction:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(myJournal_deviceDataPopAction:)]) {
        [self.delegate myJournal_deviceDataPopAction:tap];
    }
}

// MARK: Lazy loading
- (UIImageView *)headImgView {
    if (!_headImgView) {
        _headImgView = [UIImageView new];
        _headImgView.hidden = YES;
        [self addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(19);
            make.left.mas_equalTo(13);
            make.width.height.mas_equalTo(40);
        }];
    }
    return _headImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = FONT_BOLD(16);
        _nameLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        [self addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(19);
            make.left.equalTo(self.headImgView.mas_right).offset(9);
            make.height.mas_equalTo(21);
        }];
    }
    return _nameLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [UILabel new];
        _timeLab.font = FONT_REGULAR(13);
        _timeLab.textColor = [UIColor colorWithHexString:@"0xC9C9C9"];
        [self addSubview:_timeLab];
        _timeLab.hidden = YES;
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(21);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(17);
        }];
    }
    return _timeLab;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [UILabel new];
        _contentLab.font = FONT_REGULAR(15);
        _contentLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
        _contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLab.numberOfLines = 3;
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLab.mas_bottom).offset(10);
            make.left.equalTo(self.headImgView.mas_right).offset(9);
            make.right.mas_equalTo(-17);
        }];
    }
    return _contentLab;
}

- (UIButton *)showMoreBtn {
    if (!_showMoreBtn) {
        _showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_showMoreBtn];
        [_showMoreBtn setTitleColor:[UIColor colorWithHexString:@"0x006241"] forState:UIControlStateNormal];
        _showMoreBtn.titleLabel.font = FONT_MEDIUM(15);
        _showMoreBtn.hidden = YES;
        [_showMoreBtn addTarget:self action:@selector(showMoreBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat showHeight = [@"Show more" getWidthWithHeight:22 Font:_showMoreBtn.titleLabel.font];
        [_showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLab.mas_bottom).offset(5);
            make.left.equalTo(self.headImgView.mas_right).offset(9);
            make.height.mas_equalTo(22);
            make.width.mas_equalTo(showHeight);
        }];
    }
    return _showMoreBtn;
}

- (KFTScratchableLatexView *)scratchableLatexView {
    if (!_scratchableLatexView) {
        _scratchableLatexView = KFTScratchableLatexView.new;
        [self addSubview:_scratchableLatexView];
        _scratchableLatexView.cols = 2;
        _scratchableLatexView.colMargin = 0;
        _scratchableLatexView.rowMargin = 0;
        _scratchableLatexView.itemWidth = ((kScreenWidth - 65-16) - 6) / _scratchableLatexView.cols;
        _scratchableLatexView.itemHeight = (107*2) / 2.0;
    }
    return _scratchableLatexView;
}


// MARK: Lazy loading----photoBgView
- (UIView *)photoBgView {
    if (!_photoBgView) {
        _photoBgView = [UIView new];
        _photoBgView.userInteractionEnabled = YES;
        [self addSubview:_photoBgView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deviceDataPopAction:)];
        [_photoBgView addGestureRecognizer:tap];
        _photoBgView.frame = CGRectMake(65, self.scratchableLatexView.bottom, kScreenWidth-65-16, 83);
    }
    return _photoBgView;
}

- (UILabel *)weekDayLab {
    if (!_weekDayLab) {
        _weekDayLab = [UILabel new];
        _weekDayLab.font = FONT_MEDIUM(11);
        _weekDayLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
    }
    return _weekDayLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
        _lineView.backgroundColor = kLineColor;
        [self.photoBgView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.weekDayLab.mas_bottom).offset(12);
            make.left.mas_equalTo(8);
            make.right.mas_equalTo(-8);
            make.height.mas_equalTo(1);
        }];
    }
    return _lineView;
}

// MARK: Lazy loading----bottomBgView
- (UIView *)bottomBgView {
    if (!_bottomBgView) {
        _bottomBgView = UIView.new;
        _bottomBgView.userInteractionEnabled = YES;
        [self addSubview:_bottomBgView];
        _bottomBgView.frame = CGRectMake(65, self.photoBgView.bottom, kScreenWidth-65, self.height-self.photoBgView.bottom);
    }
    return _bottomBgView;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = UIButton.new;
        [_likeBtn setImage:ImageName(@"icon_28_like_n") forState:UIControlStateNormal];
        [_likeBtn setImage:ImageName(@"icon_28_like_y") forState:UIControlStateSelected];
        [_likeBtn setTitleColor:[UIColor colorWithHexString:@"0x161B19"] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = FONT_MEDIUM(15);
        _likeBtn.tag = 100;
        [self.bottomBgView addSubview:_likeBtn];
        [_likeBtn addTarget:self action:@selector(bottomFuncAreaAction:) forControlEvents:UIControlEventTouchUpInside];
        [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(4);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(70);
        }];
    }
    return _likeBtn;
}

- (UIButton *)giftBtn {
    if (!_giftBtn) {
        _giftBtn = UIButton.new;
        [_giftBtn setImage:ImageName(@"icon_28_gift_n") forState:UIControlStateNormal];
        [_giftBtn setImage:ImageName(@"icon_28_gift_y") forState:UIControlStateSelected];
        [_giftBtn setTitleColor:[UIColor colorWithHexString:@"0x161B19"] forState:UIControlStateNormal];
        _giftBtn.titleLabel.font = FONT_MEDIUM(15);
        [self.bottomBgView addSubview:_giftBtn];
        [_giftBtn addTarget:self action:@selector(bottomFuncAreaAction:) forControlEvents:UIControlEventTouchUpInside];
        _giftBtn.tag = 101;
        [_giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(self.likeBtn.mas_right).offset((kScreenWidth-63-16-70*2-28*2)/3);
            make.height.mas_equalTo(28);
            make.width.mas_equalTo(70);
        }];
    }
    return _giftBtn;
}

- (UIButton *)downloadBtn {
    if (!_downloadBtn) {
        _downloadBtn = UIButton.new;
        [self.bottomBgView addSubview:_downloadBtn];
        [_downloadBtn addTarget:self action:@selector(bottomFuncAreaAction:) forControlEvents:UIControlEventTouchUpInside];
        _downloadBtn.tag = 102;
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(self.giftBtn.mas_right).offset((kScreenWidth-63-16-70*2-28*2)/3);
            make.width.height.mas_equalTo(28);
        }];
    }
    return _downloadBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = UIButton.new;
        [self.bottomBgView addSubview:_moreBtn];
        _moreBtn.tag = 103;
        [_moreBtn addTarget:self action:@selector(bottomFuncAreaAction:) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(16);
            make.left.mas_equalTo(self.downloadBtn.mas_right).offset((kScreenWidth-63-16-70*2-28*2)/3);
            make.width.height.mas_equalTo(28);
        }];
    }
    return _moreBtn;
}

- (UIView *)cellLineView {
    if (!_cellLineView) {
        _cellLineView = UIView.new;
        [self.bottomBgView addSubview:self.cellLineView];
        [_cellLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.moreBtn.mas_bottom).offset(10);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(1);
        }];
    }
    return _cellLineView;
}

- (UIView *)logoView {
    if (!_logoView) {
        _logoView = UIView.new;
        [self addSubview:_logoView];
        self.logoView.backgroundColor = [UIColor colorWithHexString:@"0x026040"];
        [_logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(19);
            make.left.mas_equalTo(27);
            make.width.height.mas_equalTo(15);
        }];
    }
    return _logoView;
}

- (UIView *)logoLineView {
    if (!_logoLineView) {
        _logoLineView = UIView.new;
        [self addSubview:_logoLineView];
        
        [_logoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(34);
            make.width.mas_equalTo(1);
        }];
    }
    return _logoLineView;
}
@end
