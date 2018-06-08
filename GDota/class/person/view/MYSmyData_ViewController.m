//
//  MYSmyData_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//


#import "MYSmyData_ViewController.h"
#import "UIButton+WebCache.h"
#import "MYSplayer.h"

@interface MYSmyData_ViewController ()
/**tableview*/
@property (nonatomic ,strong)UITableView *mydataTableView;
/**标题数组*/
@property (nonatomic , strong)NSArray *titleArr;
/**个人主页*/
@property (nonatomic , strong) UIWebView *HomePage;

/**模型对象*/
@property (nonatomic , strong) MYSplayer *player;

@end

@implementation MYSmyData_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //创建tableView
    [self createTableView];
    self.mydataTableView.delegate = self;
    self.mydataTableView.dataSource = self;
    //加载数据
    [self loadUserData];
    
    //退出按钮和标题
    [self createExitButton];
    
    //创建主页按钮
    [self HomePageButton];
    
    //创建头像和头像背景
    [self createHeadIconB];

    
  
    
}

//加载数据
-(void)loadUserData{
    
    NSArray *titleArr = @[@"账户名：",@"真实姓名：",@"SteamID：",@"状态：",@"地区：",@"上次登录时间："];
    self.titleArr = titleArr;
    //用户数据
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:userPath];
    MYSplayer *player = [[MYSplayer alloc]userWithDict:dict];
    _player = player;
    
}

//设置头像背景加模糊，加头像按钮
-(void)createHeadIconB{
    //模糊View
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, 170)];
    [mask setBackgroundColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.6]];

    //背景图
    UIImageView *headBackground = [[UIImageView alloc]init];
    [headBackground setContentMode:UIViewContentModeScaleAspectFill];
    headBackground.clipsToBounds = YES;
    headBackground.frame = CGRectMake(0, 0, MYSScreenW, 135);
    [headBackground sd_setImageWithURL:[NSURL URLWithString:_player.avatarfull]placeholderImage:[UIImage imageNamed:@"headBackground"]];
    
    
    //头像
    UIImageView *headImage = [[UIImageView alloc]init];
    headImage.frame = CGRectMake(MYSScreenW/2-35, 100, 70, 70);
    [headImage sd_setImageWithURL:[NSURL URLWithString:_player.avatarfull]placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [headImage setContentMode:UIViewContentModeScaleAspectFit];
    [headImage.layer setMasksToBounds:YES];   //设置yes
    [headImage.layer setCornerRadius:35.0f];   //弧度等于宽度的一半 就是圆角
    
    
    [self.view addSubview:headBackground];
    [headBackground addSubview:mask];
    
    [self.view addSubview:headImage];

    
}
//创建个人主页按钮
-(void)HomePageButton{
    CGFloat buttonH = 35;
    CGFloat buttonW = 300;
    UIButton *HP = [[UIButton alloc]initWithFrame:CGRectMake(MYSScreenW/2-buttonW/2, MYSScreenH-120, buttonW, buttonH)];
    HP.titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    [HP setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [HP setTitle:@"个人Steam主页" forState:UIControlStateNormal];
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
    NSURL *url = [NSURL URLWithString:_player.profileurl];
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
    title.text = @"个人资料";
    [self.view addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//创建tableview
-(void)createTableView{
    UITableView *mydata = [[UITableView alloc]init];
    mydata.frame = CGRectMake(0, 140, MYSScreenW, MYSScreenH-210);
    mydata.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mydataTableView = mydata;
    mydata.contentInset = UIEdgeInsetsMake(40, 0, 60, 0);
    [self.view addSubview:mydata];
}

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.titleArr.count;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    MYSletfMenu_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSletfMenu_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置cell不能点击
    cell.userInteractionEnabled = NO;
    
    double t = [_player.lastlogoff doubleValue];
    
    switch (indexPath.row) {
        case 0:
            //真是姓名
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = _player.personaname;
            break;
        case 1:
            //真是姓名
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = _player.realname;
            break;
        case 2:
            //steamid
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = _player.steamid;
            break;
        case 3:
            //状态
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = [self stateWiteNum:_player.personastate];
            break;
        case 4:
            //地区
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = _player.loccountrycode;
            break;
        case 5:
            //上次登录时间
            cell.textLabel.text = _titleArr[indexPath.row];
            cell.contentLable.text = [self dateWithUnixTime:t];
            break;
            
        default:
            
            break;
    }
    
    
    
    return cell;
}
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
        [formatter setDateFormat:@"MM.dd"];
        return  [formatter stringFromDate:date];
    }
    //秒转年
    NSInteger years = timet/3600/24/30/12;
    [formatter setDateFormat:@"yyyy.MM.dd"];
    return [NSString stringWithFormat:@"%ld年前",years];
    
}



@end
