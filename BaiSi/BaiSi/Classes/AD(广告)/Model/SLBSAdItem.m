//
//  SLBSAdItem.m
//  BaiSi
//
//  Created by 孙磊 on 2016/11/16.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSAdItem.h"
#import <objc/runtime.h>

@implementation SLBSAdItem


/*
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    SLBSAdItem *mod = [[SLBSAdItem alloc] init];
    
    // 获取属性数组
    NSArray *array = [mod getProperties];
    
    // 遍历属性数组 -> 赋值
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        // 将属性当作 key 值.
        NSString *key = obj;
        
        if (dict[key]) {
            
            [mod setValue:dict[key] forKey:key];
        }
        
    }];
    
    // 利用上面遍历属性数组,得到的数据可以保证肯定有值,防止 KVC 赋值错误.
    // [mod setValuesForKeysWithDictionary:dict];
    
    return mod;
}

// 动态的获取类的属性.
- (NSMutableArray *)getProperties
{
    // 参数1: 表明要获取哪一个类的属性
    // 参数2: 需要一块地址来存放属性的数量.
    
    unsigned int count;
    // 获取属性数组
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    
    NSMutableArray *array = [NSMutableArray array];
    
    // 遍历属性数组,获取其中的值.
    for (int i = 0 ; i < count; i++) {
        
        // 获取属性数组中的每一个属性
        objc_property_t pro = properties[i];
        
        // 得到属性名称.
        const char *name = property_getName(pro);
        
        // 将 C语言的数据类型转换成 OC 的数据类型
        NSString *property = [[NSString alloc] initWithUTF8String:name];
        
        // 将属性放到一个数组中
        [array addObject:property];
        
    }
    
    return array;
}
*/

@end
