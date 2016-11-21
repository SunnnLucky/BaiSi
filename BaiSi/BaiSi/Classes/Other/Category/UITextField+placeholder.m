//
//  UITextField+placeholder.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/21.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "UITextField+placeholder.h"
#import <objc/message.h>

@implementation UITextField (placeholder)

+(void)load{
    //方法交换
    Method UITextFieldMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    // xmg_imageNamed
    Method SLBS_Method = class_getInstanceMethod(self, @selector(setSLBS_Placeholder:));
    // 交换方法实现
    method_exchangeImplementations(SLBS_Method, UITextFieldMethod);
}

-(void)setPlaceholderLabelColor:(UIColor *)placeholderLabelColor{
    //如果placeholderLabel为空的时候会导致赋值不成功
    //给成员属性赋值 runtime给系统的类添加成员属性
    objc_setAssociatedObject(self, @"placeholderLabelColor", placeholderLabelColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);//添加成员属性
    
    UILabel * placeholderLabel =  [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderLabelColor;
}

-(UIColor *)placeholderLabelColor{
    return objc_getAssociatedObject(self, @"placeholderLabelColor");
}

//每次设置占位文字的时候，再拿到之前保存的占位文字颜色重写设置
-(void)setSLBS_Placeholder:(NSString *)placeholder{
    [self setSLBS_Placeholder:placeholder];
    self.placeholderLabelColor = self.placeholderLabelColor;
}

@end
