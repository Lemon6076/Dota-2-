//
//  MYSmatchDetail_TableViewCell.m
//  GDota
//
//  Created by lemon on 21/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatchDetail_TableViewCell.h"

@implementation MYSmatchDetail_TableViewCell

//重写覆盖初始化方法
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //调用父类的初始化方法
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //玩家头像
        UIImageView *playerImage = [[UIImageView alloc]init];
        [playerImage setContentMode:UIViewContentModeScaleAspectFill];
        [playerImage.layer setMasksToBounds:YES];   //设置yes
        [playerImage.layer setCornerRadius:20];   //弧度等于宽度的一半 就是圆角
        [self.contentView addSubview:playerImage];

        //玩家名称
        UILabel *nameLabel = [[UILabel alloc]init];
        [nameLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [nameLabel setTextColor:[UIColor grayColor]];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:nameLabel];
        //玩家等级
        UILabel *lvLabel = [[UILabel alloc]init];
        [lvLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [lvLabel setTextColor:[UIColor blackColor]];
        lvLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:lvLabel];
        
        //个人战绩
        UIView *KDA = [[UIView alloc]init];
        //KDA.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:KDA];
        
        /**玩家杀人数label*/
        UILabel *killLabel = [[UILabel alloc]init];
        [killLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [killLabel setTextColor:[UIColor blackColor]];
        killLabel.textAlignment = NSTextAlignmentCenter;
        [KDA addSubview:killLabel];
        /**玩家死亡数label*/
        UILabel *deathLabel = [[UILabel alloc]init];
        [deathLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [deathLabel setTextColor:[UIColor blackColor]];
        deathLabel.textAlignment = NSTextAlignmentCenter;
        [KDA addSubview:deathLabel];
        /**玩家辅助数label*/
        UILabel *assistsLabel = [[UILabel alloc]init];
        [assistsLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [assistsLabel setTextColor:[UIColor blackColor]];
        assistsLabel.textAlignment = NSTextAlignmentCenter;
        [KDA addSubview:assistsLabel];
        /**玩家经济label*/
        UILabel *goldLabel = [[UILabel alloc]init];
        [goldLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [goldLabel setTextColor:[UIColor blackColor]];
        goldLabel.textAlignment = NSTextAlignmentCenter;
        [KDA addSubview:goldLabel];
        //详情view
        UIView *detailView = [[UIView alloc]init];
        detailView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2f];
        //[self.contentView addSubview:detailView];
        
        //玩家使用英雄label
        UILabel *heroLabel = [[UILabel alloc]init];
        [heroLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [heroLabel setTextColor:[UIColor blackColor]];
        heroLabel.textAlignment = NSTextAlignmentCenter;
        heroLabel.text = @"使用的英雄";
        [detailView addSubview:heroLabel];
        
        
        /**玩家使用英雄治疗量*/
        UILabel *hero_healingLabel = [[UILabel alloc]init];
        [hero_healingLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [hero_healingLabel setTextColor:[UIColor blackColor]];
        hero_healingLabel.textAlignment = NSTextAlignmentCenter;
        [detailView addSubview:hero_healingLabel];
        /**玩家使用英雄伤害量，对敌人*/
        UILabel *hero_damageLabel = [[UILabel alloc]init];
        [hero_damageLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [hero_damageLabel setTextColor:[UIColor blackColor]];
        hero_damageLabel.textAlignment = NSTextAlignmentLeft;
        [detailView addSubview:hero_damageLabel];
        /**玩家使用英雄伤害量，对防御塔*/
        UILabel *tower_damageLabel = [[UILabel alloc]init];
        [tower_damageLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [tower_damageLabel setTextColor:[UIColor blackColor]];
        tower_damageLabel.textAlignment = NSTextAlignmentLeft;
        [detailView addSubview:tower_damageLabel];
        /**玩家使用英雄每分钟获得经济量*/
        UILabel *gold_per_minLabel = [[UILabel alloc]init];
        [gold_per_minLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [gold_per_minLabel setTextColor:[UIColor blackColor]];
        gold_per_minLabel.textAlignment = NSTextAlignmentLeft;
        [detailView addSubview:gold_per_minLabel];
        /**玩家使用英雄每分钟获得经验量*/
        UILabel *xp_per_minLabel = [[UILabel alloc]init];
        [xp_per_minLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [xp_per_minLabel setTextColor:[UIColor blackColor]];
        xp_per_minLabel.textAlignment = NSTextAlignmentLeft;
        [detailView addSubview:xp_per_minLabel];
        
        
        //玩家使用英雄图
        UIImageView *heroImage0 = [[UIImageView alloc]init];
        [heroImage0 setContentMode:UIViewContentModeScaleAspectFill];
        [heroImage0.layer setMasksToBounds:YES];   //设置yes
        [heroImage0.layer setCornerRadius:20.0f];   //弧度等于宽度的一半 就是圆角
        heroImage0.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [detailView addSubview:heroImage0];
        //物品装备
        
         UIImageView *itemImage0 = [[UIImageView alloc]init];
        [itemImage0 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage0.layer setMasksToBounds:YES];   //设置yes
        [itemImage0.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage0.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage0];
        
         UIImageView *itemImage1 = [[UIImageView alloc]init];
        [itemImage1 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage1.layer setMasksToBounds:YES];   //设置yes
        [itemImage1.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage1.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage1];
        
         UIImageView *itemImage2 = [[UIImageView alloc]init];
        [itemImage2 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage2.layer setMasksToBounds:YES];   //设置yes
        [itemImage2.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage2.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage2];
        
         UIImageView *itemImage3 = [[UIImageView alloc]init];
        [itemImage3 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage3.layer setMasksToBounds:YES];   //设置yes
        [itemImage3.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage3.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage3];
        
         UIImageView *itemImage4 = [[UIImageView alloc]init];
        [itemImage4 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage4.layer setMasksToBounds:YES];   //设置yes
        [itemImage4.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage4.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage4];
        
         UIImageView *itemImage5 = [[UIImageView alloc]init];
        [itemImage5 setContentMode:UIViewContentModeScaleAspectFill];
        [itemImage5.layer setMasksToBounds:YES];   //设置yes
        [itemImage5.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
        itemImage5.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
        [self.contentView addSubview:itemImage5];
        
        //赋值全局
        _playerImage = playerImage;
        _nameLabel = nameLabel;
        _lvLabel = lvLabel;
        _detailView = detailView;
        
        _KDA = KDA;
        
        _killLabel = killLabel;
        _deathLabel = deathLabel;
        _assistsLabel = assistsLabel;
        _goldLabel = goldLabel;
        _heroLabel = heroLabel;
        
        _hero_healingLabel = hero_healingLabel;
        _hero_damageLabel = hero_damageLabel;
        _tower_damageLabel = tower_damageLabel;
        _gold_per_minLabel = gold_per_minLabel;
        _xp_per_minLabel = xp_per_minLabel;
        
        _heroImage0 = heroImage0;
        
        
        _itemImage0 = itemImage0;
        _itemImage1 = itemImage1;
        _itemImage2 = itemImage2;
        _itemImage3 = itemImage3;
        _itemImage4 = itemImage4;
        _itemImage5 = itemImage5;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //cell宽高
    //CGFloat cellW = self.frame.size.width;
    CGFloat cellH = 60;
    //物品宽高
    CGFloat itemWH = 30;
    //等级宽
    CGFloat lvW = 40;
    //头像宽高
    CGFloat headWH = 40;
    //KDAG宽高
    CGFloat kdagW = 35;
    CGFloat kdagH = 12;
    //detail宽高
    CGFloat detailW = 160;
    CGFloat detailH = 13;
    
    _playerImage.frame = CGRectMake(6, cellH/2-headWH/2, headWH, headWH);
    _nameLabel.frame = CGRectMake(headWH+12+lvW, 10, MYSScreenW-headWH+5 , 10);
    _lvLabel.frame = CGRectMake(headWH+12, 10, lvW , 12);
    _detailView.frame = CGRectMake(0, headWH+20, MYSScreenW, 65);
    _heroLabel.frame = CGRectMake(10, 5, 50 , 12);
    
    _hero_healingLabel.frame = CGRectMake(detailW-detailW/2+55,5, detailW , detailH);
    _hero_damageLabel.frame = CGRectMake(65, 10+detailH, detailW , detailH);
    _tower_damageLabel.frame = CGRectMake(detailW+55, 10+detailH, detailW , detailH);
    _gold_per_minLabel.frame = CGRectMake(65, 20+detailH*2, detailW , detailH);
    _xp_per_minLabel .frame = CGRectMake(detailW+55, 20+detailH*2, detailW , detailH);
    
    
    _heroImage0.frame =  CGRectMake(15, 20, 40 , 40);

    _KDA.frame = CGRectMake(255, 0, 115 , cellH);
    
    _killLabel.frame = CGRectMake(5, 20, kdagW , kdagH);
    _deathLabel.frame = CGRectMake(kdagW+5, 20, kdagW , kdagH);
    _assistsLabel.frame = CGRectMake(kdagW*2+5, 20, kdagW , kdagH);
    _goldLabel.frame = CGRectMake(0, _KDA.frame.size.height-20 , _KDA.frame.size.width , kdagH);
    
    
    _itemImage0.frame = CGRectMake(headWH+15, 23, itemWH , itemWH);
    _itemImage1.frame = CGRectMake(headWH+15+itemWH+3, 23, itemWH , itemWH);
    _itemImage2.frame = CGRectMake(headWH+15+(itemWH+3)*2, 23, itemWH , itemWH);
    _itemImage3.frame = CGRectMake(headWH+15+(itemWH+3)*3, 23, itemWH , itemWH);
    _itemImage4.frame = CGRectMake(headWH+15+(itemWH+3)*4, 23, itemWH , itemWH);
    _itemImage5.frame = CGRectMake(headWH+15+(itemWH+3)*5, 23, itemWH , itemWH);

}


@end
