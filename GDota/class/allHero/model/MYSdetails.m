//
//  MYSdetails.m
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSdetails.h"

@implementation MYSdetails

-(instancetype)detailsWithDict:(NSDictionary *)dict{
    if ([super init]) {
        _atk_l = dict[@"atk_l"];
        _bio = dict[@"bio"];
        _name = dict[@"name"];
         _roles_l = dict[@"roles_l"];

       
    }
    return self;
}
+(instancetype)detailsWithDict:(NSDictionary *)dict{
    return  [[self alloc]detailsWithDict:dict];
}


@end
