//
//  MYSsupport_ViewController.m
//  GDota
//
//  Created by lemon on 3/11/17.
//  Copyright © 2017年 lemon. All rights reserved.
//

#import "MYSsupport_ViewController.h"

@interface MYSsupport_ViewController ()

@end

@implementation MYSsupport_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
}

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
    cell.textLabel.text = str;
    return cell;
}



@end
