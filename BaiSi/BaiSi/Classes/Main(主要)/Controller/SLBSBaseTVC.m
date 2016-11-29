//
//  SLBSBaseTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSBaseTVC.h"

@interface SLBSBaseTVC ()

@end


@implementation SLBSBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = randomColor;
    //滚动范围超过底部tabbar
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarH, 0);
    SLog(@"%@",NSStringFromClass([self class]));
}


@end
