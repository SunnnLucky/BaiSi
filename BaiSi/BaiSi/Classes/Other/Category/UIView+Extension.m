//
//  UIView+Extension.m
//  MaxJia
//
//  Created by 孙磊 on 15/12/28.
//  Copyright © 2015年 dotamax. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(CGFloat)sl_x{
    return self.frame.origin.x;
}

-(void)setSl_x:(CGFloat)sl_x{
    CGRect frame = self.frame;
    frame.origin.x = sl_x;
    self.frame = frame;
}

-(CGFloat)sl_y{
    return self.frame.origin.y;
}

-(void)setSl_y:(CGFloat)sl_y{
    CGRect frame = self.frame;
    frame.origin.y = sl_y;
    self.frame = frame;
}

-(CGFloat)sl_height{
    return self.frame.size.height;
}

-(void)setSl_height:(CGFloat)sl_height{
    CGRect frame = self.frame;
    frame.size.height = sl_height;
    self.frame = frame;
}

-(CGFloat)sl_width{
    return self.frame.size.width;
}

-(void)setSl_width:(CGFloat)sl_width{
    CGRect frame = self.frame;
    frame.size.width = sl_width;
    self.frame = frame;
}

-(CGFloat)sl_centerX{
    return self.center.x;
}

-(void)setSl_centerX:(CGFloat)sl_centerX{
    CGPoint center = self.center;
    center.x = sl_centerX;
    self.center = center;
}

-(CGFloat)sl_centerY{
    return self.center.y;
}

-(void)setSl_centerY:(CGFloat)sl_centerY{
    CGPoint center = self.center;
    center.y = sl_centerY;
    self.center = center;
}
@end
