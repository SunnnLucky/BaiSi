//
//  SLBSLoginVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSLoginVC.h"
#import "SLBSLoginV.h"
#import "SLBSFastLoginV.h"

@interface SLBSLoginVC ()
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation SLBSLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载view
    [self setUp];
}

-(void)setUp{
    self.midView.backgroundColor = [UIColor clearColor];
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    /*
     为屏幕适配考虑，从xib加载后要设置frame
     在viewDidLayoutSubviews布局
     */
    //登录界面
    SLBSLoginV * lgView = [SLBSLoginV loginView];
    
    [self.midView addSubview:lgView];
    
    //注册界面
    SLBSLoginV * rgView = [SLBSLoginV registerView];

    [self.midView addSubview:rgView];
    
    //底部view
    SLBSFastLoginV * fast = [SLBSFastLoginV fastLoginView];
    [self.bottomView addSubview:fast];
}

-(void)viewDidLayoutSubviews{
    //一定要调用super
    [super viewDidLayoutSubviews];
    
    SLBSLoginV * lgView = self.midView.subviews[0];
    lgView.frame = CGRectMake(0, 0, self.midView.sl_width * 0.5, self.midView.sl_height);
    
    SLBSLoginV * rgView = self.midView.subviews[1];
    rgView.frame = CGRectMake(lgView.sl_width, 0, self.midView.sl_width * 0.5, self.midView.sl_height);
    
    SLBSFastLoginV * fast = self.bottomView.subviews[0];
    fast.frame = self.bottomView.bounds;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //撤销键盘第一响应者
    [self.view endEditing:YES];
}

#pragma mark - 顶部占位图
//关闭
- (IBAction)didClickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册
- (IBAction)didClickRegister:(UIButton *)sender {
    
    //NSInteger strongest = sender.selected == YES ? 1 : -1;
    
    //平移
    //方式二:改约束(如果设置了约束一定不要改x)
    self.leadCons.constant = self.leadCons.constant == 0 ? -self.midView.sl_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        //方式一:改transform
        //self.midView.transform = CGAffineTransformTranslate(self.midView.transform, strongest * ScreenW, 0);
        [self.view layoutIfNeeded];
    }];
    sender.selected = !sender.selected;
}


#pragma mark - 中间占位图

#pragma mark - 底部占位图



@end
