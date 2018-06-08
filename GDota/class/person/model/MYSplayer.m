//
//  MYSplayer.m
//  GDota
//
//  Created by lemon on 9/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSplayer.h"

@implementation MYSplayer

-(instancetype)userWithDict:(NSDictionary *)dict{
    if([super init]){
        _avatar = dict[@"avatar"];
        _avatarfull = dict[@"avatarfull"];
        _personaname = dict[@"personaname"];
        _realname = dict[@"realname"];
        _loccountrycode = dict[@"loccountrycode"];
        _profileurl = dict[@"profileurl"];
        _personastate = dict[@"personastate"];
        _lastlogoff = dict[@"lastlogoff"];
        _steamid = dict[@"steamid"];
    }
    return self;
}
+(instancetype)userWithDict:(NSDictionary *)dict{
    return [[self alloc]userWithDict:dict];
}

@end
