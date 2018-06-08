//
//  MYSmatchDetail_TableViewCell.h
//  GDota
//
//  Created by lemon on 21/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSmatchDetail_TableViewCell : UITableViewCell

/**玩家头像image*/
@property (nonatomic , strong) UIImageView *playerImage;
/**玩家名称label*/
@property (nonatomic , strong) UILabel *nameLabel;
/**玩家等级label*/
@property (nonatomic , strong) UILabel *lvLabel;
/**个人战绩*/
@property (nonatomic , strong) UIView *KDA;
/**玩家杀人数label*/
@property (nonatomic , strong) UILabel *killLabel;
/**玩家死亡数label*/
@property (nonatomic , strong) UILabel *deathLabel;
/**玩家辅助数label*/
@property (nonatomic , strong) UILabel *assistsLabel;
/**玩家经济label*/
@property (nonatomic , strong) UILabel *goldLabel;
/**玩家使用英雄label*/
@property (nonatomic , strong) UILabel *heroLabel;
/**详情页*/
@property (nonatomic , strong) UIView *detailView;
//玩家使用英雄图
@property (nonatomic , strong) UIImageView *heroImage0;
/**玩家使用英雄治疗量*/
@property (nonatomic , strong) UILabel *hero_healingLabel;
/**玩家使用英雄伤害量，对敌人*/
@property (nonatomic , strong) UILabel *hero_damageLabel;
/**玩家使用英雄伤害量，对防御塔*/
@property (nonatomic , strong) UILabel *tower_damageLabel;
/**玩家使用英雄每分钟获得经济量*/
@property (nonatomic , strong) UILabel *gold_per_minLabel;
/**玩家使用英雄每分钟获得经验量*/
@property (nonatomic , strong) UILabel *xp_per_minLabel;

//物品图

@property (nonatomic , strong) UIImageView *itemImage0;

@property (nonatomic , strong) UIImageView *itemImage1;

@property (nonatomic , strong) UIImageView *itemImage2;

@property (nonatomic , strong) UIImageView *itemImage3;

@property (nonatomic , strong) UIImageView *itemImage4;

@property (nonatomic , strong) UIImageView *itemImage5;

@end
