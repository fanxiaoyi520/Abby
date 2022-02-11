//
//  ABMainHomeDelegate.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/20.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ABMainHomeDelegate <NSObject>
@optional

- (void)mainHome_weekAction:(UIButton *)sender;
- (void)mainHome_StartFuncAction:(UIButton *)sender;
- (void)mainHone_customerServiceAction:(UIButton *)sender;
- (void)mainHone_skinAction:(UIButton *)sender;
- (void)mainHone_OxygenCollectionAction:(UITapGestureRecognizer *)sender;
- (void)mainHone_learnMore:(UIButton *)sender;
@end

