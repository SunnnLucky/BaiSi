//
//  SLFileTool.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/23.
//  Copyright © 2016年 Sun. All rights reserved.
//  处理文件缓存

#import "SLFileTool.h"

@implementation SLFileTool

#pragma mark - 业务逻辑
//获取缓存大小
+(void)getFielSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion{
    //判断下传进来的是否是文件夹
    //获取文件管理者
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [manager fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    //如果不存在或者不是文件夹
    if(!isExists || !isDirectory){
        //抛异常
        //Name:异常名称
        //reason:报错原因
        NSException * exc = [NSException exceptionWithName:@"pathErro" reason:@"需要传入一个文件夹路径，并且路径要存在" userInfo:nil];
        [exc raise];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSInteger size = 0;
        //获取文件夹下的所有子路径
        NSArray * subPaths = [manager subpathsAtPath:directoryPath];
        for (NSString * subPath in subPaths) {
            //获取全路径
            NSString * path = [directoryPath stringByAppendingPathComponent:subPath];
            
            //去除隐藏文件
            if ([path containsString:@".DS"]) continue;
            //去除文件夹
            BOOL isDirectory;
            BOOL isExists = [manager fileExistsAtPath:path isDirectory:&isDirectory];
            if (!isExists || isDirectory) continue;
            
            //根据路径返回属性字典 ---> 只能获取文件的尺寸，不能获取文件夹的尺寸
            NSDictionary * dict = [manager attributesOfItemAtPath:path error:nil];
            size += [dict fileSize];
        }
        //计算回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(size);
            }
        });
    });
}

+(void)removeDirectoryPath:(NSString *)path{
    //判断下传进来的是否是文件夹
    //获取文件管理者
    NSFileManager * manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExists = [manager fileExistsAtPath:path isDirectory:&isDirectory];
    //如果不存在或者不是文件夹
    if(!isExists || !isDirectory){
        //抛异常
        //Name:异常名称
        //reason:报错原因
        NSException * exc = [NSException exceptionWithName:@"pathErro" reason:@"需要传入一个文件夹路径，并且路径要存在" userInfo:nil];
        [exc raise];
    }
    
    //获取cache文件夹下的所有文件，不包括子路径的子路径
    NSArray * subPaths = [manager contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString * subPath in subPaths) {
        //拼接全路径
        NSString * filePath = [path stringByAppendingPathComponent:subPath];
        //删除文件夹
        [manager removeItemAtPath:filePath error:nil];
    }
}

@end
