//
//  MYShistoryMatch_ViewController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYShistoryMatch_ViewController.h"
#import "MYShistory_ViewController.h"
#import "MYSmatchList.h"
#import "MYSmatch_TableViewCell.h"
#import "MYSmatchPlayer.h"
#import "MYSmatchDetails.h"

@interface MYShistoryMatch_ViewController ()
/**比赛数据*/
@property (nonatomic , strong) NSMutableArray *matches;
/**比赛结果*/
@property (nonatomic , strong) NSMutableArray *radiant;
/**dotaID 32*/
@property (nonatomic , copy) NSString *dotaID;

@end

@implementation MYShistoryMatch_ViewController

-(NSMutableArray *)matches{
    if (_matches == nil) {
        _matches = [NSMutableArray array];
        _radiant = [NSMutableArray array];

    }
    return _matches;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 110;
    //隐藏分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //刷新数据
    [self setupRefresh];

}

#pragma mark 刷新
//设置下拉刷新
-(void)setupRefresh{
    //创建下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataTop)];
    //自动切换透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    //自动下拉刷新
    [self.tableView.mj_header beginRefreshing];
    
    //创建上拉添加
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataTBottom)];
    
}

#pragma mark 加载数据

-(void)loadNewDataTop{
    
    //显示弹窗
    [MBProgressHUD showMessage:@"LOADING...."];
    /*
     *获取历史战绩列表：https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=< key >&account_id=XXXXX
     */
    self.matches = [NSMutableArray array];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:IDPath];
    NSString *str = dict[@"ID"];
    _dotaID = str;
    //获取战绩信息
    AFHTTPRequestOperationManager *user = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"account_id"] = str;
    params[@"game_mode"] = @"0";
    
    params[@"matches_requested"] = @"10";
    
    [user GET:@"http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v1" parameters:params
      success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         // NSLog(@"获取成功：%@",responseObject);
        // [responseObject writeToFile:@"/Users/lemon/Desktop/GetDotaData/match.plist" atomically:YES];
         NSDictionary *result = responseObject[@"result"];
         NSArray *matches = result[@"matches"];
         for (NSDictionary *dic in matches) {
             MYSmatchList *match = [[MYSmatchList alloc]matchWithDict:dic];
             [self.matches addObject:match];
             
             /*
              •获取比赛详情	https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=< key >&match_id=XXXXX

              */
             // 创建一个URL ：请求路径
             NSString *urlStr = [NSString stringWithFormat:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=%@&match_id=%@",@"D1586934B4121C02725F7D03D1CF16D4",match.match_id];
            
             NSURL *url = [NSURL URLWithString:urlStr];
              // 创建一个请求，默认为GET请求
             NSURLRequest *request = [NSURLRequest requestWithURL:url];
             // 发送一个同步请求(在主线程发送请求)
             NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
             NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSDictionary *result = responseObject[@"result"];
             MYSmatchDetails *radiant = [[MYSmatchDetails alloc]matchDetailsWithDict:result];
             NSNumber *Bra = [NSNumber numberWithBool:radiant.radiant_win];
             [self.radiant addObject:Bra];

                }
         
         [self.tableView.mj_header endRefreshing];
         [self.tableView reloadData];
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         [self.tableView.mj_header endRefreshing];
         
     }];
    

}

//上拉刷新
-(void)loadMoreDataTBottom{
    //去除战绩数组最后一项
     //[self.matches removeLastObject];
     //
    //获得倒数第二项
    MYSmatchList *match = [self.matches lastObject];
   // MYSmatchDetails *detail = [self.radiant lastObject];
    //去除战绩数组最后一项
    [self.matches removeLastObject];
    [self.radiant removeLastObject];
    /*
     *获取历史战绩列表：https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=< key >&account_id=XXXXX
     */
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:IDPath];
    NSString *str = dict[@"ID"];
    
    //获取战绩信息
    AFHTTPRequestOperationManager *user = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"account_id"] = str;
    params[@"game_mode"] = @"0";
    params[@"matches_requested"] = @"10";
    params[@"start_at_match_id"] = match.match_id;
    
    [user GET:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v1" parameters:params
      success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         // NSLog(@"获取成功：%@",responseObject);
         [responseObject writeToFile:@"/Users/lemon/Desktop/GetDotaData/dota.plist" atomically:YES];
         NSDictionary *result = responseObject[@"result"];
         NSArray *matches = result[@"matches"];
         for (NSDictionary *dic in matches) {
             MYSmatchList *match = [[MYSmatchList alloc]matchWithDict:dic];
             [self.matches addObject:match];
             
             /*
              •获取比赛详情	https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=< key >&match_id=XXXXX
              
              */
             // 创建一个URL ：请求路径
             NSString *urlStr = [NSString stringWithFormat:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=%@&match_id=%@",@"D1586934B4121C02725F7D03D1CF16D4",match.match_id];
             
             NSURL *url = [NSURL URLWithString:urlStr];
             // 创建一个请求，默认为GET请求
             NSURLRequest *request = [NSURLRequest requestWithURL:url];
             // 发送一个同步请求(在主线程发送请求)
             NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
             NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSDictionary *result = responseObject[@"result"];
             MYSmatchDetails *radiant = [[MYSmatchDetails alloc]matchDetailsWithDict:result];
             NSNumber *Bra = [NSNumber numberWithBool:radiant.radiant_win];
             [self.radiant addObject:Bra];
             

         }
         
         [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         [self.tableView.mj_footer endRefreshing];
     }];

}


#pragma mark tableview设置
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //根据数据量显示或者隐藏footer
    self.tableView.mj_footer.hidden = (self.matches.count == 0);
    return self.matches.count;
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
    MYSmatch_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSmatch_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    MYSmatchList *match = self.matches[indexPath.section];
    //天辉是否胜利
    BOOL re = [_radiant[indexPath.section] boolValue];
    static BOOL isRadiant = NO;
    //MYSmatchDetails *detail = self.radiant[indexPath.section];
    
     for (int i = 0; i<10; i++) {
      //获取玩家模型数组
         
     MYSmatchPlayer *player = match.players[i];
      //转换英雄ID和玩家dotaID
         
     NSString *ID = [player.hero_id stringValue];
     NSString *dotaID = [player.account_id stringValue];
     int slot = [player.player_slot intValue];
     
      //判断登录玩家所在的阵营,并给下标到对应的阵营名下
         if ([dotaID isEqualToString:self.dotaID]) {
             if(slot <= 4){
             cell.indexView_1.backgroundColor = [UIColor redColor];
             cell.indexView_a.backgroundColor = [UIColor whiteColor];
             
             }else{
                 
             cell.indexView_1.backgroundColor = [UIColor whiteColor];
             cell.indexView_a.backgroundColor = [UIColor redColor];
                 
             }
         }
         
     //NSLog(@"第%ld行%@",indexPath.section,player.hero_id);
    //显示英雄图，根据阵营，英雄ID识别
         //NSString *ID = [player.hero_id stringValue];
         NSString *image = [NSString stringWithFormat:@"%@.jpg",ID];

         switch (slot) {
                 //天辉
             case 0:
                 cell.heroImage0.image = [UIImage imageNamed:image];
                 break;
             case 1:
                 cell.heroImage1.image = [UIImage imageNamed:image];
                 break;
             case 2:
                 cell.heroImage2.image = [UIImage imageNamed:image];
                 break;
             case 3:
                 cell.heroImage3.image = [UIImage imageNamed:image];
                 break;
             case 4:
                 cell.heroImage4.image = [UIImage imageNamed:image];
                 break;
             default:
                 break;
         }
                //梦魇
         switch (slot) {
             case 128:
                 cell.heroImagea.image = [UIImage imageNamed:image];
                 break;
             case 129:
                 cell.heroImageb.image = [UIImage imageNamed:image];
                 break;
             case 130:
                 cell.heroImagec.image = [UIImage imageNamed:image];
                 break;
             case 131:
                 cell.heroImaged.image = [UIImage imageNamed:image];
                 break;
             case 132:
                 cell.heroImagee.image = [UIImage imageNamed:image];
                 break;
             default:
                 break;
         }
         
     }
   
    //匹配类型
    cell.lobbyLable.text = [self lobby_typeWithNum:match.lobby_type];
    //比赛id
    NSString *m = [match.match_id stringValue];
    NSString *mID = [@"比赛ID：" stringByAppendingString:m];
    cell.matchIDLabel.text = mID;
    //比赛开始时间
    double t = [match.start_time doubleValue];
    NSString *time = [@"开始时间：" stringByAppendingString:[self dateWithUnixTime:t]];
    cell.startTimeLabel.text = time;
    
    //NSLog(@"第%ld行%@",indexPath.section,result);
    
    //比赛结果 胜负
    if (re) {
            cell.winLabel.text = @"天辉获胜";
       
    } else {
            cell.winLabel.text = @"夜魇获胜";
    }
    

    
    //阵营
    cell.slot1Label.text = @"天辉";
    cell.slotaLabel.text = @"夜魇";
    //参赛头像头像
    //NSLog(@"*******/////%@",self.radiant);
    
    
    return cell;
}
//设置组与组之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获得战绩模型
    MYSmatchList *match = self.matches[indexPath.section];
    //初始化战绩窗口
    MYShistory_ViewController *history = [[MYShistory_ViewController alloc]init];
    //场数ID转换成string类型，并赋值给窗口
    NSString *ID = [match.match_id stringValue];
    history.match_id = ID;
    
    //弹出战绩窗口
    [self presentViewController:history animated:YES completion:nil];
}


#pragma mark cell内容的判定

//匹配类型
-(NSString *)lobby_typeWithNum:(NSNumber *)num{
    int n = [num intValue];
    switch (n) {
        case -1:
            return @"无效";
            break;
        case 0:
            return @"公共匹配";
            break;
        case 1:
            return @"练习";
            break;
        case 2:
            return @"锦标赛";
            break;
        case 3:
            return @"教程";
            break;
        case 4:
            return @"与机器人合作";
            break;
        case 5:
            return @"合作比赛";
            break;
        case 6:
            return @"SOLO对线";
            break;
        case 7:
            return @"排名匹配";
            break;
        case 8:
            return @"中路SOLO";
            break;
            
    }
    return 0;
}


//转换时间
-(NSString *)dateWithUnixTime:(double)time{
    //unix时间戳转正常时间格式；
    double unixTimeStamp =time;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy.MM.dd  HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
