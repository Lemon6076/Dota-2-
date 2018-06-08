//
//  MYSmatchPlayer.h
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSmatchPlayer : NSObject

/**比赛玩家id*/
@property (nonatomic , assign) NSNumber *account_id;
/**比赛英雄id*/
@property (nonatomic , assign) NSNumber *hero_id;
/**比赛玩家阵营*/
@property (nonatomic , assign)NSNumber *player_slot;

-(instancetype)matchPlayerWithDict:(NSDictionary *)dict;
+(instancetype)matchPlayerWithDict:(NSDictionary *)dict;

@end
