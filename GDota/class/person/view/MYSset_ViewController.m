//
//  MYSset_ViewController.m
//  GDota
//
//  Created by lemon on 30/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSset_ViewController.h"
#import "MYSinputID_ViewController.h"

@interface MYSset_ViewController ()

@property (nonatomic , strong)UITableView *set;
@property (nonatomic , strong)NSArray *titles;

@end

@implementation MYSset_ViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    //设置内容title
    NSArray * section1= [[NSArray alloc]initWithObjects:@"当前账户",@"修改密码",@"消息推送", nil];
    NSArray * section2= [[NSArray alloc]initWithObjects:@"检查更新",@"反馈", nil];
    NSArray * section3= [[NSArray alloc]initWithObjects:@"退出登录", nil];
    self.titles = @[section1,section2,section3];
    
    self.view.backgroundColor = [UIColor whiteColor];
    //创建tableView
    [self createTableView];
    self.set.delegate = self;
    self.set.dataSource = self;
    //退出按钮和标题
    [self createExitButton];
    
}
/**创建退出和标题*/
-(void)createExitButton{
    CGFloat buttonWH = 50;
    MYSexitRound_Button *exit = [[MYSexitRound_Button alloc]initWithbackImage:@"return" ButtonWH:buttonWH Frame:CGRectMake(MYSScreenW/2-buttonWH/2, MYSScreenH-60, buttonWH, buttonWH)];
    MYSsetTilte_Label *title = [[MYSsetTilte_Label alloc]init];
    title.text = @"设  置";
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
    UITableView *set = [[UITableView alloc]init];
    set.frame = CGRectMake(0, 60, MYSScreenW, MYSScreenH-60);
    //隐藏分割线
    set.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.set = set;
   // set.contentInset = UIEdgeInsetsMake(50, 0, MYSScreenH-, 0);
    [self.view addSubview:set];
}
//设置组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}


// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *row = self.titles[section];
    return row.count;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    MYSset_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[MYSset_TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    NSArray *row = self.titles[indexPath.section];
    NSString *str = row[indexPath.row];
    //cell.backgroundColor = [UIColor whiteColor];
    if (indexPath.section == 2) {
        cell.exitLabel.text = str;
    }else{
    
        cell.titleLabel.text = str;
        
    if(indexPath.section == 0 && indexPath.row == 0){
        cell.detaiLabel.text = @"15107729706";
    }else{
    //设置拓展视图类型
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}
    
    
    return cell;
}
//设置组间隔
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
    return 0;
}
//点击cell事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //对应实现退出功能
    if (indexPath.section == 2) {
        //跳转主窗口
        MYSinputID_ViewController *login = [[MYSinputID_ViewController alloc]init];
        UIWindow *mainW = [UIApplication sharedApplication].keyWindow;
        mainW.rootViewController = login;
    }
}


@end
