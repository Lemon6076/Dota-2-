//
//  AppDelegate.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MYSleftMenu_ViewController.h"
#import "MYSinputID_ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   //初始化一个窗口
    self.window = [[UIWindow alloc]init];
    
    MYSinputID_ViewController *inputID = [[MYSinputID_ViewController alloc]init];
    self.window.rootViewController = inputID;

    //[self showRootWindow];
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


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
    self.window.rootViewController = drawerController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
