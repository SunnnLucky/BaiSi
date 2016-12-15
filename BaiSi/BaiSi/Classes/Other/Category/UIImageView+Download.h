//
//  UIImageView+Download.h
//  BaiSi
//
//  Created by 孙磊 on 2016/12/14.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Download)

typedef void (^completedBlock)();

//判断网络环境加载图片
-(void)setOriginImage:(NSString *)originURL thumbnail:(NSString *)thumbnailURL placeholder:(UIImage *)placeholder completed:(completedBlock)block;

//设置头像
-(void)setHeaderIcon:(NSString *)url;

@end
