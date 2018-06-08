//
//  MYSfriends.m
//  GDota
//
//  Created by lemon on 9/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSfriends.h"

@implementation MYSfriends


-(instancetype)friendWithDict:(NSDictionary *)dict{
    if([super init]){
        _steamid = dict[@"steamid"];
    }
    return self;
}
+(instancetype)friendWithDict:(NSDictionary *)dict{
    return [[self alloc]friendWithDict:dict];
}


@end
