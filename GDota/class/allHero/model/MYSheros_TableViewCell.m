//
//  MYSheros_TableViewCell.m
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSheros_TableViewCell.h"

@implementation MYSheros_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //图片
        UIImageView *heroImage = [[UIImageView alloc]init];
        [self.contentView addSubview:heroImage];
        [heroImage setContentMode:UIViewContentModeScaleAspectFit];
        //名字
        UILabel *herolabel = [[UILabel alloc]init];
        [herolabel setTextColor:[UIColor blackColor]];
        [herolabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        //herolabel.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:herolabel];
        
        //英雄战斗属性
        UILabel *atkLabel = [[UILabel alloc]init];
        [atkLabel setTextColor:[UIColor grayColor]];
        [atkLabel setFont:[UIFont systemFontOfSize:15.0f]];
        atkLabel.textAlignment = NSTextAlignmentRight;
        [self .contentView addSubview:atkLabel];
        
        //英雄定位
        UILabel *rolesLabel = [[UILabel alloc]init];
        [rolesLabel setTextColor:[UIColor grayColor]];
        [rolesLabel setFont:[UIFont systemFontOfSize:12.5f]];
        rolesLabel.textAlignment = NSTextAlignmentLeft;
        rolesLabel.numberOfLines = 2;
        [self .contentView addSubview:rolesLabel];
        
        _heroImage = heroImage;
        _heroLabel = herolabel;
        _atkLabel = atkLabel;
        _rolesLabel = rolesLabel;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellW = self.size.width;
    CGFloat cellH = self.size.height;
    _heroImage.frame = CGRectMake(0, 0, 150, cellH);
    _heroLabel.frame = CGRectMake(155, 0, 150, 30);
    _atkLabel.frame = CGRectMake(cellW-85, 0, 50, 30);
    _rolesLabel.frame = CGRectMake(160, cellH-60, cellW-165, 50);
}


@end
