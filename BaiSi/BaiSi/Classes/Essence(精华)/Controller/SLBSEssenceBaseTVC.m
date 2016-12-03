//
//  SLBSEssenceBaseTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/29.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceBaseTVC.h"

static NSString * const ID = @"BaseID";

@interface SLBSEssenceBaseTVC()

@property(nonatomic,assign) NSInteger dataCount;
@property(nonatomic,weak)UIView * headerView;
@property(nonatomic,weak)UIView * footerView;
@property(nonatomic,weak)UILabel * footerLable;
@property(nonatomic,weak)UILabel * headerLable;
@property(nonatomic,weak)UIActivityIndicatorView * headerAct;
@property(nonatomic,weak)UIActivityIndicatorView * footerAct;
@property(nonatomic,weak)UIImageView * arrow;
@property(nonatomic) CGAffineTransform arrowTransform;
@property(nonatomic,assign,getter=isHeaderLoading)BOOL headerViewLoading;
@property(nonatomic,assign,getter=isFooterLoading)BOOL footerViewLoading;

@end

@implementation SLBSEssenceBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = randomColor;
    //滚动范围超过底部tabbar
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarH, 0);
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.backgroundColor = SLColor(247, 247, 247);
    
    //模拟数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dataCount = 30;
        [self.tableView reloadData];
    });
    
    //初始化通知
    [self setUpNotification];
    //初始化刷新
    [self setUpRefresh];
}

#pragma mark - Refresh
-(void)setUpRefresh{
    [self setUpAdView];
    [self setUpHeaderView];
    [self setUpFooterView];
}

-(void)setUpAdView{
    UILabel * adView = [[UILabel alloc] init];
    adView.text = @"Suns_作品";
    adView.frame = CGRectMake(0, 0, 0, 35);
    adView.backgroundColor = SLColor(247, 247, 247);
    adView.textColor = [UIColor blackColor];
    adView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = adView;
}

-(void)setUpHeaderView{
    //下拉刷新，不添加到headerView上,因为可能headView会添加其他东西
    UIView * headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, -35, self.tableView.sl_width, 35);
    self.headerView = headerView;
    
    //顶部字体
    UILabel * headerLable = [[UILabel alloc] init];
    headerLable.text = @"下拉刷新内容";
    headerLable.font = [UIFont systemFontOfSize:12];
    headerLable.frame = headerView.bounds;
    headerLable.backgroundColor = SLColor(247, 247, 247);
    headerLable.textAlignment = NSTextAlignmentCenter;
    self.headerLable = headerLable;
    [headerView addSubview:headerLable];
    
    //菊花控件
    UIActivityIndicatorView * headerAct = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //缩放
    headerAct.transform = CGAffineTransformScale(headerView.transform, 0.7, 0.7);
    headerAct.sl_centerY = headerView.sl_height * 0.5;
    headerAct.sl_x = 125;
    headerAct.alpha = 0.5;
    headerAct.color = [UIColor blackColor];
    self.headerAct = headerAct;
    [headerView addSubview:headerAct];
    
    //箭头
    UIImageView * arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down"]];
    arrow.frame = CGRectMake(0, 0, 10, 10);
    arrow.center = headerAct.center;
    self.arrowTransform = arrow.transform;
    [headerView addSubview:arrow];
    self.arrow = arrow;
    
    [self.tableView addSubview:headerView];
}

-(void)setUpFooterView{
    //footerView
    UIView * footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.sl_width, 35);
    self.footerView = footerView;
    
    UILabel * footerLable = [[UILabel alloc] init];
    footerLable.text = @"上拉加载更多...";
    footerLable.font = [UIFont systemFontOfSize:12];
    footerLable.frame = footerView.bounds;
    footerLable.backgroundColor = SLColor(247, 247, 247);
    footerLable.textAlignment = NSTextAlignmentCenter;
    self.footerLable = footerLable;
    [footerView addSubview:footerLable];
    
    UIActivityIndicatorView * footerAct = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    footerAct.transform = CGAffineTransformScale(footerAct.transform, 0.7, 0.7);
    footerAct.sl_centerY = footerView.sl_height * 0.5;
    footerAct.sl_x = 130;
    footerAct.alpha = 0.5;
    footerAct.color = [UIColor blackColor];
    self.footerAct = footerAct;
    [footerView addSubview:footerAct];
    
    self.tableView.tableFooterView = footerView;
}

#pragma mark - Notification
-(void)setUpNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TabBarButtonDidRepeatClick) name:SLBSTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleViewButtonDidRepeatClick) name:SLBSTitleViewButtonDidRepeatClickNotification object:nil];
}

-(void)TabBarButtonDidRepeatClick{
    //如果当前点击的不是精华控制器，就返回
    if (self.view.window == nil) return;
    //如果显示在中间的不是all界面，就返回
    if (self.tableView.scrollsToTop == NO) return;
    //刷新...
    SLog(@"%s-------%@",__func__,[self class]);
    [self headerBeginRefreshing];
}

-(void)titleViewButtonDidRepeatClick{
    [self TabBarButtonDidRepeatClick];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.footerView.hidden = (self.dataCount == 0);
    return self.dataCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-----%zd",NSStringFromClass([self class]),indexPath.row];
    return cell;
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //====下拉刷新====
    [self dealHeader];
    //====上拉加载====
    [self dealFooter];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isHeaderLoading) return;
    float offset = - ( self.tableView.contentInset.top + self.headerView.sl_height );

    if (self.tableView.contentOffset.y <= offset) {
        [self headerBeginRefreshing];
    }
}

#pragma mark - header & footer 业务逻辑
-(void)dealHeader{
    if (self.isHeaderLoading) return;
    float offset = - ( self.tableView.contentInset.top + self.headerView.sl_height );
    if (self.tableView.contentOffset.y <= offset) {
        [UIView animateWithDuration:0.25 animations:^{
            self.arrow.transform = CGAffineTransformMakeRotation(-M_PI);
        }];
        self.headerLable.text = @"松开刷新内容";
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.arrow.transform = self.arrowTransform;
        }];
        self.headerLable.text = @"下拉刷新内容";
    }
}

-(void)dealFooter{
    //如果没有内容就不判断
    if (self.tableView.contentSize.height == 0) return;
    //如果是下拉就不处理
    if (self.tableView.contentOffset.y <= self.tableView.contentInset.top) return;
    if (self.isFooterLoading) return;
    
    //当scrollView的偏移量y值 >= offSetY时，就代表footerView完全出现
    float offSetY = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.sl_height;

    if (self.tableView.contentOffset.y >= offSetY) {
        [self footerBeginRefreshing];
    }
}

#pragma mark - header

-(void)headerBeginRefreshing{
    if (self.isHeaderLoading) return;
    float offset = - ( self.tableView.contentInset.top + self.headerView.sl_height );
    __block UIEdgeInsets inset = self.tableView.contentInset;
    self.headerViewLoading = YES;
    self.headerLable.text = @"正在刷新...";
    self.arrow.hidden = YES;
    [self.headerAct startAnimating];
    //动画内写，要不然会闪
    [UIView animateWithDuration:0.25 animations:^{
        inset.top = -offset;
        self.tableView.contentInset = inset;
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, offset);
    }];
    [self headerLoadData];
}

-(void)headerEndRefreshing{
    __block UIEdgeInsets inset = self.tableView.contentInset;
    [self.headerAct stopAnimating];
    self.headerViewLoading = NO;
    self.arrow.transform = self.arrowTransform;
    
    [UIView animateWithDuration:0.25 animations:^{
        inset.top = 0;
        self.tableView.contentInset = inset;
    }];
    
    self.arrow.hidden = NO;
}

#pragma mark - footer

-(void)footerBeginRefreshing{
    if (self.isFooterLoading) return;
    [self.footerAct startAnimating];
    self.footerViewLoading = YES;
    self.footerLable.text = @"正在加载...";
    [self footerLoadData];
}

-(void)footerEndRefreshing{
    [self.footerAct stopAnimating];
    self.footerLable.text = @"上拉加载更多...";
    self.footerViewLoading = NO;
}

#pragma mark - header & footer  loadData
/**
 下拉刷新
 */
-(void)headerLoadData{
    //模拟数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SLog(@"请求数据");
        [self headerEndRefreshing];
        
        [self.tableView reloadData];
    });
}

/**
 上拉加载
 */
-(void)footerLoadData{
    //发送请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self footerEndRefreshing];
        self.dataCount += 5;
        [self.tableView reloadData];
    });
}
@end
