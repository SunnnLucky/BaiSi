//
//  SLBSFriendTrendVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSFriendTrendVC.h"
#import "SLBSLoginVC.h"

@interface SLBSFriendTrendVC ()

@end

@implementation SLBSFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavBar];
}

#pragma mark - 设置导航条
-(void)setUpNavBar{
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] andHighImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] addTarget:self action:@selector(friendsRecommentIcon)];
    
    //中间按钮
    self.navigationItem.title = @"我的关注";
}

//friendsRecommentIcon按钮点击
-(void)friendsRecommentIcon{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"friendsRecommentIcon按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 登录按钮点击
- (IBAction)didClickLogin:(id)sender {
    SLBSLoginVC * lg = [[SLBSLoginVC alloc] init];
    [self presentViewController:lg animated:YES completion:nil];
}


@end
