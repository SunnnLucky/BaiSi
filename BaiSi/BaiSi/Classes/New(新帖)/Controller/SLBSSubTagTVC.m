//
//  SLBSSubTagTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/17.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSSubTagTVC.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "SLBSSubTagItem.h"
#import "SLBSSubTagCell.h"
#import "SVProgressHUD.h"

static NSString * const ID = @"subTagCell";

@interface SLBSSubTagTVC ()
//模型数组
@property(nonatomic,strong) NSMutableArray<SLBSSubTagItem *> * itemArray;

@property(nonatomic,weak)AFHTTPSessionManager * mgr;
@end

@implementation SLBSSubTagTVC

#pragma mark - 懒加载
-(NSMutableArray *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
    [self loadData];
}

//初始化
-(void)setUp{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SLBSSubTagCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    //cell无选中效果
    self.tableView.allowsSelection = NO;
    //清除分割线
    //[self clearSeparator];
    
    //提示用户正在加载数据
    [SVProgressHUD showWithStatus:@"正在加载..."];
}

//请求数据
-(void)loadData
{
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [mgr GET:SLBSCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * responseObject) {
        //清除提示
        [SVProgressHUD dismiss];
        
        self.itemArray = [SLBSSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //清除提示
        [SVProgressHUD dismiss];
    }];
}

//当界面要消失的时候调用
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //清除提示
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}

#pragma mark - UITableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLBSSubTagCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    /*
     使用注册Cell就不需要此步加载了
     if (!cell) {
     cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SLBSSubTagCell class]) owner:nil options:nil].firstObject;
     }
     */
    
    cell.item = self.itemArray[indexPath.row];
    cell.block = ^(SLBSSubTagItem * item , BOOL isOn){
        //NSInteger strongest = sender.selected == YES ? 1 : -1;
        if (isOn) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@订阅成功",item.theme_name]];
        }else{
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"%@取消成功",item.theme_name]];
        }
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - 清除分割线

//方式一:
- (void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


/*
 //方式二:
 -(void)clearSeparator{
 //1.清除分割线
 self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
 //2.tableView背景改为分割线颜色
 self.tableView.backgroundColor = SLColor(220, 220, 221);
 //3.cell内部重写setframe方法
 }
 */

@end
