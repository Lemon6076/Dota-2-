//
//  MYSmatchDetails.m
//  GDota
//
//  Created by lemon on 16/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmatchDetails.h"
#import "MYSmatchPlayerDetails.h"

@implementation MYSmatchDetails

-(instancetype)matchDetailsWithDict:(NSDictionary *)dict{
    if([super init]){
        BOOL R = [dict[@"radiant_win"] boolValue];
        _radiant_win = R;
        _duration = dict[@"duration"];
        _start_time = dict[@"start_time"];
        _lobby_type = dict[@"lobby_type"];
        
        NSArray *player = dict[@"players"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in player) {
            MYSmatchPlayerDetails *player = [[MYSmatchPlayerDetails alloc]matchPlayerDetailsWithDict:dic];
            [temp addObject:player];
        }
        _player = temp;
        
    }
    return self;
}
+(instancetype)matchDetailsWithDict:(NSDictionary *)dict{
    return [[self alloc]matchDetailsWithDict:dict];
}

@end
