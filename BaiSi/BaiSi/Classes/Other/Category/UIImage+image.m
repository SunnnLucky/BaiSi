//
//  UIImage+image.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+(instancetype)imageOriginalWithName:(NSString *)name{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

-(instancetype)circleImage{
    //1.开启图形上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.描述裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //3.设置裁剪区域
    [path addClip];
    //4.画图片
    [self drawAtPoint:CGPointZero];
    //5.取出图片
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //6.关闭上下文
    UIGraphicsEndImageContext();

    return image;
}

+(instancetype)circleImageName:(NSString *)name{
    return [[self imageNamed:name] circleImage];
}

@end
