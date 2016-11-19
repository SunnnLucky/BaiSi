//
//  SLBSFastLoginV.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSFastLoginV.h"

@implementation SLBSFastLoginV

+(instancetype)fastLoginView{
    return [[NSBundle mainBundle] loadNibNamed:@"SLBSFastLoginV" owner:nil options:nil].firstObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

@end
