//
//  MYSVIP_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSVIP_ViewController.h"

@interface MYSVIP_ViewController ()

@end

@implementation MYSVIP_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //退出按钮添加
    [self createExitButton];
    //支付二维码
    [self addPayImage];
    
}

/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"会员中心";
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//创建支付二维码view加lable
-(void)addPayImage{
    CGFloat imageW = 150;
    
    UIImageView *mmy = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pay"]];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 370, MYSScreenW, 30)];
    UILabel *lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, MYSScreenW, 30)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable1.textAlignment = NSTextAlignmentCenter;
    lable.text = @"扫一扫，你会变得更强，";
    lable1.text = @"唯有充钱，才能让你更牛X!";

    
    mmy.frame = CGRectMake(MYSScreenW/2-imageW/2, 200, imageW, imageW);

    [self.view addSubview:lable1];
    [self.view addSubview:lable];
    [self.view addSubview:mmy];

}

@end
