//
//  MYS_TabBar.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYS_TabBar.h"

@implementation MYS_TabBar

-(void)layoutSubviews{
    [super layoutSubviews];
    self.frame = CGRectMake(0, 150, self.bounds.size.width, 50);
}

@end
