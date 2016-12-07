//
//  SLBSVideoCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/7.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSVideoCell.h"

@implementation SLBSVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加中间view
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

-(void)setTopic:(SLBSEssenceItem *)topic{
    [super setTopic:topic];
}

@end
