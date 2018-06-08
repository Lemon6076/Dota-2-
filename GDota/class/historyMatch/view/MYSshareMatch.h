//
//  MYSshareMatch.h
//  GDota
//
//  Created by lemon on 27/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSshareMatch : UIView


@property(nonatomic , strong) UIView *shareView;
@property(nonatomic , strong) UIToolbar *bar;
+(instancetype)menu;
-(void)show;

@end
