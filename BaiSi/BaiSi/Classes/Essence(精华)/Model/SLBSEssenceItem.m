//
//  SLBSEssenceItem.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/4.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceItem.h"

@implementation SLBSEssenceItem

-(CGFloat)cellHeight{
    if(_cellHeight) return _cellHeight;
    _cellHeight += Marin + 35 + Marin;
    CGSize maxSize = CGSizeMake(ScreenW - 4 * Marin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    _cellHeight += Marin + 35;
    _cellHeight += Marin;
    if(self.top_cmt.count){//有值
        NSString * content = self.top_cmt[0][@"content"];
        if (content.length) {
            NSString * name = self.top_cmt[0][@"user"][@"username"];
            name = [name stringByAppendingString:@" : "];
            name = [name stringByAppendingString:content];
            _cellHeight += Marin;
            _cellHeight += [name boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
        }
    }
    return _cellHeight;
}

@end
