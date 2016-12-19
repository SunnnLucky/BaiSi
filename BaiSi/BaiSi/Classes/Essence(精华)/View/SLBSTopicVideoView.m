//
//  SLBSTopicVideoView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicVideoView.h"
#import "SLBSSeeBigPicVC.h"

#import "UIImageView+WebCache.h"
#import "UIImageView+Download.h"

@interface SLBSTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *videoTime;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation SLBSTopicVideoView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    
    [self.image setOriginImage:item.image1 thumbnail:item.image0 placeholder:nil completed:^{
        self.backImage.hidden = YES;
    }];
    
    if (item.playcount >= 10000) {
        self.playCount.text = [NSString stringWithFormat:@"%.2f万播放",item.playcount / 10000.0];
    }else{
        self.playCount.text = [NSString stringWithFormat:@"%zd播放",item.playcount];
    }
    
    // %04d : 占据4位，多余的空位用0填补
    self.videoTime.text = [NSString stringWithFormat:@"%02zd:%02zd",item.videotime / 60 , item.videotime % 60];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消默认autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    self.playCount.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1];
    self.videoTime.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1];
    
    self.image.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic)]];
}

-(void)seeBigPic{
    SLBSSeeBigPicVC * bigPic = [[SLBSSeeBigPicVC alloc] init];
    bigPic.item = self.item;
    [self.window.rootViewController presentViewController:bigPic animated:YES completion:nil];
}

@end
