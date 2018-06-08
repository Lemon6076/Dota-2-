//
//  MYSmyDynamic_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSmyDynamic_ViewController.h"
#import "MYSmessage_ViewController.h"
#import "MYSnotice_ViewController.h"
#import "MYSsupport_ViewController.h"


@interface MYSmyDynamic_ViewController ()

/** 上一次点击的标题按钮 */
@property (nonatomic, weak) MYStitle_Button *previousClickedTitleButton;
@property (nonatomic , strong)NSArray *titles;
@property (nonatomic , strong) UIView *contentView;

@end

@implementation MYSmyDynamic_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createChildView];
    //创建动态标题栏
    [self createCaption];

    // 添加第0个子控制器的view
    [self addChildVcView:0];

    //退出按钮和标题
    [self createExitButton];

}
//创建各窗口ViewController对象
-(void)createChildView{
    [self addChildViewController:[[MYSmessage_ViewController alloc]init]];
    [self addChildViewController:[[MYSnotice_ViewController alloc]init]];
    [self addChildViewController:[[MYSsupport_ViewController alloc]init]];
}

/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"个人动态";
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}
//创建标题栏
-(void)createCaption{
    //创建
    UIView *captionView = [[UIView alloc]initWithFrame:CGRectMake(0, 70, MYSScreenW, 40)];
    captionView.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 90, MYSScreenW, MYSScreenH-110)];
    _contentView = contentView;
    [self.view addSubview:contentView];

    [self.view addSubview:captionView];
    // 文字
    NSArray *titles = @[@"回复消息", @"通知",@"赞"];
    _titles = titles;
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = captionView.width / count;
    CGFloat titleButtonH = captionView.height;
    
    // 创建count个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        MYStitle_Button *titleButton = [[MYStitle_Button alloc] init];
        titleButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [captionView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
    
    // 标题按钮默认状态
    MYStitle_Button *firstTitleButton = captionView.subviews.firstObject;
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
}

- (IBAction)titleButtonClick:(MYStitle_Button *)titleButton
{
    // 重复点击了标题按钮
    if (self.previousClickedTitleButton == titleButton) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"重复点击" object:nil];
    }
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}

/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(MYStitle_Button *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{

            // 添加子控制器的view
        [self addChildVcView:index];
    }];
    
}

/**
 *  添加第index个子控制器的contentView中
 */
- (void)addChildVcView:(NSUInteger)index
{
    //UIViewController *childVc = self.childViewControllers[index];
    
    for (int i = 0; i<_titles.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        if (index == i) {
            // 取出index位置对应的子控制器view
            UIView *childVcView = childVc.view;
            // 添加子控制器的view到contentView中
            [_contentView addSubview:childVcView];
        }
        else if(childVc.isViewLoaded){

            [childVc.view removeFromSuperview];
        }
    }
    
   
}


/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
