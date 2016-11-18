//
//  SLBSNewVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSNewVC.h"
#import "SLBSSubTagTVC.h"
#import "SLBSSubTagCell.h"

@interface SLBSNewVC ()

@end

@implementation SLBSNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavBar];
}

#pragma mark - 设置导航条
-(void)setUpNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] andHighImage:[UIImage imageNamed:@"MainTagSubIconClick"] addTarget:self action:@selector(MainTagSubIcon)];
    
    //中间按钮
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

#pragma mark - 订阅按钮点击
-(void)MainTagSubIcon{
    SLBSSubTagTVC * subTag = [[SLBSSubTagTVC alloc] init];
    subTag.title = @"推荐标签";
    [self.navigationController pushViewController:subTag animated:YES];
}

@end
