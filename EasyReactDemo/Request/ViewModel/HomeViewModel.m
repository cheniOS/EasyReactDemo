//
//  HomeViewModel.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModel
-(NSMutableArray *)imageListArray{
    if (!_imageListArray) {
        _imageListArray = [[NSMutableArray alloc]init];
    }
    return _imageListArray;
}

@end
