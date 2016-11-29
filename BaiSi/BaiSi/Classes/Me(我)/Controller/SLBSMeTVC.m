//
//  SLBSMeTVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/10.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSMeTVC.h"
#import "SLBSSettingTVC.h"
#import "SLBSMeCell.h"
#import "SLBSLoginVC.h"
#import "SLBSMeItem.h"
#import <SafariServices/SafariServices.h>
#import "SLBSWebViewVC.h"

#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (ScreenW - (cols - 1) * margin) / cols

@interface SLBSMeTVC ()<UICollectionViewDataSource , UICollectionViewDelegate , SFSafariViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray<SLBSMeItem *> * array;

@property(nonatomic,weak)UICollectionView * collection;

@end

@implementation SLBSMeTVC

static NSString * const ID = @"collectionCell";


#pragma mark - 处理数据
-(void)setArray:(NSMutableArray<SLBSMeItem *> *)array{
    //去掉相同的元素
    for (int i = 0 ; i < array.count; i++) {
        for(int j = (int)array.count - 1; j > i ; j--){
            if ([array[j].name isEqualToString:array[i].name]) {
                [array removeObject:array[j]];
            }
        }
    }
    
    //添加空位
    NSInteger count = array.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0 ; i < exter; i++) {
            SLBSMeItem * item = [[SLBSMeItem alloc] init];
            [array addObject:item];
        }
    }
    
    _array = array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //cell无选中效果
//    self.tableView.allowsSelection = NO;
    //设置导航条
    [self setUpNavBar];
    //设置底部视图
    [self setUpFooterView];
    //展示cell内容
    [self loadData];
    //处理cell之间间距
    [self cellMargin];
}

#pragma mark - cellMargin
-(void)cellMargin{
    //默认tableView分组样式，有额外的头部和尾部间距
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    //第一个cell的Y值是35
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, +10, 0);
}

#pragma mark - loadData
//http://api.budejie.com/api/api_open.php
-(void)loadData{
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        NSArray * responseArray = responseObject[@"square_list"];
        self.array = [SLBSMeItem mj_objectArrayWithKeyValuesArray:responseArray];
        
        //获取数据后重新设置collection高度
        NSInteger count = self.array.count;
        NSInteger rows = (count - 1) / cols + 1; //cols每行个数
        self.collection.sl_height = rows * itemWH;
        //重新设置TableView的footer ---> 因为TableView的滚动范围是自己计算的
        self.tableView.tableFooterView = self.collection;
        
        [self.collection reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ALog(@"请求失败");
    }];
}

#pragma mark - 设置footView
-(void)setUpFooterView{
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    
    //设置cell间距
    
    flow.itemSize = CGSizeMake(itemWH, itemWH);
    flow.minimumLineSpacing = margin;
    flow.minimumInteritemSpacing = margin;
    
    UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:flow];
    collection.backgroundColor = self.tableView.backgroundColor;
    
    [collection registerNib:[UINib nibWithNibName:NSStringFromClass([SLBSMeCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollEnabled = NO;
    
    self.collection = collection;
    self.tableView.tableFooterView = collection;
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
//    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SLBSMeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    cell.item = self.array[indexPath.row];
    return cell;
}

#pragma mark - 设置导航条
-(void)setUpNavBar{
    //左边按钮
    UIBarButtonItem * setting = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] andHighImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTarget:self action:@selector(setting)];
    UIBarButtonItem * moon = [UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] andSelImage:[UIImage imageNamed:@"mine-moon-icon-click"] addTarget:self action:@selector(moon:)];
    
    self.navigationItem.rightBarButtonItems = @[setting,moon];
    //中间按钮
    self.navigationItem.title = @"我的";
}

//setting按钮点击
-(void)setting
{
    SLBSSettingTVC * setting = [[SLBSSettingTVC alloc] init];
//    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

//moon按钮点击
-(void)moon:(UIButton *)moon{
    moon.selected = !moon.selected;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"moon按钮点击了" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - tableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SLBSLoginVC * login = [[SLBSLoginVC alloc] init];
        [self presentViewController:login animated:YES completion:nil];
    };
    
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    /*
    //导入<SafariServices/SafariServices.h>头文件
    if(![self.array[indexPath.row].url containsString:@"http"]) return;
    //iOS9新特性
    SFSafariViewController * safar = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:self.array[indexPath.row].url]];
    [self presentViewController:safar animated:YES completion:nil];
    //成为SFSafariViewControllerDelegate，监听点击
     */
    
    //导入#import <WebKit/WebKit.h>
    if(![self.array[indexPath.row].url containsString:@"http"]) return;
    SLBSWebViewVC * webView = [[SLBSWebViewVC alloc] init];
    webView.url = self.array[indexPath.row].url;
    [self.navigationController pushViewController:webView animated:YES];
}
@end
