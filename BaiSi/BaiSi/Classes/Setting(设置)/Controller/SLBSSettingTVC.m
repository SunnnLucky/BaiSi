//
//  SLBSSettingTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/15.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSSettingTVC.h"
#import "SDImageCache.h"
#import "SLFileTool.h"
#import "SVProgressHUD.h"

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface SLBSSettingTVC ()
@property(nonatomic , assign) NSInteger size;
@end

static NSString * const ID = @"cell";

@implementation SLBSSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [SVProgressHUD showWithStatus:@"正在计算缓存大小..."];
    
    [SLFileTool getFielSize:CachePath completion:^(NSInteger size) {
        _size = size;
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
}

-(void)dealloc{
    [SVProgressHUD dismiss];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [self sizeStr];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [SLFileTool removeDirectoryPath:CachePath];
    [SVProgressHUD showSuccessWithStatus:@"缓存清除成功"];
    self.size = 0;
    [self.tableView reloadData];
}

#pragma mark - 缓存业务逻辑
//获取缓存字符串
-(NSString *)sizeStr{
    //计算缓存数据  --->  沙盒(Cache)  --->  获取Cache文件夹尺寸
    //转换大小 MB KB B
    NSInteger size = _size;
    NSString * sizStr = @"清除缓存";
    CGFloat sizeF;
    if (size > 1000 * 1000) {
        //MB
        sizeF = size / 1000.0 / 1000.0;
        sizStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizStr,sizeF];
    }else if(size > 1000){
        //KB
        sizeF = size / 1000.0;
        sizStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizStr,sizeF];
    }else if (size > 0){
        //B
        sizeF = size;
        sizStr = [NSString stringWithFormat:@"%@(%.0fB)",sizStr,sizeF];
    }
    return sizStr;
}

@end
