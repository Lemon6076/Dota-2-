//
//  MYS_TabBar.h
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMYTabBar;
//声明协议
@protocol MYS_TabBarDelegate <NSObject>

@end

@interface MYS_TabBar : UITabBar

//定义代理属性
@property (nonatomic , weak)id<MYS_TabBarDelegate> delegate;

@end