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
    _cellHeight += Marin;
    
    if (self.type != SLBSTopicTypeWord) {//中间有内容（图片、声音、视频）
        CGFloat middleX = Marin;
        CGFloat middleY = _cellHeight;
        CGFloat middleW = maxSize.width;
        CGFloat middleH = self.height * middleW / self.width;
        if (middleH >= ScreenH) {//处理图片过长的情况。
            middleH = 201;
            self.bigPic = YES;
        }
        _cellHeight += middleH;
        _cellHeight += Marin;
        self.middleRect = CGRectMake(middleX, middleY, middleW, middleH);
    }
    
    if(self.top_cmt.count){//有值
        NSString * content = self.top_cmt[0][@"content"];
        
        if (!content.length) content = @"[语音]";
        
        NSString * name = self.top_cmt[0][@"user"][@"username"];
        name = [name stringByAppendingString:@" : "];
        name = [name stringByAppendingString:content];
        _cellHeight += Marin;
        _cellHeight += [name boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
    }
    
    _cellHeight += 35;
    _cellHeight += Marin;
    
    return _cellHeight;
}

@end
