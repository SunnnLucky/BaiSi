//
//  SLBSEssenceVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceVC.h"

#import "SLBSAllTVC.h"
#import "SLBSVideoTVC.h"
#import "SLBSVoiceTVC.h"
#import "SLBSPictureTVC.h"
#import "SLBSWordTVC.h"

static NSInteger const tagIndex = 1000;

@interface SLBSEssenceVC ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIButton * selectedBtn;
@property(nonatomic,weak)UIView * theLine;
@property(nonatomic,weak)UIView * titleView;
@property(nonatomic,weak)UIScrollView * scrollView;
@property(nonatomic,strong)NSMutableArray * btnArray;

@end

@implementation SLBSEssenceVC

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLColor(247, 247, 247);
    
    //设置导航条
    [self setUpNavBar];
    //加载子控制器
    [self setUpChildVC];
    //scrollView
    [self setUpScrollView];
    //titleView
    [self setUpTitleView];
}

#pragma mark - 初始化子控制器
-(void)setUpChildVC{
     [self addChildViewController:[SLBSAllTVC new]];
     [self addChildViewController:[SLBSVideoTVC new]];
     [self addChildViewController:[SLBSVoiceTVC new]];
     [self addChildViewController:[SLBSPictureTVC new]];
     [self addChildViewController:[SLBSWordTVC new]];
}

#pragma mark - ScrollView
-(void)setUpScrollView{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;    //分页
    scrollView.bounces = NO;
    scrollView.scrollsToTop = NO;    //点击状态栏不滚动
    scrollView.delegate = self;
    /*这里用懒加载 点击标题按钮的时候再创建
    for(int i = 0 ; i < self.childViewControllers.count ; i++){
        UIView * childView = self.childViewControllers[i].view;
        //frame默认有值，只设置x就好了
        childView.sl_x = scrollView.sl_width * i;
        childView.sl_y = TitlesViewH;
        childView.sl_height = scrollView.sl_height - NavBarMaxY - TitlesViewH;
        [scrollView addSubview:childView];
    }
     */
    scrollView.contentSize = CGSizeMake(scrollView.sl_width * self.childViewControllers.count, 0);
    self.scrollView = scrollView;
    //默认显示第0个控制器view
    [self addChildViewIntoScrollView:0];
    [self.view addSubview:scrollView];
}

#pragma mark - TitleView
-(void)setUpTitleView{
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarMaxY, ScreenW, TitlesViewH)];
    titleView.backgroundColor = SLColor(247, 247, 247);
    self.titleView = titleView;
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
        titleBtn.tag = i + tagIndex;
        [titleBtn setTitle:nameArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        //设置选中状态下的高亮状态  或者重写按钮的setHighlighted方法，不进入高亮
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected | UIControlStateHighlighted];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:titleBtn];
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
    if(self.selectedBtn == titleBtn){
        //通知子控制器
        [[NSNotificationCenter defaultCenter] postNotificationName:SLBSTitleViewButtonDidRepeatClickNotification object:nil];
    }
    
    [self scrollViewAndBtnClick:titleBtn];
}

-(void)scrollViewAndBtnClick:(UIButton *)titleBtn{
    self.selectedBtn.selected = NO;
    titleBtn.selected = YES;
    self.selectedBtn = titleBtn;
    
    NSInteger ratio = titleBtn.tag - tagIndex;
    
    [UIView animateWithDuration:0.25 animations:^{
        //方法一:求当前title里字体宽度
        //        self.theLine.sl_width = [titleBtn.currentTitle sizeWithAttributes:@{NSFontAttributeName:titleBtn.titleLabel.font}].width;
        //方式二:直接等于lable宽度
        self.theLine.sl_width = titleBtn.titleLabel.sl_width;
        self.theLine.sl_centerX = titleBtn.sl_centerX;
        //滚动到对应控制器
        self.scrollView.contentOffset = CGPointMake(ratio * ScreenW, self.scrollView.contentOffset.y);
    }completion:^(BOOL finished) {
        //动画结束再创建
        [self addChildViewIntoScrollView:ratio];
    }];
    
    //处理scrollview点击状态栏可否滚动到顶部
    for (int i = 0 ; i < self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        if (!vc.isViewLoaded) continue;     //如果没加载就不设置
        
        UIScrollView * scrollView = (UIScrollView *)vc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]])  continue;
        
        scrollView.scrollsToTop = (i == ratio);
    }
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page = round(scrollView.contentOffset.x / scrollView.frame.size.width) ;
    //SLog(@"%lf  ,  %d",scrollView.contentOffset.x,page);
    //SLog(@"%d",page);
//    UIButton * btn = [self.titleView viewWithTag:page + tagIndex];
//    [self scrollViewAndBtnClick:btn];
    [self scrollViewAndBtnClick:self.btnArray[page]];
}

#pragma mark - 其他方法

//创建子控制器
-(void)addChildViewIntoScrollView:(NSInteger)index{
    UIView * childView = self.childViewControllers[index].view;
    
    //如果被添加过了，就返回
    //方法一:
    if(childView.superview) return;
    //方法二:
    //if(childView.window) return;
    
    childView.sl_x = self.scrollView.sl_width * index;
    childView.sl_y = TitlesViewH;
    childView.sl_height = self.scrollView.sl_height - NavBarMaxY - TitlesViewH;
    [self.scrollView addSubview:childView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
}

@end
