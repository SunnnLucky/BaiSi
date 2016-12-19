//
//  SLBSSeeBigPicVC.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSSeeBigPicVC.h"
#import "UIImageView+WebCache.h"

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    
}

#pragma mark - scrollViewDelegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
