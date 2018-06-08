//
//  MYSdetail_ViewController.m
//  GDota
//
//  Created by lemon on 7/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSdetail_ViewController.h"
#import "MYSheroAbility.h"
#import "MYSabilityDetailTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MYSdetail_ViewController ()
//来历
@property (nonatomic , strong)UILabel *label;
//显示更多来历
@property (nonatomic , strong)UIButton *more;
//tableView显示技能
@property (nonatomic , strong) UITableView *tableView;
/**英雄英文名数组*/
@property (nonatomic , strong) NSMutableDictionary *heroAbility;
/**模型数组*/
@property (nonatomic , strong) NSMutableArray *heroAbilityName;


@end

@implementation MYSdetail_ViewController

static int i = 1;
//懒加载数据
-(NSMutableArray *)heroAbilityName{
    if (_heroAbilityName == nil) {
        _heroAbilityName = [NSMutableArray array];
    }
    return _heroAbilityName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //获取英雄技能信息
    [self loadHeroAbility];
    //创建TableView
    [self createTableView];

    

}

#pragma mark 创建TableView 相关操作

//创建tableView
-(void)createTableView{
    //创建
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 240, MYSScreenW, MYSScreenH-240)];
    //设置行高
    tableView.rowHeight = 100;
    //隐藏分隔线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableview内边距
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 60, 0);
    //遵守协议
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
    //添加到 view
    [self.view addSubview:tableView];
    
}
//设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.heroAbilityName.count;
}
//设置组与组之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    MYSabilityDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSabilityDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    //将获取数据中的字典按技能名字取出对应的字典
    NSDictionary *dic = self.heroAbility[self.heroAbilityName[indexPath.section]];
    //再将字典转模型
    MYSheroAbility *ability = [[MYSheroAbility alloc]heroAbilityWithDict:dic];
    
    
     //MYSheroAbility *details = self
    //技能图
    NSString *imageUrl = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/abilities/%@_hp1.png",self.heroAbilityName[indexPath.section]];
    [cell.abilityImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]placeholderImage:[UIImage imageNamed:@"abitityPla"]];
    //技能名字
    cell.dnameLabel.text = ability.dname;
    //技能效果
    cell.descLabel.text = ability.desc;

    return cell;
}
//点击播放技能展示
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //将获取数据中的字典按技能名字取出对应的字典
    NSString *videoName = self.heroAbilityName[indexPath.section];
    //获取技能video plist
    NSDictionary *allAbility = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"VideoAbilityName" ofType:@"plist"]];
    NSString *videoUrl = [NSString stringWithFormat:@"%@",allAbility[videoName]];
    
    //创建播放窗口
    MPMoviePlayerViewController *playVC = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:videoUrl]];
    //弹出播放窗口
    [self presentViewController:playVC animated:YES completion:nil];

    
}

#pragma mark 创建界面相应控件
//背景图
-(void)backgroundImageWithImageUrl:(NSString *)Url{
    
    //模糊View
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, 135)];
    [mask setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.5]];
    
    //添加英雄图
    UIImageView *hero = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, 135)];
    [hero setContentMode:UIViewContentModeScaleAspectFill];
    hero.clipsToBounds = YES;
    [hero sd_setImageWithURL:[NSURL URLWithString:Url]placeholderImage:[UIImage imageNamed:@"headBackground"]];
    
    [hero addSubview:mask];
    [self.view addSubview:hero];

    
}

//来历说明
-(void)bioWithtext:(NSString *)text{
    UILabel*label = [[UILabel alloc]init];
    UIButton *more = [[UIButton alloc]init];
    //more.backgroundColor = [UIColor redColor];
    
    
    [more addTarget:self action:@selector(showMore) forControlEvents:UIControlEventTouchUpInside];
    
    [label setFont:[UIFont systemFontOfSize:13.0f]];
    [label setBackgroundColor:[UIColor whiteColor]];
    label.text = text;
    label.numberOfLines = 0;
    label.frame = CGRectMake(20, 90, MYSScreenW-40, 150);
    more.frame = label.frame;
    //label弧度
    label.layer.cornerRadius = 15;
    //阴影偏移量
    label.layer.shadowOffset =  CGSizeMake(1, 1);
    //阴影透明度
    label.layer.shadowOpacity = 0.8;
    //阴影颜色
    label.layer.shadowColor =  [UIColor grayColor].CGColor;
    _label = label;
    _more = more;
    [self.view addSubview:label];
    [self.view addSubview:more];

}
//显示更多来历
-(void)showMore{
    
    if (i%2!=0) {
        
     CGSize lblSize = [_label.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
     _label.frame = CGRectMake(20, 90, lblSize.width-15, lblSize.height);
    _more.frame = _label.frame;
    }else{
        _label.frame = CGRectMake(20, 90, MYSScreenW-40, 150);
        _more.frame = _label.frame;
    }
    i++;
}

//标题和退出按钮.
-(void) setUpExitButtonWithName:(NSString *)name{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = name;
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];

}

#pragma mark 获取数据
-(void)loadHeroAbility{
    //创建一个管理理对象
    AFHTTPRequestOperationManager *details = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"l"] = @"zh";
    /*
    获取英雄技能信息  http://www.dota2.com/jsfeed/abilitydata/?l=zh
     */
    
    //显示弹窗
    [MBProgressHUD showMessage:@"LOADING...."];
    //获取技能详细
    [details GET:@"http://www.dota2.com/jsfeed/abilitydata/?language=zh" parameters:params
         success:^
     (AFHTTPRequestOperation *operation, id responseObject ) {
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         //NSLog(@"请求成功");
         //数据解析
         NSMutableDictionary *abilitydata = responseObject[@"abilitydata"];
         
         _heroAbility = abilitydata;
         //NSLog(@"12345%@",abilitydata[@"skywrath_mage_ancient_seal"]);
         
         for (NSString *name in abilitydata) {
             //筛选获取数据中带有英雄名字的字典数据名
                 if([name rangeOfString:_heroName_en].location != NSNotFound)
                 {
                     if ([name rangeOfString:@"special_bonus"].location == NSNotFound) {
                         [self.heroAbilityName addObject:name];
                     }
                    
                 }

            }
         

         //刷新tableView
         [self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         NSLog(@"请求失败%@",error);
     }];
    

    
}


#pragma mark 事件处理
/**收回界面*/
-(void)dismissVc{
    i = 1  ;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
