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

static NSString * const ID = @"subTagCell";

@interface SLBSSubTagTVC ()
//模型数组
@property(nonatomic,strong) NSMutableArray<SLBSSubTagItem *> * itemArray;
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
}

//请求数据
-(void)loadData
{
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * responseObject) {
        self.itemArray = [SLBSSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        SLog(@"%@",self.itemArray);
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
    cell.block = ^(SLBSSubTagItem * item){
        SLog(@"“%@”按钮---点击了订阅",item.theme_name);
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
