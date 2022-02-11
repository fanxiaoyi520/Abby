//
//  ABGuideAbbyView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/16.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABGuideAbbyView : UIView

@property (nonatomic ,weak) id <ABGuideViewDelegate> delegate;
- (void)updatePopView;
@end

NS_ASSUME_NONNULL_END
