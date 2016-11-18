//
//  SLBSAdItem.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/16.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLBSAdItem : NSObject

//宽
@property(nonatomic,assign)CGFloat w;
//高
@property(nonatomic,assign)CGFloat h;
//跳转网页
@property(nonatomic,strong)NSString* ori_curl;
//图片网址
@property(nonatomic,strong)NSString* w_picurl;

//+(instancetype)initWithDict:(NSDictionary *)dict;

@end
