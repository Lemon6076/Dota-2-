//
//  MYS_NavigationViewController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYS_NavigationViewController.h"

@interface MYS_NavigationViewController ()

@end

@implementation MYS_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*统一设置item的样式*/
    //返回一个Item对象 并可以对该对象样式进行设置（颜色，形状等）
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    /*统一设置item不可以点击的样式*/
    NSMutableDictionary *dict_disable = [NSMutableDictionary dictionary];
    dict_disable[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:dict_disable forState:UIControlStateNormal];
    
}

//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if(self.viewControllers.count>1)
    {
        //左部按钮
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem createItemWithTarget:self image_name:@"" action:@selector(back)];
        //右部按钮
        viewController.navigationItem.rightBarButtonItem =[UIBarButtonItem createItemWithTarget:self image_name:@"" action:@selector(more)];
        
    }
}


//返回上一个控制器
-(void)back
{
    [self popViewControllerAnimated:YES];
}
//回到主控制器
-(void)more
{
    [self popToRootViewControllerAnimated:YES];
}


@end
