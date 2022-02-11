//
//  ABTurntableView.h
//  UniversalApp
//
//  Created by Baypac on 2022/1/11.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABTurntableDelegate <NSObject>

- (void)turntableChangeMove:(CGFloat)rotationAngleInRadians retation:(ABRotationGestureRecognizer *)retation;
@end

@interface ABTurntableView : UIImageView

@property (nonatomic ,weak) id<ABTurntableDelegate> delegate;

- (void)plantGrowthCycleLayout:(NSArray *)titleArray;
@end

NS_ASSUME_NONNULL_END
