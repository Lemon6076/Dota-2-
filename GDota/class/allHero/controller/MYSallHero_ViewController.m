//
//  MYSallHero_ViewController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSallHero_ViewController.h"
#import "MYSdetail_ViewController.h"
#import "MYSdetails.h"



@interface MYSallHero_ViewController ()
/**英雄数组*/
@property (nonatomic , strong) NSMutableArray *hero;
/**英雄英文名数组*/
@property (nonatomic , strong) NSMutableArray *heroName;


@end

@implementation MYSallHero_ViewController

-(NSMutableArray *)hero{
    if (_hero == nil) {
        _hero = [NSMutableArray array];
    }
    return _hero;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建刷新
    [self setupRefresh];
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100;
   
}

//设置下拉刷新
-(void)setupRefresh{
    //创建下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataTop)];
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //自动下拉刷新
    [self.tableView.mj_header beginRefreshing];
}

-(void)loadNewDataTop{
    //创建一个管理理对象
    AFHTTPRequestOperationManager *details = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    //params[@"language"] = @"zh";

    //params[@"account_id"] = @"139608073";
    //params[@"matches_requested"] = @"30";
    /*获取历史战绩列表：https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=< key >&account_id=XXXXX
     *获取比赛详情：https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=< key >&match_id=XXXXX
     *获取英雄列表：https://api.steampowered.com/IEconDOTA2_570/GetHeroes/v0001/?key= < key >
     *获取中文英雄介绍http://www.dota2.com/jsfeed/heropickerdata?v=18874723138974056&l=zh
     
     *获取英雄图片：http://cdn.dota2.com/apps/dota2/images/heroes/< name > _< suffix>    - name(英文名，去掉npc_hero_dota之后的名字)
     - suffix(图片要求：sb.png/ lg.png/full.png/vert.png)
     *获取玩家信息：http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=< key >&steamids=< steamids >
     - steamids(64-bit):STEAMID32 + 76561197960265728 = STEAMID64
     steamID32等同于DotaID
     *获取玩家好友列表：http://api.steampowered.com/ISteamUser/GetFriendList/v1/?key=< key >&steamid=< id >&relationship=< all(or)friend >
     *物品信息：https://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001/?key=< key >
     */
    
    //显示弹窗
    [MBProgressHUD showMessage:@"LOADING...."];
    
    //获取英雄名字
    //获取详细
    [details GET:@"http://www.dota2.com/jsfeed/heropickerdata?v=18874723138974056&language=zh" parameters:nil
      success:^
     (AFHTTPRequestOperation *operation, id responseObject ) {
         
         //隐藏弹窗
         [MBProgressHUD hideHUD];
        // static NSInteger i = 0;
         NSLog(@"请求成功");
         NSMutableArray *arr = [NSMutableArray array];
         NSMutableArray *hero = [NSMutableArray array];
         for (NSString *str in responseObject) {
             [arr addObject:str];
         }
         _heroName = arr;
         for(NSInteger i = 0 ; i<arr.count ; i++) {
             MYSdetails *details = [[MYSdetails alloc]detailsWithDict:responseObject[arr[i]]];
             [hero addObject:details];
         }
         _hero = hero;
         
         //创建搜索栏
         [self createSearch];
         //结束下拉刷新
         [self.tableView.mj_header endRefreshing];
         [self.tableView reloadData];

         // MYSdetails *detail = [[MYSdetails alloc]detailsWithDict:d];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         NSLog(@"请求失败%@",error);
     }];

}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.hero.count;

}

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    MYSheros_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSheros_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    MYSdetails *hero = self.hero[indexPath.section];
    
    NSString *str = [NSString stringWithFormat:@"/ "];
    for (int i = 0; i<hero.roles_l.count; i++) {
    
        NSString *strTemp = [str stringByAppendingString:hero.roles_l[i]];
        NSString *strTemp1 = [strTemp stringByAppendingString:@" / "];

        str = strTemp1;
    }
     cell.rolesLabel.text = str;
    //英雄名字
    cell.heroLabel.text = hero.name;
    //英雄战斗属性
    cell.atkLabel.text = hero.atk_l;
    //sb.png = 59*33  lg.png = 205*11 full.png = 256*114  vert.jpg = 234272
    NSString *imageUrl = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_full.png",_heroName[indexPath.section]];
  
    [cell.heroImage sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    return cell;
}
//设置组与组之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 10;

}

//添加加载动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置cell的显示动画为3D缩放
    //xy方向缩放的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    //设置动画时间为0.25秒,xy方向缩放的最终值为1
    [UIView animateWithDuration:0.25 animations:^{
        
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
    }completion:^(BOOL finish){
        
    }];
}
//创建搜索栏
-(void)createSearch{
    NSString *str = [NSString stringWithFormat:@"现有英雄%ld个",_heroName.count];
    self.tableView.tableHeaderView = [MYS_searchBar createBarWithPlaceholder:str Frame:CGRectMake(0, 0, MYSScreenH, 30)];
}

//点击cell，把searchBar的键盘隐藏
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    
      MYSdetails *hero = self.hero[indexPath.section];
        MYSheros_TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell)
          {
             NSString *name = hero.name;
             NSString *bio = hero.bio;
              //创建详情页
              MYSdetail_ViewController *detail = [[ MYSdetail_ViewController alloc]init];
              detail.heroName_en = _heroName[indexPath.section];
              
              //英雄图
              NSString *imageUrl = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/heroes/%@_full.png",_heroName[indexPath.section]];
              [detail backgroundImageWithImageUrl:imageUrl];

              //来历说明
              [detail bioWithtext:bio];
              //title和退出键
              [detail setUpExitButtonWithName:name];
                           //通过modal方式将vc弹出
              [self presentViewController:detail animated:YES completion:nil];
              
              
            
        }
}

@end
