//
//  MYSmatchList.h
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYSmatchList : NSObject

/**比赛id*/
@property (nonatomic , assign) NSNumber *match_id;
/**比赛开始时间*/
@property (nonatomic , assign) NSNumber *start_time;
/**比赛匹配类型*/
@property (nonatomic , assign) NSNumber *lobby_type;
/**比赛玩家*/
@property (nonatomic , strong)NSArray *players;

-(instancetype)matchWithDict:(NSDictionary *)dict;
+(instancetype)matchWithDict:(NSDictionary *)dict;

@end
