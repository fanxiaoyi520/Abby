//
//  ABChangeWaterViewController.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABChangeWaterViewController.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"

@interface ABChangeWaterViewController ()<YSLDraggableCardContainerDataSource,YSLDraggableCardContainerDelegate>

@property (nonatomic, strong) YSLDraggableCardContainer *container;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation ABChangeWaterViewController

- (void)viewDidLoad {
    [self superConfigure];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)superConfigure {
    self.bg_Height = kScreenHeight-92;
    self.btn_bg_Color = @"0x006241";
    self.btn_Title = @"Tube placed in bucket";
    self.isLeft = NO;
    self.btn_Title = @"Confirm";
}

- (void)setupUI {
    self.contentLab.hidden = YES;
    self.sureBtn.hidden = YES;
    _container = [[YSLDraggableCardContainer alloc]init];
    _container.frame = CGRectMake(0, 68, kScreenWidth, self.bgView.height-68);
    _container.backgroundColor = [UIColor clearColor];
    _container.dataSource = self;
    _container.delegate = self;
    _container.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight;
    [self.bgView addSubview:_container];
    
    [self loadData];
    [_container reloadCardContainer];
    
    UILabel *tipsLab = [UILabel new];
    [self.bgView insertSubview:tipsLab aboveSubview:_container];
    tipsLab.font = FONT_MEDIUM(18);
    tipsLab.textColor = [UIColor colorWithHexString:@"0x161B19"];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    tipsLab.frame = CGRectMake(26, 518, kScreenWidth-26*2, 22);
    tipsLab.text = @"Click the button below to drain";
    
    UIButton *changeWaterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgView insertSubview:changeWaterBtn aboveSubview:_container];
    [changeWaterBtn setImage:ImageName(@"icon_play") forState:UIControlStateNormal];
    [changeWaterBtn setImage:ImageName(@"icon_stop") forState:UIControlStateSelected];
    [changeWaterBtn addTarget:self action:@selector(changeWaterAction:) forControlEvents:UIControlEventTouchUpInside];
    changeWaterBtn.frame = CGRectMake((kScreenWidth-90)/2, tipsLab.bottom+24, 90, 90);
    changeWaterBtn.selected = NO;
}

- (void)loadData
{
    _datas = [NSMutableArray array];
    
    for (int i = 0; i < 20; i++) {
        NSDictionary *dict = @{@"image" : [NSString stringWithFormat:@"photo_sample_0%d",i%7 + 1],
                               @"name" : @"YSLDraggableCardContainer Demo"};
        [_datas addObject:dict];
    }
}

// MARK: actions
- (void)sureBtnFuncAction:(UIButton *)sender {
    
}

- (void)changeWaterAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    BOOL isChangeWater = sender.selected ? YES : NO;
    DLog(@"%d",isChangeWater);
    [[deviceManager getDevice] publishDps:@{@"113": @(isChangeWater)} mode:TYDevicePublishModeLocal success:^{
        NSLog(@"publishDps success");
    } failure:^(NSError *error) {
        NSLog(@"publishDps failure: %@", error);
    }];
}

// MARK: -- YSLDraggableCardContainer DataSource
// 根据index获取当前的view
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    NSDictionary *dict = _datas[index];
    CardView *view = [[CardView alloc]initWithFrame:CGRectMake(26, 0, kScreenWidth - 26*2, 348)];
    view.backgroundColor = [UIColor whiteColor];
    view.imageView.image = [UIImage imageNamed:dict[@"image"]];
    
    view.label.text = [NSString stringWithFormat:@"%@  阿水淀粉撒地方就是发生了净空法师经济法哈是独家发售的机会飞机上的风华绝代撒谎放假啊收到费加罗好看是的发送到发送的%ld",dict[@"name"],(long)index];
    CGRect contentLabRect = [view.label.text boundingRectWithSize:CGSizeMake(view.label.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:view.label.font} context:nil];
    view.label.height = contentLabRect.size.height;
    [view.label sizeToFit];
    return view;
}

// 获取view的个数
- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLDraggableCardContainer Delegate
// 滑动view结束后调用这个方法
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
    
    if (draggableDirection == YSLDraggableDirectionDown) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
    }
}

// 更新view的状态, 滑动中会调用这个方法
- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    CardView *view = (CardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}


// 所有卡片拖动完成后调用这个方法
- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}


// 点击view调用这个
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ index : %ld",(long)index);
}
@end
