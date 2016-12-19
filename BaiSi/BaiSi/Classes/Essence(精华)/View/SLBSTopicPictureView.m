//
//  SLBSTopicPictureView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicPictureView.h"
#import "SLBSSeeBigPicVC.h"

#import "UIImageView+Download.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"


@interface SLBSTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIImageView *gif;

@end

@implementation SLBSTopicPictureView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    
    [self.image setOriginImage:item.image1 thumbnail:item.image0 placeholder:nil completed:^{
        //处理图片过大时，等比例缩放图片
        if(item.isBigPic){
            CGFloat imageW = item.middleRect.size.width;
            CGFloat imageH = imageW * item.height / item.width;
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            [self.image.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.image.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    }];
    
    //gif   lowercaseString是转成小写 hasSuffix
    self.gif.hidden = !item.is_gif;
    //点击显示大图
    if(item.isBigPic){
        self.moreButton.hidden = NO;
        self.image.contentMode = UIViewContentModeTop;
        
        self.image.clipsToBounds = YES;
    }else{
        self.moreButton.hidden = YES;
        self.image.contentMode = UIViewContentModeScaleToFill;
        self.image.clipsToBounds = NO;
    }
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消默认autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    self.moreButton.hidden = YES;
    self.gif.hidden = YES;
    
    self.image.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)]];
}

-(void)seeBigPic{
    SLBSSeeBigPicVC * bigPic = [[SLBSSeeBigPicVC alloc] init];
    bigPic.item = self.item;
    [self.window.rootViewController presentViewController:bigPic animated:YES completion:nil];
}

@end
