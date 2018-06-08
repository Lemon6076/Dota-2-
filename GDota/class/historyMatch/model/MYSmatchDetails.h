//
//  MYSmatchDetails.h
//  GDota
//
//  Created by lemon on 16/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSmatchDetails : NSObject

/**比赛结果*/
@property (nonatomic , assign) BOOL radiant_win;
/**比赛时长*/
@property (nonatomic , strong) NSNumber *duration;
/**开始时间*/
@property (nonatomic , strong) NSNumber *start_time;
/**匹配模式*/
@property (nonatomic , strong) NSNumber *lobby_type;
/**天辉防御塔数量*/
@property (nonatomic , strong) NSNumber *tower_status_radiant;

//玩家游戏详情
@property (nonatomic , strong)NSArray *player;

-(instancetype)matchDetailsWithDict:(NSDictionary *)dict;
+(instancetype)matchDetailsWithDict:(NSDictionary *)dict;

@end
