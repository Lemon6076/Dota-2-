//
//  MYSdiscover_ViewController.m
//  GDota
//
//  Created by lemon on 27/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSdiscover_ViewController.h"
#import "MYSforum_ViewController.h"
#import "MYSnew_ViewController.h"


@interface MYSdiscover_ViewController ()
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) MYStitle_Button *previousClickedTitleButton;

@property (nonatomic , strong) UIScrollView *scrollView;

@end

@implementation MYSdiscover_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建子控件
    [self createChildView];
    //创建scrollView
    [self createScrollView];
    //创建标题
    [self createTitleView];
    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
}

-(void)createTitleView{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    titleView.frame = CGRectMake(0, 64, self.view.frame.size.width, 30);
    [self.view addSubview:titleView];
    self.titlesView = titleView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
    
}

//创建各窗口ViewController对象
-(void)createChildView{
    [self addChildViewController:[[MYSforum_ViewController alloc]init]];
    [self addChildViewController:[[MYSnew_ViewController alloc]init]];

}
/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"新闻", @"论坛"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.width / count;
    CGFloat titleButtonH = self.titlesView.height;
    
    // 创建count个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        MYStitle_Button *titleButton = [[MYStitle_Button alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    MYStitle_Button *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.height = 2;
    titleUnderline.y = self.titlesView.height - titleUnderline.height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit];
    // 根据文字内容计算尺寸
    self.titleUnderline.width = firstTitleButton.titleLabel.width + UNDERLIN;
    self.titleUnderline.centerX = firstTitleButton.centerX;
}


#pragma mark   监听按钮的点击
/*
*  点击标题按钮
*/
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
        // 处理下划线
        self.titleUnderline.width = titleButton.titleLabel.width + UNDERLIN;
        self.titleUnderline.centerX = titleButton.centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}

/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}




/*
创建scrollView器，并添加子控件view
 */
-(void)createScrollView{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);

}

#pragma mark   监听ScrollView滑动


/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 点击对应的标题按钮
    MYStitle_Button *titleButton = self.titlesView.subviews[index];
    //    [self titleButtonClick:titleButton];
    [self dealTitleButtonClick:titleButton];
    NSLog(@"%ld",index);
}






@end
