//
//  ABDeviceDpsModel.h
//  UniversalApp
//
//  Created by Baypac on 2021/12/23.
//  Copyright © 2021 徐阳. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABDeviceDpsModel : NSObject

@property (nonatomic, copy) NSString *d_switch;
@property (nonatomic, copy) NSString *bright_value;
@property (nonatomic, copy) NSString *temp_current;
@property (nonatomic, copy) NSString *humidity_current;
@property (nonatomic, copy) NSString *Flowering_time;
@property (nonatomic, copy) NSString *Ventilation;
@property (nonatomic, copy) NSString *water_temperature;
@property (nonatomic, copy) NSString *water_level;
@property (nonatomic, copy) NSString *door;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *Add_fertilizer;
@property (nonatomic, copy) NSString *human_detection;
@property (nonatomic, copy) NSString *flush;
@property (nonatomic, copy) NSString *dry;
@property (nonatomic, copy) NSString *weekcycle;
@property (nonatomic, copy) NSString *pump_water;
@property (nonatomic, copy) NSString *input_air_flow;
@property (nonatomic, copy) NSString *turn_on_the_light;
@property (nonatomic, copy) NSString *turn_off_light;
@property (nonatomic, copy) NSString *air_pump;

- (void)updateModelWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
