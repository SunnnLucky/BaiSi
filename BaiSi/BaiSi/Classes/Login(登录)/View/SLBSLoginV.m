//
//  SLBSLoginV.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/19.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSLoginV.h"

@interface SLBSLoginV()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation SLBSLoginV

+(instancetype)loginView{
    return [[NSBundle mainBundle] loadNibNamed:@"SLBSLoginV" owner:nil options:nil].firstObject;
}

+(instancetype)registerView{
    return [[NSBundle mainBundle] loadNibNamed:@"SLBSLoginV" owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //让按钮背景图片不要被拉伸
    UIImage * image =  self.loginBtn.currentBackgroundImage;
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    //清空背景颜色
    self.backgroundColor = [UIColor clearColor];
}

@end
