
//
//  KFTScratchableLatexView.m
//  KFTPhotoSecret
//
//  Created by BYC on 2020/9/9.
//  Copyright © 2020 快付通. All rights reserved.
//

#import "KFTScratchableLatexView.h"

@interface KFTScratchableLatexView() {
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

@property (nonatomic, assign)  CGFloat  subViewW;
@property (nonatomic, assign)  CGFloat  subViewH;
@property (nonatomic, assign)  NSUInteger rows;
@property (nonatomic, assign)  NSUInteger currentCol;
@property (nonatomic, assign)  NSUInteger currentRow;

@property (nonatomic, assign)  CGFloat  item_temp_Width;
@property (nonatomic, assign)  CGFloat  item_temp_Height;

@end

@implementation KFTScratchableLatexView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.clipsToBounds = YES;
    self.aspectRatio = 1.0;
    self.rows = 0;
    self.colMargin = 0;
    self.rowMargin = 0;
    self.limitRow = -1;
    self.currentRow = 0;
    self.itemWidth = 0;
    self.itemHeight = 0;
    //防止子视图修改没必要的frame信息
    self.autoresizesSubviews = NO;
}

- (void)prepare {
    [self layoutIfNeeded];
}

-(void)addCustomSubview:(UIView *)view{

    [self exeCalculate];

    if (self.currentRow == self.limitRow) {
        return;
    }
    
    CGFloat subViewX = self.currentCol * (self.subViewW + self.colMargin);
    CGFloat subViewY = self.currentRow * (self.subViewH + self.rowMargin);
    view.frame = CGRectMake(subViewX, subViewY, self.subViewW, self.subViewH);
    [self addSubview: view];
    [self dealwith];
}

/// 计算整体高度
/// @param count 总tiem数量
/// @param cols 列数
/// @param itemH item高度
/// @param rowMargin 行间距
+(CGFloat)exeCalculationHeightWithCount:(NSInteger)count
                                   cols:(NSInteger)cols
                                  itemH:(CGFloat)itemH
                              rowMargin:(CGFloat)rowMargin {
    if (count <= 0) {
        return 0.0f;
    }
    NSInteger col = count % cols;
    NSInteger row = count / cols;
    NSInteger rows = row + (col > 0 ? 1 : 0);
    CGFloat height = (itemH + rowMargin) * rows - rowMargin;
    return height;
}

-(void)deleteCustomSubview{
    
    [[self.subviews lastObject] removeFromSuperview];
    [self exeCalculate];
    [self dealwith];
}

-(void)addCustomSubviews:(NSArray <UIView *> *)subviews {
    for (UIView *subView in subviews) {
        [self addCustomSubview:subView];
    }
}


- (void)exeCalculate {
    NSUInteger index = self.subviews.count;
    if (self.cols == 0) {
        return;
    }
    self.currentCol = index % self.cols;
    self.currentRow = index / self.cols;
}

- (void)dealwith {
    CGFloat height = 0;
    if (self.subviews.count != 0) {
        height = (self.currentRow * ( self.rowMargin + self.subViewH)) + self.subViewH;
    }
    if (self.translatesAutoresizingMaskIntoConstraints) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(scratchableLatexView:updateHeight:)]) {
        [self.delegate scratchableLatexView:self updateHeight:height];
    }
}

-(NSUInteger)rows {
    if (self.subviews.count == 0) {
        return 0;
    }
    return self.currentRow + 1;
}

-(void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    _item_temp_Width = itemWidth;
}

-(void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
    _item_temp_Height = itemHeight;
}

-(CGFloat)itemWidth {
    return self.subViewW;
}

-(CGFloat)itemHeight {
    return self.subViewH;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.subViewW = self.item_temp_Width > 0 ? self.item_temp_Width : ((self.frame.size.width - self.colMargin * (self.cols - 1)) / self.cols);
    self.subViewH = self.item_temp_Height > 0 ? self.item_temp_Height : (self.subViewW * self.aspectRatio);
    
    
}
@end
