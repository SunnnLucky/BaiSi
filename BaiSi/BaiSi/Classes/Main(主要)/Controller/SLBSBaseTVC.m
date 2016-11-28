//
//  SLBSBaseTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSBaseTVC.h"

@interface SLBSBaseTVC ()

@end

static NSString * const ID = @"BaseID";

@implementation SLBSBaseTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = randomColor;
    //滚动范围超过底部tabbar
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBarH, 0);
    SLog(@"%@",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
