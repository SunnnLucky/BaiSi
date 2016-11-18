//
//  SLBSSubTagCell.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/18.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLBSSubTagItem.h"

typedef void(^block)(SLBSSubTagItem *);

@interface SLBSSubTagCell : UITableViewCell

@property(nonatomic , strong) SLBSSubTagItem * item;

@property(nonatomic, copy) block block;

@end
