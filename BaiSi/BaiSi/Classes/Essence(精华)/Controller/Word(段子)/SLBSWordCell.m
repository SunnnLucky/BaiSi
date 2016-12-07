//
//  SLBSWordCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/7.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSWordCell.h"

@implementation SLBSWordCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加中间view
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

-(void)setTopic:(SLBSEssenceItem *)topic{
    [super setTopic:topic];
}

@end
