//
//  SLBSEssenceBaseTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/29.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSEssenceBaseTVC.h"

static NSString * const ID = @"BaseID";

@implementation SLBSEssenceBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor = randomColor;
    //滚动范围超过底部tabbar
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarH, 0);
    [self setUpNotification];
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
}

-(void)titleViewButtonDidRepeatClick{
    [self TabBarButtonDidRepeatClick];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-----%zd",NSStringFromClass([self class]),indexPath.row];
    return cell;
}

@end
