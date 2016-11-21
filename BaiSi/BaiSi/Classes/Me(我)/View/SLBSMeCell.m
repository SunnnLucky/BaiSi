//
//  SLBSMeCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/21.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSMeCell.h"
#import "UIImageView+WebCache.h"
#import "SLBSMeItem.h"


@implementation SLBSMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setItem:(SLBSMeItem *)item{
    _item = item;
    [_icon sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    _name.text = item.name;
}

@end
