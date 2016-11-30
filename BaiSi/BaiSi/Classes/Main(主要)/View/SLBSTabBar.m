//
//  SLBSTabBar.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/11.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTabBar.h"

@interface SLBSTabBar()

@property(nonatomic,strong)UIButton * plusBtn;
@property(nonatomic,weak)UIControl * lastClickBtn;

@end

@implementation SLBSTabBar

-(UIButton *)plusBtn{
    if (!_plusBtn) {
        _plusBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        [_plusBtn setImage:[UIImage imageOriginalWithName:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageOriginalWithName:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_plusBtn sizeToFit];
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}

-(void)layoutSubviews
{
    //    SLog(@"%d",self.items.count);
    [super layoutSubviews];
    
    NSUInteger count = self.items.count + 1;
    CGFloat btnW = self.sl_width / count;
    CGFloat btnH = self.sl_height;
    int i = 0;
    //    SLog(@"%@",self.subviews);
    
    for (UIControl * btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            
            if (i == 0 && self.lastClickBtn == nil){
                self.lastClickBtn = btn;
            }
            
            if (i == 2) {
                i += 1;
            }
            
            btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [btn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            i++;
        }
    }
    
    self.plusBtn.center = CGPointMake(self.sl_width * 0.5, self.sl_height * 0.5);
    //    SLog(@"%@",self.plusBtn);
}

-(void)tabBarButtonClick:(UIControl *)tabBarButton{
    if (tabBarButton == self.lastClickBtn) {
        //重复点击时
        //SLBSTabBarButtonDidRepeatClickNotification
        [[NSNotificationCenter defaultCenter] postNotificationName:SLBSTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.lastClickBtn = tabBarButton;
}


@end
