//
//  SLBSTopicCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/7.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicCell.h"
#import "SLBSEssenceItem.h"

@implementation SLBSTopicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:[[UISwitch alloc] init]];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = NSStringFromClass(self.class);
        [label sizeToFit];
        label.tag = 10;
        [self.contentView addSubview:label];
    }
    return self;
}

-(void)setTopic:(SLBSEssenceItem *)topic{
    _topic = topic;
    UILabel * label = (UILabel *)[self viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%@----------------%ld",NSStringFromClass([self class]),topic.type];
    [label sizeToFit];
}

@end
