//
//  ABTrendLogic.m
//  UniversalApp
//
//  Created by Baypac on 2021/12/1.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import "ABTrendLogic.h"
#import "ABGetTrendListAPI.h"

@implementation ABTrendLogic

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
//    ABGetTrendListAPI *req = [ABGetTrendListAPI new];
//    [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"请求成功");
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSLog(@"请求失败 %@",req.message);
//        //模拟成功
//        for (int i = 0; i < 14; i++) {
//
//            NSString *imageName = NSStringFormat(@"%d.jpg", i);
//            ABTrentModel *model = [@"" yy_modelToJSONObject];
//            [_dataArray addObject:imageName];
//        }
//        if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
//            [self.delegagte requestDataCompleted];
//        }
//    }];
    NSArray *jsonData = [ABUtils getJsonDataJsonname:@"ABTrend"];
    [jsonData enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger i, BOOL * _Nonnull stop) {
        ABTrentModel *model = [ABTrentModel yy_modelWithJSON:obj1];
        [self.dataArray addObject:model];
    }];
    if (self.delegagte && [self.delegagte respondsToSelector:@selector(requestDataCompleted)]) {
        [self.delegagte requestDataCompleted];
    }
}

// MARK: 动态计算cell高度
+ (CGFloat)dynamicallyCalculateCellHeight:(ABTrentModel *)model {
    return  [ABTrendLogic dynamicallyCalculateCellHeight:model isShowMore:NO];
}

+ (CGFloat)dynamicallyCalculateCellHeight:(ABTrentModel *)model isShowMore:(BOOL)isShowMore {
    CGFloat cellHeight = 0;
    cellHeight = 46+83+61; //固定不变的高度区域

    if (!ValidStr(model.content)) {
        if (model.images.count == 0) {
            cellHeight = cellHeight;
        } else if (model.images.count == 2) {
            cellHeight = cellHeight+107;
        } else {
            cellHeight = cellHeight+221;
        }
    }
    
    if (ValidStr(model.content)) {
        CGSize contentLabSize = [model.content boundingRectWithSize:CGSizeMake(kScreenWidth-65-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:FONT_REGULAR(15)} context:nil].size;
        if (contentLabSize.height <= FONT_REGULAR(15).lineHeight*3) {
            if (model.images.count == 0) {
                cellHeight = cellHeight+contentLabSize.height + 8;
            } else if (model.images.count == 2) {
                cellHeight = cellHeight+107+contentLabSize.height + 8;
            } else {
                cellHeight = cellHeight+220+contentLabSize.height + 8;
            }
        }
        
        if (contentLabSize.height > FONT_REGULAR(15).lineHeight*3) {
            if (!isShowMore) {
                if (model.images.count == 0) {
                    cellHeight = cellHeight+FONT_REGULAR(15).lineHeight*3 + 32;
                } else if (model.images.count == 2) {
                    cellHeight = cellHeight+107+FONT_REGULAR(15).lineHeight*3 + 32;
                } else {
                    cellHeight = cellHeight+220+FONT_REGULAR(15).lineHeight*3 + 32;
                }
            }
            
            if (isShowMore) {
                if (model.images.count == 0) {
                    cellHeight = cellHeight+contentLabSize.height + 8;
                } else if (model.images.count == 2) {
                    cellHeight = cellHeight+107+contentLabSize.height + 8;
                } else {
                    cellHeight = cellHeight+220+contentLabSize.height + 8;
                }
            }
        }
    }
    return cellHeight;
}

@end
