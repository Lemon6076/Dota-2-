//
//  MYSleftMenu_ViewController.m
//  GDota
//
//  Created by lemon on 4/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSleftMenu_ViewController.h"
#import "MYSmyData_ViewController.h"
#import "MYSmyDynamic_ViewController.h"
#import "MYSVIP_ViewController.h"
#import "MYSshare_ViewController.h"
#import "MYSset_ViewController.h"
#import "MYSabout_ViewController.h"
#import "MYSplayer.h"


@interface MYSleftMenu_ViewController ()
/**cell标题*/
@property (nonatomic , strong) NSArray *titleArray;
/**cell标题图标*/
@property (nonatomic , strong) NSArray *iconeArray;
/**二次验证view*/
@property (nonatomic , strong) UIView *coverView;
/**游戏view*/
@property (nonatomic , strong) UIView *iconView;
/**模型对象*/
@property (nonatomic , strong) MYSplayer *player;


@end

@implementation MYSleftMenu_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"drawerImage"]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //创建选项标题
    [self createTitleArray];
    //创建游戏选择按钮
    [self createIconView];
    //加载用户数据
    [self loadUserData];
  }
//加载数据
-(void)loadUserData{
  
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:IDPath];
     NSString *str = dict[@"ID"];
     //字符串转换位整型
     int DotaID = [str intValue];
     //求出64位steamid
     long long int steam = DotaID + 76561197960265728;
     //steamid转换成NsNumber
     NSNumber *steamID = [NSNumber numberWithLongLong:steam];
    //获取steam用户信息
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
         
         MYSplayer *player = [[ MYSplayer alloc]userWithDict:userData];
         _player = player;
         
         [self.tableView reloadData];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         
     }];


}


//创建选项标题
-(void)createTitleArray{
    NSArray *titleArray = @[@" ",@"未登录",@"个人动态",@"会员中心",@"分享应用",@"关于我们"];
    NSArray *iconArray = @[@" ",@"user",@"dynamic",@"vip",@"share",@"about"];

    _titleArray = titleArray;
    _iconeArray = iconArray;
}

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count ;
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
    cell.backgroundColor = [UIColor clearColor];
    //设置单元格内容
    
    
    switch (indexPath.row) {
        case 0:
            [cell.hearImage sd_setImageWithURL:[NSURL URLWithString:_player.avatarfull]];
            //设置cell不能点击
            cell.userInteractionEnabled = NO;
            break;
        case 1:
            if(_player.personaname == nil)
            {
                cell.userLabel.text =  _titleArray[1];
                cell.iconImage.image = [UIImage imageNamed:_iconeArray[1]];
            }else{
                cell.userLabel.text = _player.personaname;
                cell.iconImage.image = [UIImage new];
            }
            break;
            
        default:
            cell.letfMenuLabel.text =  _titleArray[indexPath.row];
            cell.iconImage.image = [UIImage imageNamed:_iconeArray[indexPath.row]];
            break;
    }
    return cell;
}
//添加cell的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初始化viewController
    MYSmyData_ViewController *myData = [[MYSmyData_ViewController alloc]init];
    MYSmyDynamic_ViewController *myDynamic = [[MYSmyDynamic_ViewController alloc]init];
    MYSVIP_ViewController *VIP = [[MYSVIP_ViewController alloc]init];
    MYSshare_ViewController *share = [[MYSshare_ViewController alloc]init];
    MYSabout_ViewController *about = [[MYSabout_ViewController alloc]init];
    switch (indexPath.row) {
        case 1:
            [self setViewControllerWithViewController:myData];
            break;
        case 2:
            [self setViewControllerWithViewController:myDynamic];
            break;
        case 3:
            [self setViewControllerWithViewController:VIP];
            break;
        case 4:
            [self setViewControllerWithViewController:share];
            break;
        case 5:
            [self setViewControllerWithViewController:about];
            break;
            
        default:
            break;
    }
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

/**游戏切换栏*/
-(void)createIconView{
    //创建游戏View
    UIView *iconView = [[UIView alloc]init];
    iconView.frame =CGRectMake(0,400,250 , 35);
    //iconView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.8];
    _iconView = iconView;
    [self.view addSubview:iconView];
    
    //创建游戏按钮
    //屁股
    //首位按钮位置
    CGFloat firstSeat = (iconView.size.width - 35*4)*0.5;
    //按钮宽高
    CGFloat buttonW = 35;
    UIButton *pg = [[UIButton alloc]init];
    [self setIconButtonWithButton:pg Frame:CGRectMake(firstSeat,0,buttonW,buttonW) imageName:@"pg" gameName:@"守望先锋"];
    //CS:GO
    UIButton *csgo = [[UIButton alloc]init];
    [self setIconButtonWithButton:csgo Frame:CGRectMake(firstSeat+35,0,buttonW,buttonW) imageName:@"csgo" gameName:@"CS:GO"];
    //炉石
    UIButton *ls = [[UIButton alloc]init];
    [self setIconButtonWithButton:ls Frame:CGRectMake(firstSeat+70,0,buttonW,buttonW) imageName:@"ls" gameName:@"炉石传说"];
    
    //LOL
    UIButton *lol = [[UIButton alloc]init];
    [self setIconButtonWithButton:lol Frame:CGRectMake(firstSeat+105,0,buttonW,buttonW) imageName:@"lol" gameName:@"LOL"];
    
    //添加到icoview
    [iconView addSubview:pg];
    [iconView addSubview:csgo];
    [iconView addSubview:ls];
    [iconView addSubview:lol];
}

/**
 *  设置游戏按钮
 *
 *  @param button 按钮
 *  @param frame  frame
 *  @param title  title
 */
-(void)setIconButtonWithButton:(UIButton*)button Frame:(CGRect)frame imageName:(NSString *)image gameName:(NSString *)gameName {
    
    NSString *seleteImage_name = [image stringByAppendingString:@"_highlight"];
    button.frame = frame;
    //[button setBackgroundColor:[UIColor redColor]];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:seleteImage_name] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(coverIcon) forControlEvents:UIControlEventTouchUpInside];
}
/**创建二次验证进入游戏界面View*/
-(void)coverIcon{
    //创建view遮盖在游戏图标上，进行二次验证，防止误触
    UIView *coverView = [[UIView alloc]init];
    coverView.frame =CGRectMake(0,0,_iconView.width , _iconView.height);
    coverView.backgroundColor =[[UIColor whiteColor]colorWithAlphaComponent:0.8];
    _coverView = coverView;
    
    [_iconView addSubview:coverView];
    //创建进入按钮
    UIButton *inViewBtn = [[UIButton alloc]init];
    [self setInEXitButtonWithButton:inViewBtn CoverView:coverView Title:@"进    入" Frame:CGRectMake(10,3, 70, 30)
     ];
    [inViewBtn addTarget:self action:@selector(inViewBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //创建返回按钮
    UIButton *exit = [[UIButton alloc]init];
    [self setInEXitButtonWithButton:exit CoverView:coverView Title:@"返    回" Frame:CGRectMake(165,3, 70, 30)
     ];
    [exit addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    //View出现动画
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromLeft; //设置动画的方向
    anima.duration = 0.1f;
    [coverView.layer addAnimation:anima forKey:@"pushAnimation"];
}
/**
 *  设置退出按钮
 *
 *  @param button    按钮对象
 *  @param coverView 底层View
 *  @param title     title
 *  @param frame     frame
 */
-(void)setInEXitButtonWithButton:(UIButton *)button CoverView:(UIView *)coverView Title:(NSString *)title Frame:(CGRect)frame{
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    //设置颜色
    [button setBackgroundColor:[UIColor whiteColor]];
    [button.layer setMasksToBounds:YES];   //设置yes
    [button.layer setCornerRadius:15.0f];   //弧度等于宽度的一半 就是圆角
    [coverView addSubview:button];
}

/**返回按钮动作*/
-(void)exit{
    //View出现动画
    CATransition *anima = [CATransition animation];
    anima.type = kCATransitionPush;//设置动画的类型
    anima.subtype = kCATransitionFromLeft; //设置动画的方向
    anima.duration = 0.3f;
    [_coverView.layer addAnimation:anima forKey:@"exit"];
    //延时操作
    [self performSelector:@selector(de) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(de) withObject:nil afterDelay:0.05];
    
}

//延时调用移除view
-(void)de{
    [_coverView removeFromSuperview];
}
/**进入按钮动作*/
-(void)inViewBtn{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"该功能下版本开放，敬请期待！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

@end
