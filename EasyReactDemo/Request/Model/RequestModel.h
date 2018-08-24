//
//  RequestModel.h
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RequestResultModel : NSObject
@property(nonatomic ,copy)NSString * requestUrl;//请求的接口
@property(nonatomic ,copy)id  result;//请求的结果
@end
@interface RequestModel : NSObject
@property(nonatomic ,copy)NSString * requestUrl;//请求的接口
@property(nonatomic ,copy)NSMutableDictionary * params;//请求参数
@property(nonatomic ,assign)BOOL isPOST;  //默认GET请求
@end
