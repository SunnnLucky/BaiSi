//
//  SLBSTextField.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/21.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTextField.h"
#import "UITextField+placeholder.h"

@implementation SLBSTextField

/*
 TODO:
 1.光标变白色
 2.占位文字变白色
 */

-(void)awakeFromNib{
    [super awakeFromNib];
    //1.设置光标变白色
    self.tintColor = [UIColor whiteColor];
    //2.占位文字变灰色
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    self.placeholderLabelColor = [UIColor lightGrayColor];
    
    //监听文本框编辑:1.代理 2.通知 3.target
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    //结束编辑时恢复颜色
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
}

-(void)textBegin{
    //文本框开始编辑
    self.placeholderLabelColor = [UIColor whiteColor];
}

-(void)textEnd{
    self.placeholderLabelColor = [UIColor lightGrayColor];
}

@end
