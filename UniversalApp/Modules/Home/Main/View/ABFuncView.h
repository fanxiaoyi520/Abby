//
//  ABFuncView.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/17.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABFuncView : UIView

@property (nonatomic ,weak) id<ABMainHomeDelegate> delegate;
- (void)oxygenCollection:(UITapGestureRecognizer *)tap;
@end

NS_ASSUME_NONNULL_END
