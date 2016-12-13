//
//  SLBSTopicVoiceView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicVoiceView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@interface SLBSTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *playCount;
@property (weak, nonatomic) IBOutlet UILabel *voicetime;

@end

@implementation SLBSTopicVoiceView

-(void)setItem:(SLBSEssenceItem *)item{
    _item = item;
    
    //判断当前网络状态
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //判断是否下载过大图
    //从硬盘缓存取----->默认会先从内存缓存取   key就是url
    UIImage * bigImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image1];
    
    if (bigImage) {/*下载过*/
        self.image.image = bigImage;
    }else{
        if (manager.isReachableViaWiFi) {//wifi状态
            [self.image sd_setImageWithURL:[NSURL URLWithString:item.image1]];
        }else if (manager.isReachableViaWWAN){//手机自带网络
            BOOL downloadOriginImageWen3Gor4G = NO; //真实情况是从沙盒中取
            if(downloadOriginImageWen3Gor4G){//开启了3G/4G也下载高清图的话
                [self.image sd_setImageWithURL:[NSURL URLWithString:item.image1]];
            }else{
                [self.image sd_setImageWithURL:[NSURL URLWithString:item.image0]];
            }
        }else {//没有网络
            UIImage * thumbnail = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:item.image0];
            if (thumbnail) {
                self.image.image = thumbnail;
            }else{
                self.image.image = nil;
            }
        }
    }
    
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
    self.playCount.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1];
    self.voicetime.backgroundColor = [UIColor colorWithRed:104 / 255.0 green:104 / 255.0 blue:104 / 255.0 alpha:1];
}

@end
