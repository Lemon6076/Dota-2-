//
//  MYS_TabBarController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYS_TabBarController.h"
#import "MYSdiscover_ViewController.h"
#import "MYSallHero_ViewController.h"
#import "MYSperson_ViewController.h"
#import "MYShistoryMatch_ViewController.h"
#import "MYSprofessionMatch_ViewController.h"


@interface MYS_TabBarController ()

@end

@implementation MYS_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建各TabBar下的View对象
    //MYSdiscover_ViewController *discover = [[MYSdiscover_ViewController alloc]init];
    MYSdiscover_ViewController *discover = [[MYSdiscover_ViewController alloc]init];
    MYSallHero_ViewController *allHero = [[MYSallHero_ViewController alloc]init];
    MYSperson_ViewController *person = [[MYSperson_ViewController alloc]init];
    MYShistoryMatch_ViewController *historyMatch = [[MYShistoryMatch_ViewController alloc]init];
    MYSprofessionMatch_ViewController *professionMatch = [[MYSprofessionMatch_ViewController alloc]init];
    
    //创建TabBar对象

    [self addBarWithAddbar:professionMatch title:@"赛事" image:@"tabbar_professionMatch"];
    [self addBarWithAddbar:historyMatch title:@"战绩" image:@"tabbar_historyMatch"];
    [self addBarWithAddbar:person title:@"我" image:@"tabbar_person"];
    [self addBarWithAddbar:allHero title:@"英雄" image:@"tabbar_allHero"];
    [self addBarWithAddbar:discover title:@"发现" image:@"tabbar_discover"];
    //默认显示哪个窗口
      self.selectedViewController =[self.viewControllers objectAtIndex:2];

}


/**
 *  添加TabBar子控件
 *
 *  @param addbar view对象
 *  @param title  文字title
 *  @param image  图片名称
 */

-(void)addBarWithAddbar :(UIViewController *)addbar  title :(NSString *) title image :(NSString *) image
{
    
    MYS_NavigationViewController *nav = [[MYS_NavigationViewController alloc]initWithRootViewController:addbar];
    NSString *str = @"我";
    if (title == str) {
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.barStyle = UIBarStyleBlack;
    }
    

    NSString *selectedimage = [image stringByAppendingString:@"_selected"];
 
    // 创建字典
    //通过字典来设置文字属性（颜色 ， 字体 ， 等）
 
    NSMutableDictionary *titleFrame = [NSMutableDictionary dictionary];
    titleFrame[NSForegroundColorAttributeName] = [UIColor blackColor];
    //设置view背景颜色
    addbar.view.backgroundColor = [UIColor whiteColor];
    //设置bar的title
    addbar.tabBarItem.title = title;
    addbar.navigationItem.title = title;
    [addbar.tabBarItem setTitleTextAttributes:titleFrame forState:UIControlStateSelected];
    //设置bar背景图片
    addbar.tabBarItem.image = [UIImage imageNamed:image];
    //设置选中后的颜色
    addbar.tabBarItem.selectedImage = [[UIImage imageNamed:selectedimage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //把导航栏控制器添加到标签页中
    [self addChildViewController:nav];
}


@end
