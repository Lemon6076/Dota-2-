//
//  MYStitle_Button.m
//  GDota
//
//  Created by lemon on 29/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYStitle_Button.h"

@implementation MYStitle_Button

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}



@end
