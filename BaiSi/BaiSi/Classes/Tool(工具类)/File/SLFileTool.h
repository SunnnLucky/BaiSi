//
//  SLFileTool.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/23.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLFileTool : NSObject

/**
 *  获取文件夹尺寸
 *
 *  @parma directoryPath 文件夹路径
 *
 *  @parma completion 请求成功的回调
 */
+(void)getFielSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除文件夹所有文件
 *
 *  @parma path 文件夹路径
 */
+(void)removeDirectoryPath:(NSString *)path;

@end
