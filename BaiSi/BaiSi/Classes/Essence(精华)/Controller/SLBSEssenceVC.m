//
//  SLBSEssenceVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceVC.h"


@interface SLBSEssenceVC ()

@end

@implementation SLBSEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setUpNavBar];
    
}

#pragma mark - 设置导航条
-(void)setUpNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] andHighImage:[UIImage imageNamed:@"nav_item_game_click_icon"] addTarget:self action:@selector(game)];
    
    //中间按钮
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] andHighImage:[UIImage imageNamed:@"navigationButtonRandomClick"] addTarget:self action:@selector(random)];
}

//random按钮点击
-(void)random
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"random按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//game按钮点击
-(void)game{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"game按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
