//
//  HomeImageListModel.h
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ForecastModel : NSObject
@property (nonatomic, copy)   NSString *date; //
@property (nonatomic, copy)   NSString *fengxiang; //
@property (nonatomic, copy)   NSString *type; //
@property (nonatomic, copy)   NSString *high; //
@property (nonatomic, copy)   NSString *low; //
@property (nonatomic, copy)   NSString *fengli; //
@end

@interface HomeWeatherModel : NSObject
@property (nonatomic, copy)   NSString *ganmao; //
@property (nonatomic, copy)   NSString *aqi; //
@property (nonatomic, copy)   NSString *city; //
@property (nonatomic, copy)   NSString *wendu; //
@property (nonatomic, strong) NSArray  *forecast; //
@end

@interface HomeImageListModel : NSObject
@property (nonatomic, copy)   NSString *publishedAt; //
@property (nonatomic, copy)   NSString *type; //
@property (nonatomic, copy)   NSString *url; //
@property (nonatomic, copy)   NSString *createdAt;
@end
