//
//  ABCustomNavBar.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/24.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ABNavBarEventDelegate <NSObject>

- (void)customNavBarClickEventAction:(UITapGestureRecognizer *)sender;

@end
@interface ABCustomNavBar : UIView

@property (nonatomic , weak) id<ABNavBarEventDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
