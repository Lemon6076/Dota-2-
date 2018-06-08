//
//  MYSexitRound_Button.m
//  GDota
//
//  Created by lemon on 31/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSexitRound_Button.h"

@implementation MYSexitRound_Button

- (instancetype)initWithbackImage:(NSString *)imageName ButtonWH:(NSInteger)buttonWH Frame:(CGRect)frame
{
    if (self = [super init]) {

        CGFloat  radian = buttonWH/2;
        self.frame = frame;
        //[self setTitle:@"返回" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[self setBackgroundColor:[[UIColor grayColor]colorWithAlphaComponent:0.7]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self.layer setMasksToBounds:YES];   //设置yes
        [self.layer setCornerRadius:radian];   //弧度等于宽度的一半 就是圆角

    }
    return self;
}



@end
