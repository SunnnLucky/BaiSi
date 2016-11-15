//
//  SLBSMeTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSMeTVC.h"

@interface SLBSMeTVC ()

@end

@implementation SLBSMeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavBar];
}

#pragma mark - 设置导航条
-(void)setUpNavBar{
    //左边按钮
    UIBarButtonItem * setting = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] andHighImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(setting)];
    UIBarButtonItem * moon = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] andSelImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(moon:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    //中间按钮
    self.navigationItem.title = @"我的";
}

//setting按钮点击
-(void)setting{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"setting按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//moon按钮点击
-(void)moon:(UIButton *)moon{
    moon.selected = !moon.selected;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"moon按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
