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

@interface SLBSBaseTabBarC ()

@end

@implementation SLBSBaseTabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildVC];
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

//创建子控制器
-(void)setUpChildVC{
    //精华
    SLBSEssenceVC * essence = [[SLBSEssenceVC alloc] init];
    
    [self addChildVCWithVC:essence andNavName:@"百思不得姐" andTabbarName:@"精华" andImage:@"tabBar_essence_click_icon"];
    //最新
    SLBSNewVC * new = [[SLBSNewVC alloc] init];
    [self addChildVCWithVC:new andNavName:@"百思不得姐" andTabbarName:@"最新" andImage:@"tabBar_new_click_icon"];
    //发布
    SLBSPublishVC * publish = [[SLBSPublishVC alloc] init];
    [self addChildVCWithVC:publish andNavName:@"百思不得姐" andTabbarName:@"发布" andImage:@"tabBar_publish_click_icon"];
    //关注
    SLBSFriendTrendVC * friend = [[SLBSFriendTrendVC alloc] init];
    [self addChildVCWithVC:friend andNavName:@"关注" andTabbarName:@"关注" andImage:@"tabBar_friendTrends_click_icon"];
    //我
    SLBSMeTVC * me = [[SLBSMeTVC alloc] init];
    [self addChildVCWithVC:me andNavName:@"我的" andTabbarName:@"我的" andImage:@"tabBar_me_click_icon"];
}

//Nav包裹子控制器
-(void)addChildVCWithVC:(UIViewController *)vc andNavName:(NSString*)navName andTabbarName:(NSString*)tabName andImage:(NSString *)image{
    
    NSLog(@"%@",[image stringByReplacingOccurrencesOfString:@"click_" withString:@""]);
    //如果是发布特殊处理
    if ([vc isKindOfClass:[SLBSPublishVC class]]) {
        [self addChildViewController:vc];
        vc.tabBarItem.image = [UIImage imageOriginalWithName:[image stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
        vc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:image];
        // 设置图片位置
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6 , 0);
        return;
    }
    SLBSBaseNavC * nav = [[SLBSBaseNavC alloc] initWithRootViewController:(vc)];
    nav.topViewController.title = navName;
    nav.tabBarItem.title = tabName;
    //操作字符串
    nav.tabBarItem.image = [UIImage imageOriginalWithName:[image stringByReplacingOccurrencesOfString:@"click_" withString:@""]];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:image];
    [self addChildViewController:nav];
}
@end
