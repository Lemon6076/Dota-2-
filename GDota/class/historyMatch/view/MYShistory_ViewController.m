//
//  MYShistory_ViewController.m
//  GDota
//
//  Created by lemon on 27/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYShistory_ViewController.h"
#import "MYSmatchDetails.h"
#import "MYSmatchPlayerDetails.h"
#import "MYSplayer.h"
#import "MYSmatchDetail_TableViewCell.h"
#import "MYSItems.h"
#import "MYSshareMatch.h"
#import "MYSexitRound_Button.h"


@interface MYShistory_ViewController ()

//cell是否是展开状态
@property (nonatomic , assign) BOOL isOpen;
//点击的行数

@property (nonatomic , assign) NSIndexPath* selectesIndex;

//战绩TableView
@property (nonatomic , strong) UITableView *tableView;
//战绩详情模型对象
@property (nonatomic , strong) MYSmatchDetails *detail;
//蒙版
@property (nonatomic , strong) UIView *mask;
/**朋友信息数组*/
@property (nonatomic , strong) NSMutableArray *userArr;
//两阵营玩家信息数组
@property (nonatomic , strong) NSMutableArray *tempRadiant;
@property (nonatomic , strong) NSMutableArray *tempdire;
//两阵营英雄的物品
@property (nonatomic , strong) NSMutableArray *itemRadiant;
@property (nonatomic , strong) NSMutableArray *itemdire;
//物品数组
@property (nonatomic , strong) NSMutableArray *item;

@end

@implementation MYShistory_ViewController
//数据懒加载
-(NSMutableArray *)userArr{
    if (_userArr == nil) {
        _userArr = [NSMutableArray array];
    }
    return _userArr;
}
-(NSMutableArray *)tempRadiant{
    if (_tempRadiant == nil) {
        _tempRadiant = [NSMutableArray array];
    }
    return _tempRadiant;
}
-(NSMutableArray *)tempdire{
    if (_tempdire == nil) {
        _tempdire = [NSMutableArray array];
    }
    return _tempdire;
}

-(NSMutableArray *)itemRadiant{
    if (_itemRadiant == nil) {
        _itemRadiant = [NSMutableArray array];
    }
    return _itemRadiant;
}
-(NSMutableArray *)itemdire{
    if (_itemdire == nil) {
        _itemdire = [NSMutableArray array];
    }
    return _itemdire;
}

-(NSMutableArray *)item{
    if (_item == nil) {
        _item = [NSMutableArray array];
    }
    return _item;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   //获取数据
    [self loadMatchDetail];
    //创建tableView
    [self createTableView];
    //创建详情标题
    [self createDetailTitle];
    //创建退出按钮和标题栏
    [self createExitButton];
   // NSLog(@"%@",[self itemNameWithID:[[NSNumber alloc]initWithInt:12]]);
    
}

#pragma mark 创建UI控件
  //创建详情标题
-(void)createDetailTitle{
    //创建蒙版
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, 95)];
    mask.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    _mask = mask;
    
    //按钮宽高
    CGFloat shareWH = 20;
    
    //分享按钮
    UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake(MYSScreenW-50, mask.frame.size.height/2-shareWH/2, shareWH, shareWH)];
    //设置背景图
    [share setImage:[UIImage imageNamed:@"share_match_detail"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageNamed:@"share_match_detail_highlight"] forState:UIControlStateHighlighted];
    [share addTarget:self action:@selector(share_match) forControlEvents:UIControlEventTouchUpInside];
    
    //开始时间
    UILabel *starTime = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, 40, 30)];
    starTime.font = [UIFont boldSystemFontOfSize:13.0f];
    starTime.text = @"开始：";
    //时长
    UILabel *duration = [[UILabel alloc]initWithFrame:CGRectMake(130, 70, 40, 30)];
    duration.font = [UIFont boldSystemFontOfSize:13.0f];
    duration.text = @"时长：";
    //比赛模式
    UILabel *lobby_type = [[UILabel alloc]initWithFrame:CGRectMake(260, 70, 40, 30)];
    lobby_type.font = [UIFont boldSystemFontOfSize:13.0f];
    lobby_type.text = @"类型：";
    //添加到蒙版 和 view
    [mask addSubview:share];
    [mask addSubview:starTime];
    [mask addSubview:duration];
    [mask addSubview:lobby_type];
    [self.view addSubview:mask];
}
/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"战  绩";
    [self.mask addSubview:title];
    [self.view addSubview:exit];
    [exit addTarget:self action:@selector(dismissVc) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark 创建tableView 和关于tableview

-(void)createTableView{
    UITableView *tableView = [[UITableView alloc]init];
    //tableView.rowHeight = 60;
    //隐藏分隔线
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //遵守协议
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = self.view.bounds;
    //设置tableview内边距
    tableView.contentInset = UIEdgeInsetsMake(95, 0, 60, 0);
    _tableView = tableView;
    [self.view addSubview:tableView];
}
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击到对应的cell后对应cell展开，否者原高度
    if (indexPath.section == _selectesIndex.section && indexPath.row == _selectesIndex.row && _selectesIndex != nil ) {
        if (_isOpen == YES) {
            //cell上的label高度自适应
            return 120;
            
        }
            
        return 60;
    }
    return 60;
    
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.userArr.count;
}

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.userArr[section];
    return arr.count;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    MYSmatchDetail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSmatchDetail_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容

    //_isOpen = NO;
    //NSLog(@"*****%@",self.userArr);
    if (indexPath.section == 0) {
        MYSplayer *player = self.tempRadiant[indexPath.row];
        MYSmatchPlayerDetails *playerDetail = self.itemRadiant[indexPath.row];
        
        //玩家头像
        [cell.playerImage sd_setImageWithURL:[NSURL URLWithString:player.avatarfull]placeholderImage:[UIImage imageNamed:@"pla"]];
        //玩家名字
        cell.nameLabel.text = player.personaname;
        //玩家等级
        NSString *lv = [NSString stringWithFormat:@"LV.%@",[playerDetail.level stringValue]];
        cell.lvLabel.text = lv;
        //玩家装备图
        //NSLog(@"%@",[self itemNameWithID:self.itemRadiant[indexPath.row][1]]);
        [cell.itemImage0 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_0]]];
        [cell.itemImage1 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_1]]];
        [cell.itemImage2 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_2]]];
        [cell.itemImage3 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_3]]];
        [cell.itemImage4 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_4]]];
        [cell.itemImage5 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_5]]];
        //玩家个人击杀数
        NSString *kill = [NSString stringWithFormat:@"杀：%@",[playerDetail.kills stringValue]];
        cell.killLabel.text = kill;
        //玩家个人死亡数
        NSString *death = [NSString stringWithFormat:@"死：%@",[playerDetail.deaths stringValue]];
        cell.deathLabel.text = death;
        //玩家个人辅助数
        NSString *assists = [NSString stringWithFormat:@"辅：%@",[playerDetail.assists stringValue]];
        cell.assistsLabel.text = assists;
        //玩家个人经济数
        int gold_s = [playerDetail.gold_spent intValue];
        int gold = [playerDetail.gold intValue];
        int golds = gold_s+gold;
        NSString *g = [NSString stringWithFormat:@"经济：%d",golds];
        cell.goldLabel.text = g;
        //点击显示更多详情
        if (_isOpen && indexPath.row == _selectesIndex.row && indexPath.section == _selectesIndex.section) {
            NSString *hero = [NSString stringWithFormat:@"%@.jpg",[playerDetail.hero_id stringValue]];
            NSString *hero_h = [NSString stringWithFormat:@"英雄治疗：%@",[playerDetail.hero_healing stringValue]];
            NSString *hero_d = [NSString stringWithFormat:@"英雄对敌人伤害：%@",[playerDetail.hero_damage stringValue]];
            NSString *tower_d = [NSString stringWithFormat:@"英雄对防塔伤害：%@",[playerDetail.tower_damage stringValue]];
            NSString *gold_p = [NSString stringWithFormat:@"英雄每分钟经济：%@",[playerDetail.gold_per_min stringValue]];
            NSString *xp_p = [NSString stringWithFormat:@"英雄每分钟经验：%@",[playerDetail.xp_per_min stringValue]];
            
            cell.heroImage0.image = [UIImage imageNamed:hero];
            cell.hero_healingLabel.text = hero_h;
            cell.hero_damageLabel.text = hero_d;
            cell.tower_damageLabel.text = tower_d;
            cell.gold_per_minLabel.text = gold_p;
            cell.xp_per_minLabel.text = xp_p;

            [cell.contentView addSubview:cell.detailView];
        }else{
            [cell.detailView removeFromSuperview];
        }
        
        // NSLog(@"%@",self.itemRadiant);
    }
       
    
    if (indexPath.section == 1) {
        MYSplayer *player = self.tempdire[indexPath.row];
         MYSmatchPlayerDetails *playerDetail = self.itemdire[indexPath.row];
        //玩家头像
        [cell.playerImage sd_setImageWithURL:[NSURL URLWithString:player.avatarfull]placeholderImage:[UIImage imageNamed:@"pla"]];
        //玩家名字
        cell.nameLabel.text = player.personaname;
        //玩家等级
        NSString *lv = [NSString stringWithFormat:@"LV.%@",[playerDetail.level stringValue]];
        cell.lvLabel.text = lv;
        //玩家装备图
        [cell.itemImage0 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_0]]];
        [cell.itemImage1 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_1]]];
        [cell.itemImage2 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_2]]];
        [cell.itemImage3 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_3]]];
        [cell.itemImage4 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_4]]];
        [cell.itemImage5 sd_setImageWithURL:[NSURL URLWithString:[self itemNameWithID:playerDetail.item_5]]];
        
        
        //玩家个人击杀数
        NSString *kill = [NSString stringWithFormat:@"杀：%@",[playerDetail.kills stringValue]];
        cell.killLabel.text = kill;
        //玩家个人死亡数
        NSString *death = [NSString stringWithFormat:@"死：%@",[playerDetail.deaths stringValue]];
        cell.deathLabel.text = death;
        //玩家个人辅助数
        NSString *assists = [NSString stringWithFormat:@"辅：%@",[playerDetail.assists stringValue]];
        cell.assistsLabel.text = assists;
        //玩家个人经济数
        int gold_s = [playerDetail.gold_spent intValue];
        int gold = [playerDetail.gold intValue];
        int golds = gold_s+gold;
        NSString *g = [NSString stringWithFormat:@"经济：%d",golds];
        cell.goldLabel.text = g;
        //点击显示更多详情
        if (_isOpen && indexPath.row == _selectesIndex.row && indexPath.section == _selectesIndex.section) {
            NSString *hero = [NSString stringWithFormat:@"%@.jpg",[playerDetail.hero_id stringValue]];
            NSString *hero_h = [NSString stringWithFormat:@"英雄治疗：%@",[playerDetail.hero_healing stringValue]];
            NSString *hero_d = [NSString stringWithFormat:@"英雄对敌人伤害：%@",[playerDetail.hero_damage stringValue]];
            NSString *tower_d = [NSString stringWithFormat:@"英雄对防塔伤害：%@",[playerDetail.tower_damage stringValue]];
            NSString *gold_p = [NSString stringWithFormat:@"英雄每分钟经济：%@",[playerDetail.gold_per_min stringValue]];
            NSString *xp_p = [NSString stringWithFormat:@"英雄每分钟经验：%@",[playerDetail.xp_per_min stringValue]];
            
            cell.heroImage0.image = [UIImage imageNamed:hero];
            cell.hero_healingLabel.text = hero_h;
            cell.hero_damageLabel.text = hero_d;
            cell.tower_damageLabel.text = tower_d;
            cell.gold_per_minLabel.text = gold_p;
            cell.xp_per_minLabel.text = xp_p;
            
            [cell.contentView addSubview:cell.detailView];
        }else{
            [cell.detailView removeFromSuperview];
        }
        //NSLog(@"%@",self.itemdire);
    }

    
    return cell;
}
//单击cell时，cell处于展开状态，再次点击恢复原状。显示更多的战绩信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //单击cell时，设置isOpen为yes ，标志着cell已经被展开，否者设为no
    if (_isOpen && indexPath.row == _selectesIndex.row && indexPath.section == _selectesIndex.section) {
        _isOpen = NO;
         [_tableView reloadData];
    }else{
        _isOpen = YES;
    _selectesIndex = indexPath;
    [_tableView reloadData];
    }

}
//每组头部显示的内容。设置组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

     //阵营组总显示
    UIView *allView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MYSScreenW, tableView.sectionHeaderHeight)];
    allView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    
    CGFloat slotW = 50;
    CGFloat slotH = 35;
    
    CGFloat resultW = 35;
    CGFloat resultH = 35;
    
    CGFloat KDAW = 30;
    CGFloat KDAH = 10;
    
    CGFloat KDADataW = 20;
    CGFloat KDADataH = 10;
    NSInteger font = 10;
    //阵营显示
    UILabel *slot = [self createKDALabelWithFrame:CGRectMake(8, 45/2-slotH/2, slotW, slotH) Font:20 Text:nil];
    //胜负显示
    UILabel *result = [self createKDALabelWithFrame:CGRectMake(slotW+10, 45/2-slotH/2, resultW, resultH) Font:16 Text:nil];

    //阵营总杀人数
    UILabel *kill = [self createKDALabelWithFrame:CGRectMake(MYSScreenW-230, 45/2-KDAH/2, KDAW, KDAH) Font:font Text:@"杀："];
    //阵营总死亡数
    UILabel *deaths = [self createKDALabelWithFrame:CGRectMake(MYSScreenW-230+(KDAW+KDADataW), 45/2-KDAH/2, KDAW, KDAH) Font:font Text:@"死："];
    //阵营总辅助数
    UILabel *assists = [self createKDALabelWithFrame:CGRectMake(MYSScreenW-230+(KDAW+KDADataW)*2, 45/2-KDAH/2, KDAW, KDAH) Font:font Text:@"辅："];
    //阵营总花费数
    UILabel *gold = [self createKDALabelWithFrame:CGRectMake(MYSScreenW-230+(KDAW+KDADataW)*3, 45/2-KDAH/2, KDAW, KDAH) Font:font Text:@"经济："];


    //阵营组名，并判别胜败
    if (section == 0) {
        slot.textColor = [UIColor blueColor];
        slot.text = @"天辉";
        
        if (self.detail.radiant_win) {
            result.textColor = [UIColor blueColor];
            result.text = @"胜";
        }else{
            result.textColor = [UIColor redColor];
            result.text = @"败";
        }
        
    }else if(section == 1){
        slot.textColor = [UIColor redColor];
        slot.text = @"夜魇";
        
        if (!self.detail.radiant_win) {
            result.textColor = [UIColor blueColor];
            result.text = @"胜";
        }else{
            result.textColor = [UIColor redColor];
            result.text = @"败";
        }
    }
    //取出天辉各个玩家的杀，死，辅，经济数，求出总和
    if (section == 0) {
        int sumKill = 0;
        int sumDeath = 0;
        int sumAssists = 0;
        int sumGold = 0;
        
        for (int i = 0; i<10; i++) {
            
            MYSmatchPlayerDetails *playerDetail = _detail.player[i];
            int slot = [playerDetail.player_slot intValue];
            
            if (slot <= 4) {
                //转换数据
                int kill = [playerDetail.kills intValue];
                int death = [playerDetail.deaths intValue];
                int assists = [playerDetail.assists intValue];
                int gold_spent = [playerDetail.gold_spent intValue];
                int gold = [playerDetail.gold intValue];
                //求和
                sumKill += kill;
                sumDeath += death;
                sumAssists += assists;
                sumGold += gold_spent+gold;
            }
        }
        //阵营总杀人数
        UILabel *sumKillData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW, 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumKill]];
        
        UILabel *sumDeathData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW), 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumDeath]];
        
        UILabel *sumAssistsData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW)*2, 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumAssists]];
        
        UILabel *sumGoldData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW)*3, 45/2-KDAH/2, 50, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumGold]];
        
        //添加到View
        [allView addSubview:sumKillData];
        [allView addSubview:sumDeathData];
        [allView addSubview:sumAssistsData];
        [allView addSubview:sumGoldData];
        
    }
    //取出天辉各个玩家的杀，死，辅，经济数，求出总和
    if (section == 1) {
        int sumKill = 0;
        int sumDeath = 0;
        int sumAssists = 0;
        int sumGold = 0;
        
        for (int i = 0; i<10; i++) {
            
            MYSmatchPlayerDetails *playerDetail = _detail.player[i];
            int slot = [playerDetail.player_slot intValue];
            
            if (slot > 4) {
                //转换数据
                int kill = [playerDetail.kills intValue];
                int death = [playerDetail.deaths intValue];
                int assists = [playerDetail.assists intValue];
                int gold_spent = [playerDetail.gold_spent intValue];
                int gold = [playerDetail.gold intValue];
                //求和
                sumKill += kill;
                sumDeath += death;
                sumAssists += assists;
                sumGold += gold_spent+gold;
            }
        }
        
        //阵营总杀人数
        UILabel *sumKillData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW, 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumKill]];
        
        UILabel *sumDeathData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW), 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumDeath]];
        
        UILabel *sumAssistsData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW)*2, 45/2-KDAH/2, KDADataW, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumAssists]];
        
        UILabel *sumGoldData = [self createKDADataLabelWithFrame:CGRectMake(MYSScreenW-235+KDAW+(KDAW+KDADataW)*3, 45/2-KDAH/2, 50, KDADataH) Font:font Text:[NSString stringWithFormat:@"%d",sumGold]];
        
        //添加到View
        [allView addSubview:sumKillData];
        [allView addSubview:sumDeathData];
        [allView addSubview:sumAssistsData];
        [allView addSubview:sumGoldData];
        
    }

   
   //添加到View
    [allView addSubview:slot];
    [allView addSubview:result];
    [allView addSubview:kill];
    [allView addSubview:deaths];
    [allView addSubview:assists];
    [allView addSubview:gold];
    return allView;
}
//固定杀，死，辅，经济
-(UILabel *)createKDALabelWithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setFont:[UIFont boldSystemFontOfSize:font]];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    return label;
    
}
//数据总和杀，死，辅，经济
-(UILabel *)createKDADataLabelWithFrame:(CGRect)frame Font:(NSInteger)font Text:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    [label setFont:[UIFont boldSystemFontOfSize:font]];
    label.textAlignment = NSTextAlignmentCenter;
    [label setTextColor:[UIColor grayColor]];
    label.text = text;
    return label;
    
}

//设置组与组之间的间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}


#pragma mark 事件
//分享界面
-(void)share_match{
    
    MYSshareMatch *shareView = [MYSshareMatch menu];
    //添加到view
    [shareView show];

}



/**收回界面*/
-(void)dismissVc{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 数据获取
-(void)loadMatchDetail{
    //显示弹窗
    [MBProgressHUD showMessage:@"LOADING...."];
    //获取战绩详情
    AFHTTPRequestOperationManager *user = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"match_id"] = self.match_id;
    
    [user GET:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001" parameters:params
      success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         //NSLog(@"获取成功%@",responseObject);
         //数据转模型
         NSDictionary *result = responseObject[@"result"];
         MYSmatchDetails *detail = [[MYSmatchDetails alloc]matchDetailsWithDict:result];
         _detail = detail;
         
        
         for (int i = 0; i<10; i++) {

             
             MYSmatchPlayerDetails *playerDetail = _detail.player[i];
             [self loadPlayerDataWithAccountID:playerDetail.account_id Slot:playerDetail.player_slot];
             //转类型
             int playerSlot = [playerDetail.player_slot intValue];
             if(playerSlot <= 4){
                 [self.itemRadiant addObject:playerDetail];
                 

             }
             if(playerSlot > 4){
                 [self.itemdire addObject:playerDetail];
             }
                    
         }
         
        
         //创建标题栏数据
         [self createDetailTitleData];
         //提示框隐藏
         [MBProgressHUD hideHUD];
         //刷新tableView
         //[self.tableView reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         //提示框隐藏
         [MBProgressHUD hideHUD];
         
     }];

}

//加载玩家信息，头像，名称（同步请求）
-(void)loadPlayerDataWithAccountID:(NSNumber *)accountID Slot:(NSNumber *)slot{
    //字符串转换位整型
    int DotaID = [accountID intValue];
    //求出64位steamid
    long long int steam = DotaID + 76561197960265728;
    //steamid转换成NsNumber
    NSNumber *steamID = [NSNumber numberWithLongLong:steam];

    // 创建一个URL ：请求路径
    NSString *urlStr = [NSString stringWithFormat:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=%@&steamids=%@",@"D1586934B4121C02725F7D03D1CF16D4",steamID];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建一个请求，默认为GET请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 发送一个同步请求(在主线程发送请求)
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
   // NSLog(@"%@",responseObject);
    //解析获取的数据
    NSDictionary *response =responseObject[@"response"];
    NSArray *players = response[@"players"];
    static int i = 0;
    
    NSDictionary *dict = @{ @"avatarfull":@"1",@"personaname":@"匿名用户"};
    
    int playerSlot = [slot intValue];
    //把天辉队员模型数组加入临时数组
    if (playerSlot <= 4) {
        if (players.count == 0) {
            MYSplayer *player = [[ MYSplayer alloc]userWithDict:dict];
            [self.tempRadiant addObject:player];
        }else if(players.count != 0){
            NSDictionary *userData = players[0];
            MYSplayer *player = [[ MYSplayer alloc]userWithDict:userData];
            [self.tempRadiant addObject:player];
        }
        
        
    }
    //把夜魇队员模型数组加入临时数组
    if (playerSlot > 4) {
        
        if (players.count == 0 ) {
            MYSplayer *player = [[ MYSplayer alloc]userWithDict:dict];
            [self.tempdire addObject:player];
        }else if(players.count != 0){
            NSDictionary *userData = players[0];
            MYSplayer *player = [[ MYSplayer alloc]userWithDict:userData];
            [self.tempdire addObject:player];
        }
        
    }

    //如果请求数量达到一定，就刷新
    if(i == 9){
        [self.userArr addObject:_tempRadiant];
        [self.userArr addObject:_tempdire];
        [self.tableView reloadData];
        i=0;
        return ;
        
    }
    i++;
   
}
//创建详情页数据Label
-(void)createDetailTitleData{
    //开始时间
    UILabel *starTimeData = [[UILabel alloc]initWithFrame:CGRectMake(40, 70, 40, 30)];
    [starTimeData setTextColor:[UIColor grayColor]];
    starTimeData.font = [UIFont boldSystemFontOfSize:13.0f];
    //将数据转化成string
    double timeHM = [self.detail.start_time doubleValue];
    starTimeData.text = [self dateWithUnixTimeHM:timeHM];
    //时长
    UILabel *durationData = [[UILabel alloc]initWithFrame:CGRectMake(170, 70, 90, 30)];
    [durationData setTextColor:[UIColor grayColor]];
    durationData.font = [UIFont boldSystemFontOfSize:13.0f];
    //将数据转化成string
    double timeM = [self.detail.duration doubleValue];
    durationData.text = [self dateWithUnixTimeM:timeM];
    //比赛模式
    UILabel *lobby_typeData = [[UILabel alloc]initWithFrame:CGRectMake(300, 70, 80, 30)];
    [lobby_typeData setTextColor:[UIColor grayColor]];
    lobby_typeData.font = [UIFont boldSystemFontOfSize:13.0f];
    lobby_typeData.text = [self lobby_typeWithNum:self.detail.lobby_type];
    
    [_mask addSubview:starTimeData];
    [_mask addSubview:durationData];
    [_mask addSubview:lobby_typeData];
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
-(NSString *)dateWithUnixTimeHM:(double)time{
    //unix时间戳转正常时间格式；
    double unixTimeStamp =time;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
//转换时间
-(NSString *)dateWithUnixTimeM:(double)time{
    //unix时间戳转分钟时间格式；
   
    NSInteger sec = time/60;
    NSString *dateWith = [NSString stringWithFormat:@"%ld 分钟",sec];
    return dateWith;
}

-(NSString *)itemNameWithID:(NSNumber *)ID{
    
    int pID = [ID intValue];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:itemPath];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        MYSItems *item = [[MYSItems alloc]itemWithDict:dic];
        [items addObject:item];
    }

    for (int i = 0; i<items.count; i++) {
        MYSItems *item = items[i];
         int tID = [item.ID intValue];
        if (pID == tID) {
            //从item_后面开始截取
            NSRange range = [item.name rangeOfString:@"item_"];
            if (range.length != 0) {
                NSInteger fromIndex = range.location+range.length;
                NSString *name = [item.name substringFromIndex:fromIndex];
                NSString *url = [NSString stringWithFormat:@"http://cdn.dota2.com/apps/dota2/images/items/%@_lg.png",name];
               // NSLog(@"****%@",name);
                return url;
            }

        }
    }
    return 0;
}

@end
