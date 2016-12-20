//
//  SLBSSeeBigPicVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSSeeBigPicVC.h"
#import "UIImageView+WebCache.h"
#import "SVProgressHUD.h"
#import <Photos/Photos.h>

@interface SLBSSeeBigPicVC ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) UIImageView * imageView;

@end

@implementation SLBSSeeBigPicVC

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:self.item.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if(!image) return ;
            self.saveButton.enabled = YES;
        }];
        _imageView.sl_width = ScreenW;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.bounces = NO;
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButton:)]];
    [self.view insertSubview:scrollView atIndex:0];
    
    [scrollView addSubview:self.imageView];
    CGFloat w = ScreenW;
    CGFloat h = w * self.item.height / self.item.width;
    self.imageView.frame = CGRectMake(0, 0, w, h);
    if (h <= ScreenH) {
        self.imageView.center = self.view.center;
    }else{
        scrollView.contentSize = CGSizeMake(w, h);
    }
    CGFloat maxScale = self.item.height / h;
    if (maxScale > 1) {
        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;
    }
    
}

- (IBAction)backButton:(id)sender {
    [SVProgressHUD dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    //获取权限后再保存
    //请求/检查访问权限 : 如果用户还没做出选择，会自动弹窗，做出选择后执行block；如果之前已经做出选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(status == PHAuthorizationStatusDenied) [SVProgressHUD showErrorWithStatus:@"请开启访问相册权限"];
            if(status == PHAuthorizationStatusAuthorized) [self saveImage];
        });
    }];
}

#pragma mark - 保存图片操作
-(void)saveImage{
    //1.保存图片到相机胶卷
    NSError * error = nil;
    __block PHObjectPlaceholder * Placeholder = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        Placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset;
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    
    //2.创建自定义相册
    PHAssetCollection * myAppCollection = [self createdCollection];
    if (!myAppCollection) {
        [SVProgressHUD showErrorWithStatus:@"相册创建失败"];
        return;
    }
    
    //3.添加保存图片到自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:myAppCollection];
        [request insertAssets:@[Placeholder] atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

#pragma mark - 获得当前APP相册
-(PHAssetCollection *)createdCollection{
    //取出项目名称
    NSString * title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    //获取手机里的自定义相册
    PHFetchResult<PHAssetCollection *> * collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    //遍历自定义相册，取出当前项目相册
    for (PHAssetCollection * collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) return collection;
    }
    
    //如果没取到就创建
    
    __block NSString * ID = nil;
    NSError * error = nil;
    //同步创建 避免取相册时相册为空
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //获取相册占位对象标识
        ID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&error];
    if (error) return nil;
    //通过占位对象标识获取相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[ID] options:nil].firstObject;
}

-(void)dealloc{
    [SVProgressHUD dismiss];
}

#pragma mark - scrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
