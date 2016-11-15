//
//  SLBSAdVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/15.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSAdVC.h"
#import "SLBSBaseTabBarC.h"
#import "AFNetworking.h"

#define code2 @"uhNY5R9RHRs_fR4RiikPRdPfFhGB5H0hpyRqniud5yw-uh7dUZfhIWdGULPxPa3dg1D8na3sFh4-IjYknj0hUZTqn1TdFhPCpyfqFMF-TNqGujYznH64rHf4m1N9P1nzmWmzmynvrARvPj0srHKBuHRkuiuL5HTdnauBuZcqnH08ni3kFh7sIjY3FMKo5yPEUi41TZFGIAN9TZ08mh7GTv-BuAChTvkEIZw4TARqRLK_mgPCFhw-UWYzFhq15y-ETzuVmg0qniuduA-b5H7BnhubPvRzPjw-nH0smvu-nyfznynkPHn4PWckuW6kPvR4nj6YuyDhTLIG5HDhmgKspyfquHcYrj0LuHRhmLNz5H0hTZF-UAq9ujYsFh-buhDqfH64fW0sPRRVnRR4PaYYwWPAQH6drjnVwDm1fH04nbmznRndFh7WIjdrfiknRakDHakKRDthTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhP1Tv-b5H-WrWckrWu9rW6zrhmzrW6Yx7FbHMFiXhwhuhwkTMNMIYkNHDuEFhckPjT4nWDdPjfz5HDhUA6qPWmLFh7spyfqnWnvrHRYPBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFhFzujd9TZK_uiu1UWdKrj-anj0dwiYkwHbYQHwAnYmVrjR3nzdDwWPKnjbzwWckf1RhmgKsIhNz5Hf8Pi3kFh-1TjYYPW0snauWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxPa3dFh7Y5HchmLNGujYkmWFhujI-nWfYuHDsnAPhuH7bnW7WnHR1rHmznym3nHI-rH03PAN9Fh6qnHn1PauYmycqnau1IjYkPjT4nWDdPjfzQWbsPj6dPauYTjdGRA9EUhR4QjDhuMIY5H0hUy7G5H0hTvN85RwFRzkafRs_RYdHQDdKRakywakHiDt_RY-rQ7P5NikKfYn_HR-jQDIfRzkjHYY_fNc_NbwPQDdRHzkDiNchTvwW5HDdnjnYQWmLrHm3raszPWRsri3kn1mLnHbhmLnqnHcvP1csPyPhuHFhuj9-nAuhrHbvnjnzn1bvnjfYnvchTv7_5iu85HDhTvd15HDhTLTqP1RsFhd-UHYkPH01Pa3vP1bvrj6_nWmdnjb8nHnvP1D4FMDquHcYrj0LuHNxmLKzFhk9Uhw1mv7suHYsFBfb"

@interface SLBSAdVC ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainView;
@property (weak, nonatomic) IBOutlet UIButton *skipBtn;

@end

@implementation SLBSAdVC

/*
 广告接口:
 @"http://mobads.baidu.com/cpro/ui/mads.php? code2 = uhNY5R9RHRs_fR4RiikPRdPfFhGB5H0hpyRqniud5yw-uh7dUZfhIWdGULPxPa3dg1D8na3sFh4-IjYknj0hUZTqn1TdFhPCpyfqFMF-TNqGujYznH64rHf4m1N9P1nzmWmzmynvrARvPj0srHKBuHRkuiuL5HTdnauBuZcqnH08ni3kFh7sIjY3FMKo5yPEUi41TZFGIAN9TZ08mh7GTv-BuAChTvkEIZw4TARqRLK_mgPCFhw-UWYzFhq15y-ETzuVmg0qniuduA-b5H7BnhubPvRzPjw-nH0smvu-nyfznynkPHn4PWckuW6kPvR4nj6YuyDhTLIG5HDhmgKspyfquHcYrj0LuHRhmLNz5H0hTZF-UAq9ujYsFh-buhDqfH64fW0sPRRVnRR4PaYYwWPAQH6drjnVwDm1fH04nbmznRndFh7WIjdrfiknRakDHakKRDthTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhP1Tv-b5H-WrWckrWu9rW6zrhmzrW6Yx7FbHMFiXhwhuhwkTMNMIYkNHDuEFhckPjT4nWDdPjfz5HDhUA6qPWmLFh7spyfqnWnvrHRYPBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFhFzujd9TZK_uiu1UWdKrj-anj0dwiYkwHbYQHwAnYmVrjR3nzdDwWPKnjbzwWckf1RhmgKsIhNz5Hf8Pi3kFh-1TjYYPW0snauWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxPa3dFh7Y5HchmLNGujYkmWFhujI-nWfYuHDsnAPhuH7bnW7WnHR1rHmznym3nHI-rH03PAN9Fh6qnHn1PauYmycqnau1IjYkPjT4nWDdPjfzQWbsPj6dPauYTjdGRA9EUhR4QjDhuMIY5H0hUy7G5H0hTvN85RwFRzkafRs_RYdHQDdKRakywakHiDt_RY-rQ7P5NikKfYn_HR-jQDIfRzkjHYY_fNc_NbwPQDdRHzkDiNchTvwW5HDdnjnYQWmLrHm3raszPWRsri3kn1mLnHbhmLnqnHcvP1csPyPhuHFhuj9-nAuhrHbvnjnzn1bvnjfYnvchTv7_5iu85HDhTvd15HDhTLTqP1RsFhd-UHYkPH01Pa3vP1bvrj6_nWmdnjb8nHnvP1D4FMDquHcYrj0LuHNxmLKzFhk9Uhw1mv7suHYsFBfb"
 */


#warning TODO:解析数据

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLaunchImage];
    [self loadAdDate];
}


#pragma mark - 请求广告信息
-(void)loadAdDate
{
    //1.创建请求会话管理者
    AFHTTPSessionManager * mgr = [[AFHTTPSessionManager alloc] init];
    //failed: unacceptable content-type: text/html"  响应头
    if(!mgr.responseSerializer){
        mgr.responseSerializer = [AFJSONResponseSerializer new];
    }
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    //2.拼接参数
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    parameters[@"code2"] = code2;
    //3.发送请求
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        SLog(@"下载进度:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        SLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SLog(@"请求失败：%@",error);
    }];
}

//设置启动图片
-(void)setUpLaunchImage
{
    //屏幕适配
    /*
     6p:LaunchImage-800-Portrait-736h@3x
     6:LaunchImage-800-667h@2x
     5:LaunchImage-568h@2x
     4:LaunchImage@2x
     */
    
    UIImage * image;
    //判断版本
    if (iPhone6P) {
        //6p
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }else if (iPhone6){
        //6
        image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    }else if (iPhone5){
        //5
        image = [UIImage imageNamed:@"LaunchImage-568h@2x"];
    }else if (iPhone4){
        //4
        image = [UIImage imageNamed:@"LaunchImage@2x"];
    }
    self.LaunchImageView.image = image;
}

//跳过按钮点击
- (IBAction)skipBtnClick:(UIButton *)sender {
    SLBSBaseTabBarC * vc = [[SLBSBaseTabBarC alloc] init];
    [UIApplication sharedApplication].windows.firstObject.rootViewController = vc;
}

@end
