//
//  MYSheroAbility.m
//  GDota
//
//  Created by lemon on 1/12/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSheroAbility.h"

@implementation MYSheroAbility

-(instancetype)heroAbilityWithDict:(NSDictionary *)dict{
    if ([super init]) {
        _desc = dict[@"desc"];
        _dname = dict[@"dname"];
        _hurl = dict[@"hurl"];
        
    }
    return self;
}
+(instancetype)heroAbilityWithDict:(NSDictionary *)dict{
     return  [[self alloc]heroAbilityWithDict:dict];
}



@end
