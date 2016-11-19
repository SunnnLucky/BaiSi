//
//  SLBSFastLoginBtn.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSFastLoginBtn.h"

@implementation SLBSFastLoginBtn

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.sl_y = 0;
    self.imageView.sl_centerX = self.sl_width * 0.5;
    
    self.titleLabel.sl_y = self.sl_height - self.titleLabel.sl_height;
    //计算文字宽度，设置label宽度  ------  先算完再改center
    [self.titleLabel sizeToFit];
    
    self.titleLabel.sl_centerX = self.sl_width * 0.5;
}

@end
