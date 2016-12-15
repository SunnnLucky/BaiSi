//
//  SLBSEssenceItem.h
//  BaiSi
//
//  Created by 孙磊 on 2016/12/4.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

//方式一:
//typedef enum {
//    /** 全部 */
//    SLBSTopicTypeAll = 1,
//    /** 视频 */
//    SLBSTopicTypeVideo = 41,
//    /** 音频 */
//    SLBSTopicTypeVoice = 31,
//    /** 图片 */
//    SLBSTopicTypePicture = 10,
//    /** 段子 */
//    SLBSTopicTypeWord = 29
//} SLBSTopicType;

//方式二:推荐 (苹果内部)
typedef NS_ENUM(NSUInteger,SLBSTopicType) {
    /** 全部 */
    SLBSTopicTypeAll = 1,
    /** 视频 */
    SLBSTopicTypeVideo = 41,
    /** 音频 */
    SLBSTopicTypeVoice = 31,
    /** 图片 */
    SLBSTopicTypePicture = 10,
    /** 段子 */
    SLBSTopicTypeWord = 29
};

@interface SLBSEssenceItem : NSObject

/** 用户的名字 */
@property (nonatomic, strong) NSString *name;
/** 用户的头像 */
@property (nonatomic, strong) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, strong) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, strong) NSString *passtime;
/** 音频视频图片 */
@property (nonatomic, strong) NSString *bimageuri;
/** 图片 */
@property (nonatomic, strong) NSString *cdn_img;
/** 略缩图 */
@property (nonatomic, strong) NSString *image0;
/** 大图 */
@property (nonatomic, strong) NSString *image1;
/** 中图 */
@property (nonatomic, strong) NSString *image2;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;

/** 帖子类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;
/** 是否是动图 */
@property (nonatomic, assign) BOOL is_gif;

/** cellHeight */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间view高度 */
@property (nonatomic, assign) CGRect middleRect;
/** 长图 */
@property (nonatomic, assign, getter=isBigPic) BOOL bigPic;
@end
