//
//  MYSItems.m
//  GDota
//
//  Created by lemon on 21/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSItems.h"

@implementation MYSItems

-(instancetype)itemWithDict:(NSDictionary *)dict{
    if([super init]){
        _ID = dict[@"id"];
        _name = dict[@"name"];
        
    }
    return self;
}
+(instancetype)itemWithDict:(NSDictionary *)dict{
    return [[self alloc]itemWithDict:dict];
}


@end
