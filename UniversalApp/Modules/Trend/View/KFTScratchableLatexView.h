//
//  KFTScratchableLatexView.h
//  KFTPhotoSecret
//
//  Created by BYC on 2020/9/9.
//  Copyright © 2020 快付通. All rights reserved.
//  以列为基准的九宫格,行数动态计算

#import <UIKit/UIKit.h>
@class KFTScratchableLatexView;

@protocol KFTScratchableLatexViewDelegate <NSObject>

@optional
- (void)scratchableLatexView:(KFTScratchableLatexView *)scratchableLatexView updateHeight:(CGFloat)height;

@end

@interface KFTScratchableLatexView : UIView

/**
 列数
 */
@property (nonatomic, assign)  NSUInteger cols;
/**
 行数
 */
@property (nonatomic, assign, readonly)  NSUInteger rows;

/**
 列间距
 */
@property (nonatomic, assign)  CGFloat  colMargin;

/**
 行间距
 */
@property (nonatomic, assign)  CGFloat  rowMargin;

/**
 单个元素宽度（itemWidth < 0 默认以填充的方式计算单个item宽度）
 */
@property (nonatomic, assign)  CGFloat  itemWidth;

/**
 单个元素高度
 */
@property (nonatomic, assign)  CGFloat  itemHeight;
/**
 高:宽 用于计算动态高度 比例（若itemHeight > 0 优先使用itemHeight）默认1
 */
@property (nonatomic, assign)  CGFloat  aspectRatio;

/**
 限制行数,limit < 0 代表不限制行数，默认不限制
 */
@property (nonatomic, assign)  NSInteger  limitRow;

@property (nonatomic, weak) IBOutlet id <KFTScratchableLatexViewDelegate> delegate;

/**
 某些情况下（比如九宫格的尺寸和理想的不一样）提前调用一下此方法试试
 */
- (void)prepare;



/// 计算整体高度
/// @param count 总tiem数量
/// @param cols 列数
/// @param itemH item高度
/// @param rowMargin 行间距
+(CGFloat)exeCalculationHeightWithCount:(NSInteger)count
                                   cols:(NSInteger)cols
                                  itemH:(CGFloat)itemH
                              rowMargin:(CGFloat)rowMargin;
/**
 从最后追加,尚未拓展指定位置最加（后续增加）
 */
-(void)addCustomSubview:(UIView *)view;

/**
 从最后删，尚未拓展指定位置删除（后续增加）
 */
-(void)deleteCustomSubview;

/**
 从最后追加子视图数组
 */
-(void)addCustomSubviews:(NSArray <UIView *> *)subviews;
@end


