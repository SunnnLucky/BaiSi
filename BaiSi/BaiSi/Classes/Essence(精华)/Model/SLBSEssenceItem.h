//
//  SLBSEssenceItem.h
//  BaiSi
//
//  Created by 孙磊 on 2016/12/4.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLBSEssenceItem : NSObject

/** 用户的名字 */
@property (nonatomic, strong) NSString *name;
/** 用户的头像 */
@property (nonatomic, strong) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, strong) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, strong) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

@end
