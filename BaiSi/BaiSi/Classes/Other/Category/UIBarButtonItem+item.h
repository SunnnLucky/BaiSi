//
//  UIBarButtonItem+item.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/15.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

+(UIBarButtonItem *)creatItemWithImage:(UIImage *)image andHighImage:(UIImage *)high addTarget:(id)target action:(SEL)action;

+(UIBarButtonItem *)creatItemWithImage:(UIImage *)image andSelImage:(UIImage *)sel addTarget:(id)target action:(SEL)action;

@end
