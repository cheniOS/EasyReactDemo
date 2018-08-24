//
//  RequestTool.h
//  EasyReactDemo
//
//  Created by hbz on 2018/8/23.
//  Copyright © 2018年 chs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EasyReact/EasyReact.h>
#import <YYKit/YYKit.h>
#import "RequestModel.h"
static NSString * const rootUrlHost = @"https://www.apiopen.top/";
static NSString * const weatherUrl = @"weatherApi";
static NSString * const meituUrl = @"meituApi";
@interface RequestTool : NSObject
@property(nonatomic,strong,readonly) EZRNode * resultNode;
@property(nonatomic,strong,readonly) EZRNode * errorNode;
@property(nonatomic,strong,readonly) EZRMutableNode <RequestModel*> * parameters;


@end
