//
//  SLBSTopicPictureView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicPictureView.h"
#import "UIImageView+WebCache.h"

@interface SLBSTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation SLBSTopicPictureView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    [self.image sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    
    if(item.middleRect.size.height == 200.5){
        self.image.contentMode = UIViewContentModeTop;
        self.image.layer.masksToBounds = YES;
        self.moreButton.hidden = NO;
    }else{
        self.image.contentMode = UIViewContentModeScaleToFill;
        self.image.layer.masksToBounds = NO;
        self.moreButton.hidden = YES;
    }
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消默认autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    self.moreButton.backgroundColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:0.5];
    self.moreButton.hidden = YES;
}

@end
