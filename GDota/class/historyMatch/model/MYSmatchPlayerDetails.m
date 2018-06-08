//
//  MYSmatchPlayerDetails.m
//  GDota
//
//  Created by lemon on 20/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatchPlayerDetails.h"

@implementation MYSmatchPlayerDetails

-(instancetype)matchPlayerDetailsWithDict:(NSDictionary *)dict{
    if([super init]){
        _kills = dict[@"kills"];
        _deaths = dict[@"deaths"];
        _assists = dict[@"assists"];
        _gold_spent = dict[@"gold_spent"];
        _gold = dict[@"gold"];
        _player_slot = dict[@"player_slot"];
        _account_id = dict[@"account_id"];
        _level = dict[@"level"];
        _hero_id = dict[@"hero_id"];
        _hero_healing = dict[@"hero_healing"];
        _hero_damage = dict[@"hero_damage"];
        _tower_damage = dict[@"tower_damage"];
        _gold_per_min = dict[@"gold_per_min"];
        _xp_per_min = dict[@"xp_per_min"];
        
        _item_0 = dict[@"item_0"];
        _item_1 = dict[@"item_1"];
        _item_2 = dict[@"item_2"];
        _item_3 = dict[@"item_3"];
        _item_4 = dict[@"item_4"];
        _item_5 = dict[@"item_5"];
    }
    return self;
}
+(instancetype)matchPlayerDetailsWithDict:(NSDictionary *)dict{
    return [[self alloc]matchPlayerDetailsWithDict:dict];
}

@end
