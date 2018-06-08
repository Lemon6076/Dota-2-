//
//  MYSletfMenu_TableViewCell.m
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSletfMenu_TableViewCell.h"

@implementation MYSletfMenu_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //个性签名
        UILabel *contentLable=[[UILabel alloc]init];
        [contentLable setFont:[UIFont systemFontOfSize:14.0f]];
        [contentLable setTextColor:[UIColor grayColor]];
        contentLable.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:contentLable];
        
        //侧滑
        UILabel *letfMenuLabel=[[UILabel alloc]init];
        [letfMenuLabel setTextColor:[UIColor whiteColor]];
        [letfMenuLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        letfMenuLabel.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:letfMenuLabel];
        
        //侧滑用户名
        UILabel *userLabel=[[UILabel alloc]init];
        [userLabel setTextColor:[UIColor whiteColor]];
        [userLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        userLabel.textAlignment = NSTextAlignmentCenter;
        [self .contentView addSubview:userLabel];
        
        //图片
        UIImageView *iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:iconImage];
        [iconImage setContentMode:UIViewContentModeScaleAspectFit];
        //头像
        UIImageView *hearImage = [[UIImageView alloc]init];
        [hearImage setContentMode:UIViewContentModeScaleAspectFit];
        [hearImage.layer setMasksToBounds:YES];   //设置yes
        [hearImage.layer setCornerRadius:35.0f];   //弧度等于宽度的一半 就是圆角
        [self.contentView addSubview:hearImage];

        
        _contentLable = contentLable;
        _letfMenuLabel = letfMenuLabel;
        _userLabel = userLabel;
        _iconImage = iconImage;
        _hearImage = hearImage;

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat cellW = self.size.width;
    CGFloat cellH = self.size.height;
    _contentLable.frame=CGRectMake(cellW/2-100,cellH/2-20,200, 40);
    _letfMenuLabel.frame=CGRectMake(20,cellH/2-40,100, 80);
    _userLabel.frame=CGRectMake(cellW/2-50,cellH/2-40,100, 80);
    _iconImage.frame = CGRectMake(15,cellH/2-10,20, 20);
    _hearImage.frame = CGRectMake(cellW/2-35,-40,70, 70);
}

@end
