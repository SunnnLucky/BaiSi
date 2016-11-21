//
//  SLBSMeCell.h
//  BaiSi
//
//  Created by 孙磊 on 2016/11/21.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLBSMeItem;
@interface SLBSMeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property(nonatomic , strong)SLBSMeItem * item;
@end
