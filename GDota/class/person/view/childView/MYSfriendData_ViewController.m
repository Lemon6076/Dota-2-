//
//  MYSfriendData_ViewController.m
//  GDota
//
//  Created by lemon on 12/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSfriendData_ViewController.h"

@interface MYSfriendData_ViewController ()
/**头像蒙板*/
@property (nonatomic , strong) UIView *mask;
/**个人主页*/
@property (nonatomic , strong) UIWebView *HomePage;

@end

@implementation MYSfriendData_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //创建退出按钮
    [self createExitButton];
    
    //创建label
    [self createLable];
    
    //创建个人主页按钮
    [self HomePageButton];
    
}

-(void)createHeadImageWithImageUrl:(NSString *)imageUrl{
    
    //模糊View
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, 135)];
    [mask setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6]];
    _mask = mask;
    //背景图
    UIImageView *headBackground = [[UIImageView alloc]init];
    [headBackground setContentMode:UIViewContentModeScaleAspectFill];
    headBackground.clipsToBounds = YES;
    headBackground.frame = CGRectMake(0, 0, MYSScreenW, 135);
    [headBackground sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"headBackground"]];
   

    //头像
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.frame = CGRectMake(MYSScreenW/2-35, 100, 70, 70);
    [headImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [headImage setContentMode:UIViewContentModeScaleAspectFit];
    [headImage.layer setMasksToBounds:YES];   //设置yes
    [headImage.layer setCornerRadius:35.0f];   //弧度等于宽度的一半 就是圆角
    
    
    [self.view addSubview:headBackground];
    [headBackground addSubview:mask];
    
    [self.view addSubview:headImage];


}
//创建label
-(void)createLable{
    NSArray *title = @[@"账户名：",@"真实姓名：",@"SteamID：",@"状态：",@"地区：",@"上次登录时间："];
    
    CGFloat labelX = 10;
    CGFloat lableY = 160;
    
    for (int i = 0; i<title.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(labelX, lableY+30+i*50, 120, 50)];
        lable.text = title[i];
        [self.view addSubview:lable];
    }
}
//创建对应信息label
-(void)createDetailsWithDetails:(NSMutableArray *)details{
    
    CGFloat labelX = 120;
    CGFloat lableY = 160;
    
    for (int i = 0; i<details.count; i++) {
        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(labelX, lableY+30+i*50, 255, 50)];
        lable.textAlignment = NSTextAlignmentCenter;
        [lable setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [lable setTextColor:[UIColor grayColor]];
        lable.text = details[i];
        [self.view addSubview:lable];
    }
}



//创建个人主页按钮
-(void)HomePageButton{
    CGFloat buttonH = 35;
    CGFloat buttonW = 300;
    UIButton *HP = [[UIButton alloc]initWithFrame:CGRectMake(MYSScreenW/2-buttonW/2, MYSScreenH-120, buttonW, buttonH)];
    HP.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [HP setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [HP setTitle:@"好友Steam主页" forState:UIControlStateNormal];
    HP.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    //按钮弧度
    HP.layer.cornerRadius = 7;
    //阴影偏移量
    HP.layer.shadowOffset =  CGSizeMake(1, 1);
    //阴影透明度
    HP.layer.shadowOpacity = 0.8;
    //阴影颜色
    HP.layer.shadowColor =  [UIColor grayColor].CGColor;
    [HP addTarget:self action:@selector(gotoSteamHomePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:HP];
    
}


//创建个人主页网页，点击按钮时调用
-(void)gotoSteamHomePage{
    UIWebView *HomePage = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:_homePageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [HomePage loadRequest:request];
    _HomePage = HomePage;
    //返回按钮宽高
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return_white" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    [exit addTarget:self action:@selector(dismissWeb) forControlEvents:UIControlEventTouchUpInside];
    
    [HomePage addSubview:exit];
    
    [self.view addSubview:HomePage];
    
}
//关闭主页
-(void)dismissWeb{
    [_HomePage removeFromSuperview];
}


/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"好友资料";
    [_mask addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
