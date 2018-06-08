//
//  MYSshareMatch.m
//  GDota
//
//  Created by lemon on 27/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSshareMatch.h"

@implementation MYSshareMatch

/**
 *  重写initWithFrame方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        //view宽高
        CGFloat shareViewH = 140;
        
        
        //进行自定义的操作
        UIView *shareView = [[UIView alloc]init];
        UIToolbar *bar = [[UIToolbar alloc]init];
        
        shareView.frame = CGRectMake(10,MYSScreenH-shareViewH-5, MYSScreenW-20 , shareViewH);
        
        _shareView = shareView;
        
        [shareView.layer setCornerRadius:30];
        shareView.layer.masksToBounds = YES;
        //设置frame
        bar.frame = shareView.bounds;
        _bar = bar;
        [self createShareBtn];
        //设置背景颜色
        shareView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0];
        //动画
        CATransition *anima = [CATransition animation];
        anima.type = kCATransitionPush;//设置动画的类型
        anima.subtype = kCATransitionFromTop; //设置动画的方向
        anima.duration = 0.2f;
        
        [shareView.layer addAnimation:anima forKey:nil];
        
        
        //添加大控制器view
        [shareView addSubview:bar];
        [self addSubview:shareView];

       
    }
    return self;
}


-(void)createShareBtn{
    //按钮大小
    CGFloat buttonWH = 40;
    //按钮每排y坐标
    CGFloat line1 = 20;
    CGFloat line2 = 70;
    //按钮每排x坐标
    CGFloat row0 = (MYSScreenW-20)/5 - buttonWH/2;
    CGFloat row1 = (MYSScreenW-20)/5*2 - buttonWH/2;
    CGFloat row2 = (MYSScreenW-20)/5*3 - buttonWH/2;
    CGFloat row3 = (MYSScreenW-20)/5*4 - buttonWH/2;


    //创建圆按钮
    MYSexitRound_Button *pyq = [[MYSexitRound_Button alloc]initWithbackImage:@"pyq" ButtonWH:buttonWH Frame:CGRectMake(row0 , line1, buttonWH, buttonWH)];
    [pyq addTarget:self action:@selector(click_pyq) forControlEvents:UIControlEventTouchUpInside];


    MYSexitRound_Button *kj = [[MYSexitRound_Button alloc]initWithbackImage:@"kj" ButtonWH:buttonWH Frame:CGRectMake(row1, line1, buttonWH, buttonWH)];
    [kj addTarget:self action:@selector(click_kj) forControlEvents:UIControlEventTouchUpInside];



    MYSexitRound_Button *wx = [[MYSexitRound_Button alloc]initWithbackImage:@"wx" ButtonWH:buttonWH Frame:CGRectMake(row2 , line1, buttonWH, buttonWH)];
    [wx addTarget:self action:@selector(click_wx) forControlEvents:UIControlEventTouchUpInside];


    MYSexitRound_Button *qq = [[MYSexitRound_Button alloc]initWithbackImage:@"qq" ButtonWH:buttonWH Frame:CGRectMake(row3, line1, buttonWH, buttonWH)];
    [qq addTarget:self action:@selector(click_qq) forControlEvents:UIControlEventTouchUpInside];


    MYSexitRound_Button *wb = [[MYSexitRound_Button alloc]initWithbackImage:@"wb" ButtonWH:buttonWH Frame:CGRectMake(row1 , line2, buttonWH, buttonWH)];
    [wb addTarget:self action:@selector(click_wb) forControlEvents:UIControlEventTouchUpInside];


    MYSexitRound_Button *lj = [[MYSexitRound_Button alloc]initWithbackImage:@"lj" ButtonWH:buttonWH Frame:CGRectMake(row2, line2, buttonWH, buttonWH)];
    [lj addTarget:self action:@selector(click_lj) forControlEvents:UIControlEventTouchUpInside];




    //添加到view
    [_bar addSubview:pyq];
    [_bar addSubview:kj];
    [_bar addSubview:wx];
    [_bar addSubview:qq];
    [_bar addSubview:wb];
    [_bar addSubview:lj];

}

#pragma make   分享按钮点击事件

-(void)click_pyq{
    NSLog(@"10");
    [self removeFromSuperview];
}
-(void)click_kj{
    [self removeFromSuperview];
    
}

-(void)click_wx{
    [self removeFromSuperview];
    
}

-(void)click_qq{
    [self removeFromSuperview];
    
}

-(void)click_wb{
    [self removeFromSuperview];
    
}

-(void)click_lj{
    [self removeFromSuperview];
    
}

/**
 *  返回一个UIView对象
 */
+(instancetype)menu{
    return [[self alloc]init];
}
/**
 *  显示分享菜单
 */
-(void)show{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //将分享菜单添加到窗口 并显示
    [window addSubview:self];
    //全屏
    self.frame = window.bounds;
}
//当触摸控制器view的时候调用，移除分享菜单
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
    
}



@end
