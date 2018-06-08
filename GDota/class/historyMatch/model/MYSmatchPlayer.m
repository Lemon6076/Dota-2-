//
//  MYSmatchPlayer.m
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatchPlayer.h"

@implementation MYSmatchPlayer


-(instancetype)matchPlayerWithDict:(NSDictionary *)dict{
    if([super init]){
        _account_id = dict[@"account_id"];
        _hero_id = dict[@"hero_id"];
        _player_slot = dict[@"player_slot"];
    }
    return self;
}
+(instancetype)matchPlayerWithDict:(NSDictionary *)dict{
    return [[self alloc]matchPlayerWithDict:dict];
}

@end
