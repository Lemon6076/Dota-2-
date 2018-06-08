//
//  MYSmatch_TableViewCell.m
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatch_TableViewCell.h"

@implementation MYSmatch_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //匹配类型
        UILabel *lobbyLable=[[UILabel alloc]init];
        [lobbyLable setFont:[UIFont systemFontOfSize:12.0f]];
        lobbyLable.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lobbyLable];
        //天辉类型
        UILabel *slot1Label=[[UILabel alloc]init];
        [slot1Label setFont:[UIFont systemFontOfSize:12.0f]];
        slot1Label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:slot1Label];
        //夜魇类型
        UILabel *slotaLabel=[[UILabel alloc]init];
        [slotaLabel setFont:[UIFont systemFontOfSize:12.0f]];
        slotaLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:slotaLabel];
        //比赛ID
        UILabel *matchIDLabel=[[UILabel alloc]init];
        [matchIDLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [matchIDLabel setTextColor:[UIColor grayColor]];
        matchIDLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:matchIDLabel];
        //比赛开始时间
        UILabel *startTimeLabel=[[UILabel alloc]init];
        [startTimeLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [startTimeLabel setTextColor:[UIColor grayColor]];
        startTimeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:startTimeLabel];
        
        /**比赛结果 胜 label*/
        UILabel *winLabel = [[UILabel alloc]init];
        winLabel.numberOfLines = 0;
        [winLabel setFont:[UIFont systemFontOfSize:22.0f]];
        [winLabel setTextColor:[UIColor blueColor]];
        winLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:winLabel];

        /**登录玩家所在的阵营下标*/
        UIImageView *indexView_1 = [[UIImageView alloc]init];
        [slot1Label addSubview:indexView_1];
        
        UIImageView *indexView_a = [[UIImageView alloc]init];
        [slotaLabel addSubview:indexView_a];
        
        //图片
        /**英雄头像image*/
        UIImageView *heroImage0 = [[UIImageView alloc]init];
        [heroImage0 setContentMode:UIViewContentModeScaleAspectFill];
        [heroImage0.layer setMasksToBounds:YES];   //设置yes
        [heroImage0.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImage0.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:heroImage0];
        /**英雄头像image*/
         UIImageView *heroImage1 = [[UIImageView alloc]init];
        [heroImage1 setContentMode:UIViewContentModeScaleAspectFill];
       // heroImage1.backgroundColor = [UIColor redColor];
        [heroImage1.layer setMasksToBounds:YES];   //设置yes
        [heroImage1.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
        [self.contentView addSubview:heroImage1];
        /**英雄头像image*/
         UIImageView *heroImage2 = [[UIImageView alloc]init];
        [heroImage2 setContentMode:UIViewContentModeScaleAspectFill];
        [heroImage2.layer setMasksToBounds:YES];   //设置yes
        [heroImage2.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
      //  heroImage2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:heroImage2];
        /**英雄头像image*/
         UIImageView *heroImage3 = [[UIImageView alloc]init];
        [heroImage3 setContentMode:UIViewContentModeScaleAspectFill];
        [heroImage3.layer setMasksToBounds:YES];   //设置yes
        [heroImage3.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImage3.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:heroImage3];
        /**英雄头像image*/
         UIImageView *heroImage4 = [[UIImageView alloc]init];
        [heroImage4 setContentMode:UIViewContentModeScaleAspectFill];
        [heroImage4.layer setMasksToBounds:YES];   //设置yes
        [heroImage4.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImage4.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:heroImage4];
        //夜魇
        /**英雄头像image*/
         UIImageView *heroImagea = [[UIImageView alloc]init];
        [heroImagea setContentMode:UIViewContentModeScaleAspectFill];
        [heroImagea.layer setMasksToBounds:YES];   //设置yes
        [heroImagea.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImagea.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:heroImagea];
        /**英雄头像image*/
         UIImageView *heroImageb = [[UIImageView alloc]init];
        [heroImageb setContentMode:UIViewContentModeScaleAspectFill];
        [heroImageb.layer setMasksToBounds:YES];   //设置yes
        [heroImageb.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImageb.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:heroImageb];
        /**英雄头像image*/
         UIImageView *heroImagec = [[UIImageView alloc]init];
        [heroImagec setContentMode:UIViewContentModeScaleAspectFill];
        [heroImagec.layer setMasksToBounds:YES];   //设置yes
        [heroImagec.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImagec.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:heroImagec];
        /**英雄头像image*/
         UIImageView *heroImaged = [[UIImageView alloc]init];
        [heroImaged setContentMode:UIViewContentModeScaleAspectFill];
        [heroImaged.layer setMasksToBounds:YES];   //设置yes
        [heroImaged.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImaged.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:heroImaged];
        /**英雄头像image*/
         UIImageView *heroImagee = [[UIImageView alloc]init];
        [heroImagee setContentMode:UIViewContentModeScaleAspectFill];
        [heroImagee.layer setMasksToBounds:YES];   //设置yes
        [heroImagee.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
       // heroImagee.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:heroImagee];
        
        //胜负
        


        
        
        _lobbyLable = lobbyLable;
        _slot1Label =slot1Label;
        _slotaLabel =slotaLabel;
        _matchIDLabel = matchIDLabel;
        _startTimeLabel = startTimeLabel;
        _winLabel = winLabel;
        _indexView_1 = indexView_1;
        _indexView_a = indexView_a;
        
        _heroImage0 = heroImage0;
        _heroImage1 = heroImage1;
        _heroImage2 = heroImage2;
        _heroImage3 = heroImage3;
        _heroImage4 = heroImage4;
        _heroImagea = heroImagea;
        _heroImageb = heroImageb;
        _heroImagec = heroImagec;
        _heroImaged = heroImaged;
        _heroImagee = heroImagee;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];

    _lobbyLable.frame = CGRectMake(0, 0, 70, 20);
    _slot1Label.frame = CGRectMake(0, 30, 70, 20);
    _slotaLabel.frame = CGRectMake(0, 72, 70, 20);
    _matchIDLabel.frame = CGRectMake(70, 0, 150, 20);
    _startTimeLabel.frame = CGRectMake(220, 0, 150, 20);
    _winLabel.frame = CGRectMake(300, 30, 60, 60);
    _indexView_1.frame = CGRectMake(25, 16, 20, 2);
    _indexView_a.frame = CGRectMake(25, 16, 20, 2);
    
    CGFloat image0X = 70;
    CGFloat image0Y = 20;
    
    CGFloat imageaX = 70;
    CGFloat imageaY = 63;
    //天辉
    _heroImage0.frame = CGRectMake(image0X, image0Y, 40, 40);
    _heroImage1.frame = CGRectMake(image0X+45, image0Y, 40, 40);
    _heroImage2.frame = CGRectMake(image0X+45*2, image0Y, 40, 40);
    _heroImage3.frame = CGRectMake(image0X+45*3, image0Y, 40, 40);
    _heroImage4.frame = CGRectMake(image0X+45*4, image0Y, 40, 40);
    //夜魇
    _heroImagea.frame = CGRectMake(imageaX, imageaY, 40, 40);
    _heroImageb.frame = CGRectMake(imageaX+45, imageaY, 40, 40);
    _heroImagec.frame = CGRectMake(imageaX+45*2, imageaY, 40, 40);
    _heroImaged.frame = CGRectMake(imageaX+45*3, imageaY, 40, 40);
    _heroImagee.frame = CGRectMake(imageaX+45*4, imageaY, 40, 40);
    
}


@end
