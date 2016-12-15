//
//  SLBSTopicPictureView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicPictureView.h"
#import "UIImageView+Download.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface SLBSTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation SLBSTopicPictureView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    
    [self.image setOriginImage:item.image1 thumbnail:item.image0 placeholder:nil completed:nil];
    
    if(item.middleRect.size.height == 201){
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
    self.moreButton.backgroundColor = [UIColor colorWithRed:100 / 255.0 green:100 / 255.0 blue:100 / 255.0 alpha:1];
    self.moreButton.hidden = YES;
}

@end
