//
//  SLBSSubTagItem.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/18.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLBSSubTagItem : NSObject

//订阅人数
@property(nonatomic,assign)NSString* sub_number;
//图片网址
@property(nonatomic,strong)NSString* image_list;
//名称
@property(nonatomic,strong)NSString* theme_name;

@end
