//
//  UIImage+image.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+(UIImage *)imageOriginalWithName:(NSString *)name{
    return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
