//
//  MYSperson_ViewController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSperson_ViewController.h"
#import "MYSset_ViewController.h"
#import "UIViewController+MMDrawerController.h"//第三方封装的头文件
#import "MMDrawerBarButtonItem.h"//第三方封装的头文件
#import "MYSfriends.h"
#import "MYSplayer.h"
#import "MYSfriendList_TableViewCell.h"
#import "MYSfriendData_ViewController.h"


@interface MYSperson_ViewController ()

/**朋友信息数组*/
@property (nonatomic , strong) NSMutableArray *userArr;
/**朋友数组*/
@property (nonatomic , strong) NSMutableArray *friendArr;
/**个人主页*/
@property (nonatomic , strong) UIWebView *HomePage;
/**模型数据*/
@property (nonatomic , strong) MYSplayer *player;

@end

@implementation MYSperson_ViewController

-(NSMutableArray *)userArr{
    if (_userArr == nil) {
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 60;
    //刷新数据
    [self setupRefresh];

    //创建导航栏按钮
    [self setupLeftMenuButton];
    
    //读取用户数据
    [self loadUserName];
    
    //创建导航栏按钮
    [self createNavBtn];

    
}
//读取用户数据
-(void)loadUserName{
    //用户数据
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:userPath];
    MYSplayer *player = [[MYSplayer alloc]userWithDict:dict];
    _player = player;
}
//创建导航栏按钮
-(void)createNavBtn{
    //设置按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithTarget:self image_name:@"nav_set" action:@selector(clicNavBtnR)];
    //用户名
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [userLabel setTextColor:[UIColor whiteColor]];
    [userLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    userLabel.textAlignment = NSTextAlignmentCenter;
    if (_player.personaname.length == 0) {
         userLabel.text = @"我";
    }else{
         userLabel.text = _player.personaname;
    }
    
    self.navigationItem.titleView = userLabel;
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

//获取玩家好友steamID

-(void)loadNewDataTop{
    
    //显示弹窗
    [MBProgressHUD showMessage:@"LOADING...."];
    /*
     *获取玩家好友列表：http://api.steampowered.com/ISteamUser/GetFriendList/v1/?key=< key >&steamid=< id >&relationship=< all(or)friend >
     
     */
    
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:IDPath];
    NSString *str = dict[@"ID"];
    //字符串转换位整型
    int DotaID = [str intValue];
    //求出64位steamid
    long long int steam = DotaID + 76561197960265728;
    //steamid转换成NsNumber
    NSNumber *steamID = [NSNumber numberWithLongLong:steam];
    //NSLog(@"%@",steamID);
    //获取好友列表
    AFHTTPRequestOperationManager *friend = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"steamid"] = steamID;
    params[@"relationship"] = @"all";
    
    [friend GET:@"http://api.steampowered.com/ISteamUser/GetFriendList/v1/" parameters:params success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"获取成功%@",responseObject);
         NSDictionary *friendsList = responseObject[@"friendslist"];
         NSMutableArray *temp = [NSMutableArray array];
         NSArray *friends = friendsList[@"friends"];
         
         for (NSDictionary *dic in friends) {
             MYSfriends *friend = [[MYSfriends alloc]friendWithDict:dic];
             [temp addObject:friend];
            [self loadUserDataWithsteamid:friend.steamid];
         }
         self.friendArr = temp;

         //创建搜索栏
         [self createSearch];
         

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         
     }];
}

//加载数据
-(void)loadUserDataWithsteamid:(id )steamID{

    //获取好友信息
    AFHTTPRequestOperationManager *user = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"steamids"] = steamID;
    
    [user GET:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/" parameters:params
      success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         // NSLog(@"获取成功%@",responseObject);
         NSDictionary *response =responseObject[@"response"];
         NSArray *players = response[@"players"];
         NSDictionary *userData = players[0];
        // for (NSDictionary *dic in players) {
        MYSplayer *player = [[ MYSplayer alloc]userWithDict:userData];
             
        [self.userArr addObject:player];

       
         
         static int i = 0;
         i++;
         
         if(i == _friendArr.count){
             
             [self.tableView reloadData];
             [self.tableView.mj_header endRefreshing];
             //隐藏弹窗
             [MBProgressHUD hideHUD];
             i=0;

         }
         
       
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         //隐藏弹窗
         [MBProgressHUD hideHUD];
         
     }];
    
}

#pragma mark ui控件的创建

//创建导航栏按钮
-(void)setupLeftMenuButton
{
    //创建按钮
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc]initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [leftDrawerButton setTintColor:[UIColor whiteColor]];
    //为navigationItem添加LeftBarButtonItem
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

//创建搜索栏
-(void)createSearch{
    NSString *str = [NSString stringWithFormat:@"现有好友%ld个",_friendArr.count];
    self.tableView.tableHeaderView = [MYS_searchBar createBarWithPlaceholder:str Frame:CGRectMake(0, 0, MYSScreenH, 30)];
}


//抽屉按钮动作
-(void)leftDrawerButtonPress:(id)sender
{
    //开关左抽屉
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)clicNavBtnR {
    MYSset_ViewController *set = [[MYSset_ViewController alloc]init];
    //设置窗口弹出效果
    [self setViewControllerWithViewController:set];
    
}
/**
 *  设置弹出窗口
 *
 *  @param ViewController ViewController对象
 */
-(void)setViewControllerWithViewController:(UIViewController *)ViewController{
    //通过modal方式将vc弹出
    [self presentViewController:ViewController animated:YES completion:nil];
    
}

#pragma mark tableview的设置

//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userArr.count;
}

//设置组与组之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
    
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
    MYSfriendList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSfriendList_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    MYSplayer *player = self.userArr[indexPath.section];
    //赋值头像
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:player.avatarfull] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //赋值名字
    cell.nameLabel.text = player.personaname;
    //赋值状态
    cell.stateLabel.text = [self stateWiteNum:player.personastate];
    //赋值时间
    double t = [player.lastlogoff doubleValue];
    NSString *timeStr = [@"上次登录：" stringByAppendingString:[self dateWithUnixTime:t]];
    cell.timeLabel.text = timeStr;
    
    
    return cell;
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
   
    MYSplayer *player = self.userArr[indexPath.section];
    
    //创建信息数组,并判断数据是否有空。空则显示NULL
    NSMutableArray *detail = [NSMutableArray array];
    if (player.personaname) {
        [detail addObject:player.personaname];
    }else{
        [detail addObject:@"（匿名）"];
    }
    
    if (player.realname) {
        [detail addObject:player.realname];
    }else{
        [detail addObject:@"（匿名）"];
    }
        
    if(player.steamid){
        [detail addObject:player.steamid];
    }else{
         [detail addObject:@"（空）"];
    }
    if(player.personastate){
        [detail addObject:[self stateWiteNum:player.personastate]];
    }else{
         [detail addObject:@"（空）"];
    }
    if(player.loccountrycode){
        [detail addObject:player.loccountrycode];
        
    }else{
         [detail addObject:@"（空）"];
    }if(player.lastlogoff){
        double t = [player.lastlogoff doubleValue];
        [detail addObject:[self dateWithUnixTime:t]];
    }else{
         [detail addObject:@"（空）"];
    }
    
    
    //创建好友信息窗口
    MYSfriendData_ViewController *friendData = [[ MYSfriendData_ViewController alloc]init];
    friendData.homePageUrl = player.profileurl;
    [friendData createHeadImageWithImageUrl:player.avatarfull];
    [friendData createDetailsWithDetails:detail];
    //弹出好友信息窗口
    [self presentViewController:friendData animated:YES completion:nil];


}
//关闭主页
-(void)dismissWeb{
    [_HomePage removeFromSuperview];
}

#pragma mark cell数据的判别


//用户状态判断
-(NSString *)stateWiteNum:(NSNumber *)num{
    //0：离线 1：在线 2：忙碌 3：离开 4：打盹 5：正在浏览商品 6：正在玩游戏
    int n = [num intValue];
    switch (n) {
        case 0:
            return @"离线";
            break;
        case 1:
            return @"在线";
            break;
        case 2:
            return @"忙碌";
            break;
        case 3:
            return @"离开";
            break;
        case 4:
            return @"打盹";
            break;
        case 5:
            return @"正在浏览商品";
            break;
        case 6:
            return @"正在玩游戏";
            break;
            
    }
    return 0;
}
//转换时间
-(NSString *)dateWithUnixTime:(double)time{
    
    // 获取当前时时间戳
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    //将获取时间转化成标准时间
    double unixTimeStamp =time;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    
    // 时间差
    double timet = currentTime - time;
    
    NSInteger sec = timet/60;
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    // 秒转小时
    NSInteger hours = timet/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = timet/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = timet/3600/24/30;
    if (months < 12) {
        [formatter setDateFormat:@"MM月dd日"];
        return  [formatter stringFromDate:date];
    }
    //秒转年
    NSInteger years = timet/3600/24/30/12;
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    return [NSString stringWithFormat:@"%ld年前",years];

}




@end
