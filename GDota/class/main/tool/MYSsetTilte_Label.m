//
//  MYSsetTilte_Label.m
//  GDota
//
//  Created by lemon on 1/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSsetTilte_Label.h"

@implementation MYSsetTilte_Label

-(instancetype)init{
    if(self = [super init]){
    [self setFont:[UIFont boldSystemFontOfSize:19.0f]];
    [self setTextColor:[UIColor blackColor]];
    self.textAlignment = NSTextAlignmentCenter;
    self.frame = CGRectMake(MYSScreenW/2-75,20, 150, 50);
    }
    return self;
}

@end
