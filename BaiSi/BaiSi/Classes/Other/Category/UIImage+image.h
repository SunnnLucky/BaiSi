//
//  UIImage+image.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)

+(instancetype)imageOriginalWithName:(NSString *)name;

-(instancetype)circleImage;

+(instancetype)circleImageName:(NSString *)name;
@end
