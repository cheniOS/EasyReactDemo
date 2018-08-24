//
//  HomeImageListCell.h
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeImageListModel.h"
@interface HomeImageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property(nonatomic ,strong)HomeImageListModel * model;
@end
