//
//  MYSabout_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSabout_ViewController.h"

@interface MYSabout_ViewController ()
//功能介绍窗口
@property (nonatomic , strong) UIWebView *function;
//创作成员窗口
@property (nonatomic , strong)UIImageView *image;

@end

@implementation MYSabout_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建关于中的app图标展示
    [self createAppIcon];
    //创建lable载入联系方式
    [self contact];
    //创建功能介绍按钮
    [self functionIntroduceButton];
    //退出按钮和标题
    [self createExitButton];
    //创作人员
    [self createTeamLabel];
    
}
/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"关于我们";
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//创建关于中的app图标展示
-(void)createAppIcon{
    //按钮宽高
    CGFloat buttonWH = 150;
    MYSexitRound_Button *appIcon = [[MYSexitRound_Button alloc]initWithbackImage:@"aboutIcon" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, 80, buttonWH, buttonWH)];
    [self.view addSubview:appIcon];
}
//联系方式
-(void)contact{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 250, MYSScreenW, 20)];
    lable.text = @"联系QQ:904703315";
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
}
//创作人员
-(void)createTeamLabel{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, MYSScreenW, 180)];
    _image = image;
    [self.view addSubview:image];
    //延时
    [self performSelector:@selector(animation) withObject:nil afterDelay:0.7];
   }
-(void)animation{
    
    //_image.backgroundColor = [UIColor redColor];
    _image.image = [UIImage imageNamed:@"team"];
     //View出现动画
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromLeft; //设置动画的方向
    anima.duration = 0.6f;
    [_image.layer addAnimation:anima forKey:@"createTeamLabel"];

}
//创建功能介绍按钮
-(void)functionIntroduceButton{
    CGFloat buttonH = 35;
    CGFloat buttonW = 300;
    UIButton *FIB = [[UIButton alloc]initWithFrame:CGRectMake(MYSScreenW/2-buttonW/2, 500, buttonW, buttonH)];
    FIB.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [FIB setTitle:@"功能介绍" forState:UIControlStateNormal];
    FIB.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.8];
    //按钮弧度
    FIB.layer.cornerRadius = 7;
    //阴影偏移量
    FIB.layer.shadowOffset =  CGSizeMake(1, 1);
    //阴影透明度
    FIB.layer.shadowOpacity = 0.8;
    //阴影颜色
    FIB.layer.shadowColor =  [UIColor grayColor].CGColor;
    [FIB addTarget:self action:@selector(functionIntroduce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:FIB];
    
}

//创建功能介绍网页，点击按钮时调用
-(void)functionIntroduce{
    UIWebView *function = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"http://isujin.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [function loadRequest:request];
    _function = function;
    //返回按钮宽高
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    [exit addTarget:self action:@selector(dismissWeb) forControlEvents:UIControlEventTouchUpInside];
    
    [function addSubview:exit];
    
    [self.view addSubview:function];
    
}
-(void)dismissWeb{
     [_function removeFromSuperview];
}

@end
