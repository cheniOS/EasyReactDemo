//
//  HomeViewModel.h
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "RequestTool.h"
#import "HomeImageListModel.h"
@interface HomeViewModel : RequestTool
@property (nonatomic ,assign)NSInteger page;
@property (nonatomic ,strong)NSMutableArray * imageListArray;
@end
