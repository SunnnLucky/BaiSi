//
//  SLBSBaseTabBarC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSBaseTabBarC.h"
#import "SLBSBaseNavC.h"
#import "SLBSEssenceVC.h"
#import "SLBSNewVC.h"
#import "SLBSPublishVC.h"
#import "SLBSFriendTrendVC.h"
#import "SLBSMeTVC.h"

#import "UIImage+image.h"
#import "SLBSTabBar.h"

@interface SLBSBaseTabBarC ()

@end

@implementation SLBSBaseTabBarC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildVC];
    
    [self setupAllTitleButton];
    
    [self setUpTabBar];
    
    /*调试中的默认控制器*/
    self.selectedIndex = 2;
}

//只会调用一次
//只需要写一次时用这个方法
+ (void)load{
    /*
     1.appearance只要遵守了UIAppearance这个协议就可以调用
     2.获取整个应用下的UITabBar
     3.最好使用appearanceWhenContainedInInstancesOfClasses(获取哪个类中的UITabBar)
     */
    
    //拿到全局UITabBar
//    [UITabBar appearanceWhenContainedInInstancesOfClasses:@[self]].tintColor = [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1];
    
    //设置选中颜色
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:81/255.0 green:81/255.0 blue:81/255.0 alpha:1]} forState:UIControlStateSelected];
    //注意:设置字体大小，只有普通状态下有效
    [[UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
}

//可能调用多次
//+(void)initialize{
//    if(self == [SLBSBaseTabBarC class]){}
//}

-(void)setUpTabBar{
    SLBSTabBar * tab = [[SLBSTabBar alloc] init];
    [self setValue:tab forKey:@"tabBar"];
//    SLog(@"%@",self.tabBar);
}

//创建子控制器
-(void)setUpChildVC{
    //精华
    SLBSEssenceVC * essence = [[SLBSEssenceVC alloc] init];
    [self addChildViewController:[self navWithVC:essence]];

    //最新
    SLBSNewVC * new = [[SLBSNewVC alloc] init];
    [self addChildViewController:[self navWithVC:new]];

    //发布
//    SLBSPublishVC * publish = [[SLBSPublishVC alloc] init];
//    [self addChildVCWithVC:publish andNavName:@"百思不得姐" andTabbarName:@"发布" andImage:@"tabBar_publish_click_icon"];
    
    //关注
    SLBSFriendTrendVC * friend = [[SLBSFriendTrendVC alloc] init];
    [self addChildViewController:[self navWithVC:friend]];

    //我
    SLBSMeTVC * me = [[SLBSMeTVC alloc] init];
    [self addChildViewController:[self navWithVC:me]];
}

//Nav包裹子控制器
-(SLBSBaseNavC *)navWithVC:(UIViewController *)vc{
    SLBSBaseNavC * nav = [[SLBSBaseNavC alloc] initWithRootViewController:(vc)];
    return nav;
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton{
    //图片名称
    NSString * imgName = @"tabBar_essence_click_icon";
    
    //精华
    SLBSBaseNavC * nav = self.childViewControllers[0];
    //nav.topViewController.title = @"百思不得姐";
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageOriginalWithName:[imgName stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imgName];
    
    //最新
    imgName = @"tabBar_new_click_icon";
    SLBSBaseNavC * nav1 = self.childViewControllers[1];
//    nav1.topViewController.title = @"百思不得姐";
    nav1.tabBarItem.title = @"最新";
    nav1.tabBarItem.image = [UIImage imageOriginalWithName:[imgName stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imgName];
    
    //关注
    imgName = @"tabBar_friendTrends_click_icon";
    SLBSBaseNavC * nav2 = self.childViewControllers[2];
//    nav2.topViewController.title = @"关注";
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [UIImage imageOriginalWithName:[imgName stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imgName];
    
    //我
    imgName = @"tabBar_me_click_icon";
    SLBSBaseNavC * nav3 = self.childViewControllers[3];
//    nav3.topViewController.title = @"我的";
    nav3.tabBarItem.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageOriginalWithName:[imgName stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imgName];

}
@end
