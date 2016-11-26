//
//  SLBSEssenceVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceVC.h"


@interface SLBSEssenceVC ()

@property(nonatomic,weak)UIButton * selectedBtn;
@property(nonatomic,weak)UIView * theLine;

@end

@implementation SLBSEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条
    [self setUpNavBar];
    //scrollView
    [self setUpScrollView];
    //titleView
    [self setUpTitleView];
}

#pragma mark - ScrollView
-(void)setUpScrollView{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
}

#pragma mark - TitleView
-(void)setUpTitleView{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenW, 35)];
    titleView.backgroundColor = SLColor(244, 244, 244);
    [self.view addSubview:titleView];
    //添加标题按钮
    NSArray * nameArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    [self addTitleButtonWithView:titleView andNameArray:nameArray];
    //添加底部线
    [self addTheLine:titleView];
}

-(void)addTitleButtonWithView:(UIView *)view andNameArray:(NSArray<NSString *> *)nameArray{
    int count = 5;
    float y = 0;
    float w = view.sl_width / count;
    float h = view.sl_height;
    for (int i = 0 ; i < count ; i++) {
        UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(i * w, y, w, h);
        [titleBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //设置选中状态下的高亮状态  或者重写按钮的setHighlighted方法，不进入高亮
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected | UIControlStateHighlighted];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            titleBtn.selected = YES;
            self.selectedBtn = titleBtn;
        }
        [view addSubview:titleBtn];
    }
}

-(void)addTheLine:(UIView *)view{
    UIButton * firstBtn = view.subviews.firstObject;
    UIView * theLine = [[UIView alloc] init];
    theLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    CGFloat lineW = [firstBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName: firstBtn.titleLabel.font}].width;
    CGFloat lineH = 1;
    CGFloat lineY = view.sl_height - lineH;
    theLine.frame = CGRectMake(0, lineY, lineW, lineH);
    theLine.sl_centerX = firstBtn.sl_centerX;
    [view addSubview: theLine];
    self.theLine = theLine;
}

-(void)titleBtnClick:(UIButton *)titleBtn{
    self.selectedBtn.selected = NO;
    titleBtn.selected = YES;
    self.selectedBtn = titleBtn;
    [UIView animateWithDuration:0.25 animations:^{
        //方法一:求当前title里字体宽度
//        self.theLine.sl_width = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:titleBtn.titleLabel.font}].width;
        //方式二:直接等于lable宽度
        self.theLine.sl_width = titleBtn.titleLabel.sl_width;
        self.theLine.sl_centerX = titleBtn.sl_centerX;
    }];
    
}
#pragma mark - 设置导航条
-(void)setUpNavBar{
    //去除底部边线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
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
