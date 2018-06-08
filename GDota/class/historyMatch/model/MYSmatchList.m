//
//  MYSmatchList.m
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatchList.h"
#import "MYSmatchPlayer.h"

@implementation MYSmatchList


-(instancetype)matchWithDict:(NSDictionary *)dict{
    if([super init]){
        _match_id = dict[@"match_id"];
        _start_time = dict[@"start_time"];
        _lobby_type = dict[@"lobby_type"];
        NSArray *temp = dict[@"players"];
        
        NSMutableArray *player = [NSMutableArray array];
        for (NSDictionary *dic in temp) {
            MYSmatchPlayer *mPlayer = [[MYSmatchPlayer alloc]matchPlayerWithDict:dic];
            [player addObject:mPlayer];
        }
        self.players = player;
        
    }
    return self;
}
+(instancetype)matchWithDict:(NSDictionary *)dict{
    return [[self alloc]matchWithDict:dict];
}

@end
