//
//  ABGuideSecondLogic.m
//  UniversalApp
//
//  Created by Baypac on 2022/2/10.
//  Copyright © 2022 徐阳. All rights reserved.
//

#import "ABGuideSecondLogic.h"
#import "ABGuideSecondModel.h"
@implementation ABGuideSecondLogic
-(instancetype)init{
    self = [super init];
    if (self) {
        _dataArray = @[].mutableCopy;
    }
    return self;
}

#pragma mark ————— 拉取数据 —————
-(void)loadData{
//    //发起请求
//    ABOxygenBillAPI *req = [ABOxygenBillAPI new];
//    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"请求成功");
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"请求失败 %@",req.message);
//        NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABMineOxygenData"];
//        [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
//            ABOxygenBillModel *model = [ABOxygenBillModel yy_modelWithJSON:obj1];
//            [_dataArray addObject:model];
//        }];
//        if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
//            [self.delegagte requestDataCompleted];
//        }
//    }];
    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABUnlockLoopData"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        ABGuideSecondModel *model = [ABGuideSecondModel yy_modelWithJSON:obj1];
        [_dataArray addObject:model];
    }];
    if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
        [self.delegagte requestDataCompleted];
    }
}
@end
