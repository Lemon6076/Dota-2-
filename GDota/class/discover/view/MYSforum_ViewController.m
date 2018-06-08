//
//  MYSforum_ViewController.m
//  GDota
//
//  Created by lemon on 26/10/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSforum_ViewController.h"

@interface MYSforum_ViewController ()
@end

@implementation MYSforum_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改UIScrollView的内边距
    self.tableView.contentInset = UIEdgeInsetsMake(RTOP, 0, RBOTTOM, 0);
    //滚动条加内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;

}
//分组，不实现，默认为1
/*
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return  1;
 }
 */

// 设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

//设置单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //单元格重用
    static NSString *ID = @"cell";
    //每次去缓冲池中查看有没有ID标识的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果有，则创建一个ID标识的单元格
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置单元格内容
    NSString *str = [NSString stringWithFormat:@"Test_%@_%ld",self.class,indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = str;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"按下第%lu",indexPath.row);
//    模态窗口
//    MMYMess_1ViewController *mv1 = [[MMYMess_1ViewController alloc]init];
//    设置背景颜色
//    mv1.view.backgroundColor = [UIColor cyanColor];
//    创建按钮，带类型
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    设置按钮frame
//    btn.frame = CGRectMake(200, 200, 30, 30);
//    将按钮btn添加到mv1中
//    [mv1.view addSubview:btn];
//    添加按钮btn按钮事件
//    [btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
//    将控制器push到栈顶
//    [self.navigationController pushViewController:mv1 animated:YES];
}
@end
