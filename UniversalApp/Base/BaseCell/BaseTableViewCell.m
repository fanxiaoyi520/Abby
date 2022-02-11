//
//  BaseTableViewCell.m
//  MiAiApp
//
//  Created by 徐阳 on 2017/6/19.
//  Copyright © 2017年 徐阳. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface BaseTableViewCell()

@end

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = KWhiteColor;
    }
    return self;
}

@end
