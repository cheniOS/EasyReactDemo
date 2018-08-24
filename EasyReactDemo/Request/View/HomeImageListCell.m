//
//  HomeImageListCell.m
//  EasyReactDemo
//
//  Created by hbz on 2018/8/24.
//  Copyright © 2018年 chs. All rights reserved.
//

#import "HomeImageListCell.h"
#import <YYKit/UIImageView+YYWebImage.h>
@implementation HomeImageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HomeImageListModel *)model{
    _model = model;
    [self.mainImageView setImageURL:[NSURL URLWithString:model.url]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
