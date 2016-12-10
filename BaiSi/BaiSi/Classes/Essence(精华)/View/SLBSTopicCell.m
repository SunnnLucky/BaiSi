//
//  SLBSTopicCell.m
//  BaiSi
//
//  Created by 孙磊 on 2016/12/7.
//  Copyright © 2016年 Sun. All rights reserved.
//

#import "SLBSTopicCell.h"
#import "SLBSEssenceItem.h"
#import "UIImageView+WebCache.h"

@interface SLBSTopicCell()
// 控件的命名 -> 功能 + 控件类型
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UILabel *hotComment;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@end

@implementation SLBSTopicCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.hotView.backgroundColor = SLColor(247, 247, 247);
}

-(void)setTopic:(SLBSEssenceItem *)topic{
    _topic = topic;
    //头像
    UIImage * placeholderImage = [UIImage circleImageName:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholderImage options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.profileImageView.image = [image circleImage];
    }];
    
    //昵称
    self.nameLabel.text = topic.name;
    //通过时间
    self.passtimeLabel.text = topic.passtime;
    //内容
    self.text_label.text = topic.text;
    //顶
    [self setupBottomTitle:self.dingButton andName:@"顶" WithNumber:topic.ding];
    //踩
    [self setupBottomTitle:self.caiButton andName:@"踩" WithNumber:topic.cai];
    //转发
    [self setupBottomTitle:self.repostButton andName:@"分享" WithNumber:topic.repost];
    //赞
    [self setupBottomTitle:self.commentButton andName:@"评论" WithNumber:topic.comment];
    //最热评论
    if(topic.top_cmt.count){//有值
        NSString * content = topic.top_cmt[0][@"content"];
        NSString * name = topic.top_cmt[0][@"user"][@"username"];
        if (content.length && name.length) {
            NSMutableAttributedString * mutable = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ : %@",name,content]];
            NSRange range = [name rangeOfString:name];
            [mutable addAttribute:NSForegroundColorAttributeName value:SLColor(85, 195, 255) range:range];
            self.hotView.hidden = NO;
            self.hotComment.attributedText = mutable;
        }else {
            self.hotView.hidden = YES;
        }
    }else {//没值
        self.hotView.hidden = YES;
    }
}

//应该把中文参数放在最后面。。。因为会影响后续代码提示
-(void)setupBottomTitle:(UIButton *)btn andName:(NSString *)name WithNumber:(NSInteger)number{
    if(number >= 10000){
        [btn setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [btn setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [btn setTitle:name forState:UIControlStateNormal];
    }
}

-(void)setFrame:(CGRect)frame{
    frame.size.height -= Marin;
    frame.origin.x += Marin;
    frame.size.width -= Marin * 2;
    [super setFrame:frame];
}

@end
