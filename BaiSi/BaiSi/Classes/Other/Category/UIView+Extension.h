//
//  UIView+Extension.h
//  MaxJia
//
//  Created by 孙磊 on 15/12/28.
//  Copyright © 2015年 dotamax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic,assign)CGFloat sl_x;
@property(nonatomic,assign)CGFloat sl_y;
@property(nonatomic,assign)CGFloat sl_width;
@property(nonatomic,assign)CGFloat sl_height;
@property(nonatomic,assign)CGFloat sl_centerX;
@property(nonatomic,assign)CGFloat sl_centerY;

+(void)showMessage:(id)message andVC:(UIViewController *)view;

@end
