//
//  SLBSBaseNavC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSBaseNavC.h"

@interface SLBSBaseNavC ()<UIGestureRecognizerDelegate>

@end

@implementation SLBSBaseNavC

- (void)viewDidLoad {
    [super viewDidLoad];
    //全屏滑动
    /*
     action=handleNavigationTransition:,
     target=<_UINavigationInteractiveTransition 0x7fcb3350d4c0>)>>  与代理是同一个类
     */
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    //控制手势什么时候触发
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    //取消系统默认代理
    self.interactivePopGestureRecognizer.enabled = NO;
}

//只加载一次
+(void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //滑动手势代理
//    NSLog(@"%@",self.interactivePopGestureRecognizer);
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem creatBackItem:[UIImage imageNamed:@"navigationButtonReturn"] andHighImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTarget:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark -UIGestureRecognizerDelegate
// 决定是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

@end
