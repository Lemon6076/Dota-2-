//
//  MYSinputID_ViewController.m
//  GDota
//
//  Created by lemon on 8/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSinputID_ViewController.h"


@interface MYSinputID_ViewController ()
/**输入ID*/
@property (nonatomic , strong) UITextField *inputID;
/**记住ID标记*/
@property (nonatomic , strong) UIButton *mark;

@end

@implementation MYSinputID_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景图
    [self setBackImage];
    //创建ID输入
    [self createInput];
    //创建进入按钮
    [self createComeBtn];
    //写入物品数据
    [self saveToplist];
    
}
//修改状态栏白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    //白色
    return UIStatusBarStyleLightContent;
    //黑色
    //return UIStatusBarStyleDefault;
}

-(void)setBackImage{
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dotalogin"]];
    image.frame = self.view.bounds;
    [self.view addSubview:image];
}

 //创建ID输入
-(void)createInput{
    CGFloat inputH = 35;
    CGFloat inputW = 200;
    UITextField *inputID = [[UITextField alloc]init];
    inputID.clearButtonMode = UITextFieldViewModeAlways;
    _inputID = inputID;
    
    if ([self readID].length != 0) {
        inputID.text = [self readID];
    }
    
    inputID.frame = CGRectMake(MYSScreenW/2-inputW/2, MYSScreenH/2, inputW, inputH);
    inputID.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.7f];
    inputID.font = [UIFont  boldSystemFontOfSize:16.0f];
    inputID.placeholder = @"请输入Dota2ID";
    inputID.textAlignment = NSTextAlignmentCenter;
    inputID.keyboardType = UIKeyboardTypeNumberPad;
    //弧度
    inputID.layer.cornerRadius = 10;
    
    [self.view addSubview:inputID];
    
}
//创建进入按钮
-(void)createComeBtn{
    CGFloat btnH = 30;
    CGFloat btnW = 60;
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(MYSScreenW/2-btnW/2, MYSScreenH/2+40, btnW, btnH);
    [btn setTitle:@"进  入" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont  boldSystemFontOfSize:14.0f];
    btn.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.7f];
    btn.layer.cornerRadius = 15;
    [btn addTarget:self action:@selector(checkID) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}
//记住ID
-(void)createRememberID{
   // _isRemember = NO;
    
    CGFloat underH = 15;
    CGFloat underW = 70;
    UIView *under = [[UIView alloc]initWithFrame:CGRectMake(MYSScreenW/2-underW/2, MYSScreenH/2+75, underW, underH)];
    //under.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelW = underW-underH;
    UIButton *mark = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, underH, underH)];
    mark.backgroundColor = [UIColor whiteColor];
    _mark = mark;
    
    UILabel *hint = [[UILabel alloc]initWithFrame:CGRectMake(underH, 0, labelW, underH)];
    [hint setFont:[UIFont boldSystemFontOfSize:14.0f]];
    hint.text = @"记住 ID";
    hint.textAlignment = NSTextAlignmentCenter;
    
    UIButton *cover = [[UIButton alloc]initWithFrame:under.frame];
    //[cover addTarget:self action:@selector(writeID) forControlEvents:UIControlEventTouchUpInside];
    
    [under addSubview:mark];
    [under addSubview:hint];
    
    [self.view addSubview:under];
    [self.view addSubview:cover];
}

//进入后验证id
-(void)checkID{
    /*
     http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/   获取个人信息
     */
    if (_inputID.text.length)
    {
        [MBProgressHUD showMessage:@"LOADING...."];
    
    //字符串转换位整型
    int DotaID = [_inputID.text intValue];
    //求出64位steamid
    long long int steam = DotaID + 76561197960265728;
    //steamid转换成NsNumber
    NSNumber *steamID = [NSNumber numberWithLongLong:steam];
    
    //获取个人信息
    AFHTTPRequestOperationManager *user = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    params[@"steamids"] = steamID;
    
    [user GET:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/" parameters:params
      success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
         //去除加载窗口
         [MBProgressHUD hideHUD];
         // NSLog(@"获取成功%@",responseObject);
         NSDictionary *response =responseObject[@"response"];
         NSArray *players = response[@"players"];
         //NSLog(@"%@",userPath);
         
         if (players.count != 0) {//如果验证我账号存在，开放数据，进入主窗口
             
             NSDictionary *userData = players[0];
             //将输入正确的ID写入文件，再将个人数据写入文件
             NSString *ID = _inputID.text;
             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
             [dict setObject:ID forKey:@"ID"];
             [dict writeToFile:IDPath atomically:YES];
             [userData writeToFile:userPath atomically:YES];
             
             //跳转主窗口
             UIWindow *mainW = [UIApplication sharedApplication].keyWindow;
             [mainW showRootWindow];
             
         }else{//否者弹出提示框确认
             [self hintWindowsWithHint:@"提示" content:@"请再确认一下您的ID，或者您未开放权限！"];
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //去除加载窗口
         [MBProgressHUD hideHUD];
         //弹出提示窗口
         [self hintWindowsWithHint:@"提示" content:@"网络可能不太好，再试试吧！" ];
         NSLog(@"获取失败");
         
     }];
    
    }else{
        //弹出警告窗口
        [self hintWindowsWithHint:@"警告" content:@"ID不能为空！"];
    }

}


-(void)saveToplist{
    //创建一个管理理对象
    AFHTTPRequestOperationManager *item = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"key"] = @"D1586934B4121C02725F7D03D1CF16D4";
    /*
     *物品信息：https://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001/?key=< key >
     */
    //获取物品信息
    
    [item GET:@"https://api.steampowered.com/IEconDOTA2_570/GetGameItems/V001/" parameters:params
     success:^
     (AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"获取成功：%@",responseObject);
         NSDictionary *result = responseObject[@"result"];
         NSArray *items = result[@"items"];
         
         [items writeToFile:itemPath atomically:YES];

     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"获取失败");
         
     }];
    
}

/**
 *  创建弹窗
 *
 *  @param hint    标题
 *  @param content 提示内容
 */
-(void)hintWindowsWithHint:(NSString *)hint content:(NSString *)content{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:hint message:content delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}
//点击View收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.view endEditing:YES];
}


-(NSString *)readID{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:IDPath];
    NSString *ID = dict[@"ID"];
    return ID;
}
@end
