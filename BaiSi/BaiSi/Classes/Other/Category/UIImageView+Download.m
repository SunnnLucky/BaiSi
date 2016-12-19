//
//  UIImageView+Download.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/14.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "UIImageView+Download.h"
#import "UIImageView+WebCache.h"
#import "UIImage+image.h"
#import "AFNetworking.h"

#import "SLBSSeeBigPicVC.h"

@implementation UIImageView (Download)

-(void)setOriginImage:(NSString *)originURL thumbnail:(NSString *)thumbnailURL placeholder:(UIImage *)placeholder completed:(completedBlock)block{
    //判断当前网络状态
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    //判断是否下载过大图
    //从硬盘缓存取----->默认会先从内存缓存取   key就是url
    UIImage * bigImage = nil;
    if(![originURL.lowercaseString hasSuffix:@"gif"]) bigImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originURL];
    
    if (bigImage) {/*下载过*/
        self.image = bigImage;
    }else{
        if (manager.isReachableViaWiFi) {//wifi状态
            [self sd_setImageWithURL:[NSURL URLWithString:originURL] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (block && image != NULL) {
                    block();
                }
            }];
        }else if (manager.isReachableViaWWAN){//手机自带网络
            BOOL downloadOriginImageWen3Gor4G = NO; //真实情况是从沙盒中取
            if(downloadOriginImageWen3Gor4G){//开启了3G/4G也下载高清图的话
                [self sd_setImageWithURL:[NSURL URLWithString:originURL] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (block && image != NULL) {
                        block();
                    }
                }];
            }else{
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailURL] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (block && image != NULL) {
                        block();
                    }
                }];
            }
        }else {//没有网络
            UIImage * thumbnail = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailURL];
            if (thumbnail) {
                self.image = thumbnail;
                if (block) {
                    block();
                }
            }else{
                self.image = nil;
            }
        }
    }
}

-(void)setHeaderIcon:(NSString *)url{
    UIImage * placeholderImage = [UIImage circleImageName:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.image = [image circleImage];
    }];
}




@end
