//
//  SLBSTopicVoiceView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicVoiceView.h"
#import "UIImageView+WebCache.h"

@interface SLBSTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *voicetime;

@end

@implementation SLBSTopicVoiceView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    [self.image sd_setImageWithURL:[NSURL URLWithString:item.image0]];
    
    if (item.playcount >= 10000) {
        self.playCount.text = [NSString stringWithFormat:@"%.2f万播放",item.playcount / 10000.0];
    }else{
        self.playCount.text = [NSString stringWithFormat:@"%zd播放",item.playcount];
    }
    
    self.voicetime.text = [NSString stringWithFormat:@"%02zd:%02zd",item.voicetime / 60 , item.voicetime % 60];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消默认autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    self.playCount.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:0.7];
    self.voicetime.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:0.7];
}

@end
