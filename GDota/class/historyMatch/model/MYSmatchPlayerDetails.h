//
//  MYSmatchPlayerDetails.h
//  GDota
//
//  Created by lemon on 20/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSmatchPlayerDetails : NSObject
/**玩家击杀数*/
@property (nonatomic , strong) NSNumber *kills;
/**玩家死亡数*/
@property (nonatomic , strong) NSNumber *deaths;
/**玩家辅助数*/
@property (nonatomic , strong) NSNumber *assists;
/**玩家花费经济数*/
@property (nonatomic , strong) NSNumber *gold_spent;
/**玩家当前经济数*/
@property (nonatomic , strong) NSNumber *gold;
/**玩家阵营*/
@property (nonatomic , strong) NSNumber *player_slot;
/**玩家ID*/
@property (nonatomic , strong) NSNumber *account_id;
/**玩家等级*/
@property (nonatomic , strong) NSNumber *level;
/**玩家使用英雄*/
@property (nonatomic , strong) NSNumber *hero_id;
/**玩家使用英雄治疗量*/
@property (nonatomic , strong) NSNumber *hero_healing;
/**玩家使用英雄伤害量，对敌人*/
@property (nonatomic , strong) NSNumber *hero_damage;
/**玩家使用英雄伤害量，对防御塔*/
@property (nonatomic , strong) NSNumber *tower_damage;
/**玩家使用英雄每分钟获得经济量*/
@property (nonatomic , strong) NSNumber *gold_per_min;
/**玩家使用英雄每分钟获得经验量*/
@property (nonatomic , strong) NSNumber *xp_per_min;

/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_0;
/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_1;
/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_2;
/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_3;
/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_4;
/**玩家物品ID*/
@property (nonatomic , strong) NSNumber *item_5;


-(instancetype)matchPlayerDetailsWithDict:(NSDictionary *)dict;
+(instancetype)matchPlayerDetailsWithDict:(NSDictionary *)dict;

@end
