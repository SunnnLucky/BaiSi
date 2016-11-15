//
//  SLBSNewVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSNewVC.h"

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

//MainTagSubIcon按钮点击
-(void)MainTagSubIcon{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"MainTagSubIcon按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
