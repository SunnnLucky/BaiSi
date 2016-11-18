//
//  SLBSSubTagCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/18.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSSubTagCell.h"
#import "UIImageView+WebCache.h"

@interface SLBSSubTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *subTag;


@end

@implementation SLBSSubTagCell

-(void)awakeFromNib{
    [super awakeFromNib];
    /*
    //设置圆角
    self.icon.layer.cornerRadius = 30;
    //设置裁剪
    self.icon.layer.masksToBounds = YES;
     */
}

-(void)setItem:(SLBSSubTagItem *)item{
    _item = item;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.name.text = item.theme_name;
    
    //处理订阅人数
    NSString * str = item.sub_number;
    float num = str.integerValue;
    if (num >= 10000) {
        num = num / 10000.0;
        str = [NSString stringWithFormat:@"%.1lf万",num];
        str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.subTag.text = [NSString stringWithFormat:@"%@人订阅",str];
}

- (IBAction)didClick:(id)sender {
    //通知外界哪个按钮点击了订阅
    if (self.block) {
        self.block(self.item);
    }
}

@end
