//
//  SLBSTopicVideoView.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/12.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicVideoView.h"

@implementation SLBSTopicVideoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    //取消默认autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
}

@end
