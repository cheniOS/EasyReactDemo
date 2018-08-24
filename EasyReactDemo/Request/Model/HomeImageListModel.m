//
//  HomeImageListModel.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "HomeImageListModel.h"

@implementation HomeImageListModel

@end
@implementation ForecastModel

@end
@implementation HomeWeatherModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
 
    return @{@"forecast" : [ForecastModel class],
            };
}

@end
