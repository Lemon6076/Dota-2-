//
//  MYSshare_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSshare_ViewController.h"

@interface MYSshare_ViewController ()

@end

@implementation MYSshare_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //对控制器对象vc的view设置颜色
    self.view.backgroundColor = [UIColor whiteColor];
    /**创建分享按钮*/
    [self createShareButton];
    /**退出按钮和标题*/
    [self createExitButton];
    
}
/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"分享应用";
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)createShareButton{
    
    //按钮大小
    CGFloat buttonWH = 65;
    //按钮每排y坐标
    CGFloat line1 = 200;
    CGFloat line2 = 300;
    CGFloat line3 = 400;
    //按钮每排y坐标
    CGFloat lLine1 = 265;
    CGFloat lLine2 = 365;
    CGFloat lLine3 = 465;
    
    //按钮每排x坐标
    CGFloat row1 = MYSScreenW/2-95;
    CGFloat row2 = MYSScreenW/2+30;
    //创建圆按钮
    MYSexitRound_Button *pyq = [[MYSexitRound_Button alloc]initWithbackImage:@"pyq" ButtonWH:buttonWH Frame:CGRectMake(row1 , line1, buttonWH, buttonWH)];
    [pyq addTarget:self action:@selector(click_pyq) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row1 , lLine1, buttonWH, 20) title:@"朋友圈"];
    
    
    MYSexitRound_Button *kj = [[MYSexitRound_Button alloc]initWithbackImage:@"kj" ButtonWH:buttonWH Frame:CGRectMake(row2, line1, buttonWH, buttonWH)];
    [kj addTarget:self action:@selector(click_kj) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row2 , lLine1, buttonWH, 20) title:@"QQ空间"];
    
    
    MYSexitRound_Button *wx = [[MYSexitRound_Button alloc]initWithbackImage:@"wx" ButtonWH:buttonWH Frame:CGRectMake(row1 , line2, buttonWH, buttonWH)];
    [wx addTarget:self action:@selector(click_wx) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row1 , lLine2, buttonWH, 20) title:@"微信"];
    
    
    MYSexitRound_Button *qq = [[MYSexitRound_Button alloc]initWithbackImage:@"qq" ButtonWH:buttonWH Frame:CGRectMake(row2, line2, buttonWH, buttonWH)];
    [qq addTarget:self action:@selector(click_qq) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row2 , lLine2, buttonWH, 20) title:@"QQ"];
    
    
    MYSexitRound_Button *wb = [[MYSexitRound_Button alloc]initWithbackImage:@"wb" ButtonWH:buttonWH Frame:CGRectMake(row1 , line3, buttonWH, buttonWH)];
    [wb addTarget:self action:@selector(click_wb) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row1 , lLine3, buttonWH, 20) title:@"微博"];
    
    
    MYSexitRound_Button *lj = [[MYSexitRound_Button alloc]initWithbackImage:@"lj" ButtonWH:buttonWH Frame:CGRectMake(row2, line3, buttonWH, buttonWH)];
    [lj addTarget:self action:@selector(click_lj) forControlEvents:UIControlEventTouchUpInside];
    [self hintLableWithFrame:CGRectMake(row2 , lLine3, buttonWH, 20) title:@"复制链接"];
    
    
    //添加到view
    [self.view addSubview:pyq];
    [self.view addSubview:kj];
    [self.view addSubview:wx];
    [self.view addSubview:qq];
    [self.view addSubview:wb];
    [self.view addSubview:lj];
    
}

-(void)hintLableWithFrame:(CGRect)frame title:(NSString *)title{
    UILabel *lable = [[UILabel alloc]initWithFrame:frame];
    [lable setFont:[UIFont boldSystemFontOfSize:14.0f]];
    lable.text = title;
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
}

/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma make   分享按钮点击事件

-(void)click_pyq{
    
}
-(void)click_kj{
    
}

-(void)click_wx{
    
}

-(void)click_qq{
    
}

-(void)click_wb{
    
}

-(void)click_lj{
    
}


@end
