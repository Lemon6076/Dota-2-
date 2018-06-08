//
//  UIWindow+Extension.m
//  GDota
//
//  Created by lemon on 8/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "MMDrawerController.h"
#import "MYSleftMenu_ViewController.h"
#import "MYSinputID_ViewController.h"

@implementation UIWindow (Extension)

//创建主界面
-(void)showRootWindow{
    
    //为UITabBarController设置子控制器
    MYS_TabBarController *tab = [[MYS_TabBarController alloc]init];
    //初始化个人窗口
    MYSleftMenu_ViewController *LeftMenu = [[MYSleftMenu_ViewController alloc]init];
    //添加中心窗口和又滑窗口
    MMDrawerController * drawerController = [[MMDrawerController alloc] initWithCenterViewController:tab leftDrawerViewController:LeftMenu];
    //滑动后显示主窗口宽度
    drawerController.maximumLeftDrawerWidth = 250;
    //添加手势
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeCustom];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //添加到根窗口
    self.rootViewController = drawerController;
}

@end
